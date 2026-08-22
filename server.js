const express = require('express');
const path = require('path');
const mysql = require('mysql2/promise');
const multer = require('multer');
const { Jimp, JimpMime } = require('jimp');
const pngToIco = require('png-to-ico').default;
const { ZipArchive } = require('archiver');

const app = express();

app.use(express.static(path.join(__dirname, 'public')));

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 5,
});

app.get('/api/tools', async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT slug, name_hu, name_en, category FROM tools WHERE is_active = 1 ORDER BY name_hu'
    );
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Hiba történt az eszközlista lekérésekor.' });
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
