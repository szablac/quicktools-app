# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz (PLAT-001 KÉSZ), TOOL-001 fejlesztve, deploy hátravan |
| Aktív feladat | TOOL-001 – Favicon Generator (kód+teszt kész, éles deploy még nem történt meg) |
| Állapot | Helyi teszt sikeres: ZIP-csomag helyesen generálódik (favicon.ico + 5 PNG + webmanifest + snippet) |
| Kiemelt következő feladat | Push → cPanel Git pull → npm install (multer, jimp, png-to-ico, archiver miatt) → restart → migráció 002 lefuttatása phpMyAdmin-ban → élő ellenőrzés |
| Aktuális kódmódosítás | `server.js` (POST `/api/tools/favicon-generator/generate`), `public/favicon-generator.html`, `public/en/favicon-generator.html`, `public/index.html`+`en/index.html` (dinamikus tool-lista), `db/migrations/002_seed_favicon_generator.sql` |
| Blokkoló | – (Google AdSense felülvizsgálat még fut a háttérben, MON-001, nem blokkol) |
| Utolsó tartós döntés | Favicon Generator: sima HTML+JS (nem Vue), jimp+png-to-ico+archiver (natív bináris nélküli csomagok, a Prisma-tanulság alapján) |

## Következő pontos lépések

1. Commit + push a TOOL-001 kódra.
2. cPanel: Git pull → **Run NPM Install** (új függőségek: multer, jimp, png-to-ico, archiver) → Restart.
3. `db/migrations/002_seed_favicon_generator.sql` lefuttatása phpMyAdmin-ban (regisztrálja a toolt a `tools` táblában).
4. Élő ellenőrzés: `https://quicktools.qwer.hu/favicon-generator.html` betöltődik, feltöltött képre ZIP-et ad vissza; a főoldal `/api/tools` alapján megjeleníti a linket.
5. Amint a Google AdSense dönt, a hirdetéskód beillesztése (MON-001), utána MON-002 (quicktools.qwer.hu külön webhelyként).

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **PLAT-001 fejlesztés**: felhasználó jóváhagyta a kódolást. `tools` tábla létrehozva phpMyAdmin-ban. `server.js` mysql2-pool + `GET /api/tools` végponttal bővítve, helyi teszttel igazolva a biztonságos hibaválasz.
- **cPanel Git pull megbízhatatlansága**: a „Pull" első nekifutásra nem hozta be a legfrissebb commitot (HEAD elmaradt) — a **„Update from Remote"** gomb (nem a „Deploy HEAD Commit") a tényleges pull; ezt tudatosítani kell a jövőbeli deploy-köröknél.
- **`/api/tools` `ER_ACCESS_DENIED_ERROR` — megoldva**: a `DB_USER` env változó `szablac_qt_app` volt, de a cPanel MySQL-felület a fióknevet **duplán** prefixelte a felhasználónév létrehozásakor, a valódi név `szablac_szablac_qt_app` lett. Miután a `DB_USER`-t erre javítottuk, élesben is `[]`-t ad az `/api/tools`. A buktató dokumentálva: `docs/12_DATABASE_AND_MIGRATIONS.md`. Az ideiglenes debug-kód (`debug_code`/`debug_message` a hibaválaszban) el lett távolítva a kódból, de a commit/push/deploy még hátravan.

## Aktuális munkafájlok

- `server.js` – debug-kód eltávolítva (biztonságos generikus hibaválasz), commit/push/deploy még hátravan
- `db/migrations/001_create_tools_table.sql` – lefuttatva éles DB-n
- `docs/12_DATABASE_AND_MIGRATIONS.md` – DB-user duplaprefix buktató dokumentálva
- `docs/10_BACKLOG.md` – PLAT-001 → DONE

## Ellenőrzési állapot

- `https://quicktools.qwer.hu/api/tools` élesben `[]`-t ad, DB-kapcsolat működik.
- A debug-kód eltávolítás utáni újbóli élő ellenőrzés **még hátravan** (lásd Következő pontos lépések).
