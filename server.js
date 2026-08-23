const express = require('express');
const path = require('path');
const mysql = require('mysql2/promise');
const multer = require('multer');
const { Jimp, JimpMime } = require('jimp');
const pngToIco = require('png-to-ico').default;
const { ZipArchive } = require('archiver');
const geoip = require('geoip-lite');

const app = express();

const LANG_COOKIE = 'qt_lang';
const LANG_COOKIE_MAX_AGE = 60 * 60 * 24 * 365; // 1 év

function getLangCookie(req) {
  const header = req.headers.cookie || '';
  const match = header.match(/(?:^|;\s*)qt_lang=(hu|en)/);
  return match ? match[1] : null;
}

function setLangCookie(res, lang) {
  res.append(
    'Set-Cookie',
    `${LANG_COOKIE}=${lang}; Max-Age=${LANG_COOKIE_MAX_AGE}; Path=/; SameSite=Lax; Secure; HttpOnly`
  );
}

// Első látogatáskor (amíg a felhasználó nem választott kézzel nyelvet — ezt a
// `qt_lang` cookie jelzi) az IP-cím alapján magyar/külföldi látogatót különböztetünk
// meg: nem magyar országkód esetén átirányítunk az angol nyelvű kezdőlapra.
// Ismeretlen/fel nem ismerhető IP-nél (pl. helyi teszt) a magyar oldal marad az
// alapértelmezett, mivel a célközönség elsődlegesen magyar (docs/01_PROJECT_FOUNDATIONS.md).
app.get('/', (req, res, next) => {
  if (getLangCookie(req)) return next();

  const ip = (req.headers['x-forwarded-for'] || '').split(',')[0].trim() || req.socket.remoteAddress;
  const geo = geoip.lookup(ip);

  if (geo && geo.country && geo.country !== 'HU') {
    setLangCookie(res, 'en');
    return res.redirect(302, '/en/');
  }

  setLangCookie(res, 'hu');
  next();
});

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json({ limit: '10kb' }));

// Az Apache/Passenger réteg minden választ megtold egy saját Cache-Control/Expires
// fejléccel (MIME-típus szerinti alapértelmezés, nem-HTML válaszra jellemzően 2 nap) —
// ez a dinamikus API-válaszokra nem kívánatos, ezért itt egységesen felülírjuk (OPS-001).
app.use('/api', (req, res, next) => {
  res.set('Cache-Control', 'no-store');
  next();
});

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  charset: 'utf8mb4',
  waitForConnections: true,
  connectionLimit: 5,
});

app.get('/api/tools', async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT slug, name_hu, name_en, description_hu, description_en, category FROM tools WHERE is_active = 1 ORDER BY name_hu'
    );
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Hiba történt az eszközlista lekérésekor.' });
  }
});

const CONTACT_RATE_LIMIT = { windowMs: 60 * 60 * 1000, max: 5 };
const contactRateLimitHits = new Map();

function isContactRateLimited(ip) {
  const now = Date.now();
  const recent = (contactRateLimitHits.get(ip) || []).filter(
    (t) => now - t < CONTACT_RATE_LIMIT.windowMs
  );
  recent.push(now);
  contactRateLimitHits.set(ip, recent);
  return recent.length > CONTACT_RATE_LIMIT.max;
}

const CONTACT_EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

const CONTACT_MESSAGES = {
  hu: {
    invalid: 'Kérjük, adj meg egy érvényes email címet és egy legalább 5 karakteres üzenetet.',
    tooLong: 'A megadott szöveg túl hosszú.',
    rateLimited: 'Túl sok kérés érkezett erről a címről, kérjük próbáld újra később.',
    error: 'Hiba történt az üzenet elküldésekor. Kérjük, próbáld újra később.',
  },
  en: {
    invalid: 'Please provide a valid email address and a message of at least 5 characters.',
    tooLong: 'The submitted text is too long.',
    rateLimited: 'Too many requests from this address, please try again later.',
    error: 'Something went wrong while sending your message. Please try again later.',
  },
};

app.post('/api/contact', async (req, res) => {
  const lang = req.body && req.body.lang === 'en' ? 'en' : 'hu';
  const t = CONTACT_MESSAGES[lang];
  const { name, email, message, website } = req.body || {};

  if (website) {
    // honeypot mező: csak botok töltik ki, valós felhasználó nem látja — csendben nyugtázzuk
    return res.json({ ok: true });
  }

  const ip = (req.headers['x-forwarded-for'] || '').split(',')[0].trim() || req.socket.remoteAddress;
  if (isContactRateLimited(ip)) {
    return res.status(429).json({ error: t.rateLimited });
  }

  if (
    typeof email !== 'string' ||
    !CONTACT_EMAIL_RE.test(email) ||
    typeof message !== 'string' ||
    message.trim().length < 5
  ) {
    return res.status(400).json({ error: t.invalid });
  }
  if (email.length > 255 || message.length > 4000 || (name && String(name).length > 120)) {
    return res.status(400).json({ error: t.tooLong });
  }

  try {
    await pool.query('INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)', [
      name ? String(name).trim().slice(0, 120) : null,
      email.trim(),
      message.trim(),
    ]);
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: t.error });
  }
});

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 5 * 1024 * 1024 },
  fileFilter: (req, file, cb) => {
    const allowed = ['image/png', 'image/jpeg', 'image/webp', 'image/gif'];
    cb(null, allowed.includes(file.mimetype));
  },
});

const FAVICON_SIZES = [16, 32, 180, 192, 512];

app.post('/api/tools/favicon-generator/generate', upload.single('image'), async (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'Nem érkezett kép, vagy a formátum nem támogatott (PNG, JPEG, WEBP, GIF).' });
  }

  try {
    const source = await Jimp.read(req.file.buffer);

    const pngBuffers = {};
    for (const size of FAVICON_SIZES) {
      const resized = source.clone().cover({ w: size, h: size });
      pngBuffers[size] = await resized.getBuffer(JimpMime.png);
    }

    const icoSource = source.clone().cover({ w: 256, h: 256 });
    const icoBuffer = await pngToIco(await icoSource.getBuffer(JimpMime.png));

    const webmanifest = JSON.stringify(
      {
        name: 'App',
        icons: [
          { src: 'android-chrome-192x192.png', sizes: '192x192', type: 'image/png' },
          { src: 'android-chrome-512x512.png', sizes: '512x512', type: 'image/png' },
        ],
        theme_color: '#ffffff',
        background_color: '#ffffff',
        display: 'standalone',
      },
      null,
      2
    );

    const htmlSnippet = [
      '<link rel="icon" type="image/x-icon" href="/favicon.ico">',
      '<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">',
      '<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">',
      '<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">',
      '<link rel="manifest" href="/site.webmanifest">',
    ].join('\n');

    res.setHeader('Content-Type', 'application/zip');
    res.setHeader('Content-Disposition', 'attachment; filename="favicon-package.zip"');

    const archive = new ZipArchive({ zlib: { level: 9 } });
    archive.on('error', (err) => {
      console.error(err);
      if (!res.headersSent) {
        res.status(500).json({ error: 'Hiba történt a csomag összeállításakor.' });
      }
    });
    archive.pipe(res);

    archive.append(icoBuffer, { name: 'favicon.ico' });
    archive.append(pngBuffers[16], { name: 'favicon-16x16.png' });
    archive.append(pngBuffers[32], { name: 'favicon-32x32.png' });
    archive.append(pngBuffers[180], { name: 'apple-touch-icon.png' });
    archive.append(pngBuffers[192], { name: 'android-chrome-192x192.png' });
    archive.append(pngBuffers[512], { name: 'android-chrome-512x512.png' });
    archive.append(webmanifest, { name: 'site.webmanifest' });
    archive.append(htmlSnippet, { name: 'html-snippet.txt' });

    await archive.finalize();
  } catch (err) {
    console.error(err);
    if (!res.headersSent) {
      res.status(500).json({ error: 'Hiba történt a favicon generálásakor. Ellenőrizd, hogy a feltöltött fájl érvényes kép-e.' });
    }
  }
});

app.listen();
