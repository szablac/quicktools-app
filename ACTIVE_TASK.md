# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001/002/003 KÉSZ; PROD-002 (kapcsolattartási elérhetőség) KÉSZ; vizuális design (ADR-008, Soft Calm) élesben |
| Aktív feladat | – (PROD-002 lezárva, nincs kijelölt aktív tétel) |
| Állapot | A kapcsolatfelvételi űrlap élesben ellenőrizve: érvényes/érvénytelen/honeypot eset, HU+EN hibaüzenet, `utf8mb4` kódolási hiba javítva és igazolva (ékezetes teszt-üzenet helyesen került be). Teszt-sorok törlésre jelölve a felhasználó által. |
| Kiemelt következő feladat | Nincs kijelölt aktív tétel — döntés kell: következő tool, OPS-001 (cache-stratégia), vagy MON-001/002 (AdSense) folytatása |
| Aktuális kódmódosítás | – (minden pusholva és deployolva: `e1b7954` + `c2b335e`) |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-009 frissítve (2026-08-23) — a kiírt email helyett saját, DB-be mentő űrlap zárja le a kapcsolattartási kockázatot; PROD-002 `DONE` |

## Következő pontos lépések

1. Döntés kell a felhasználótól: következő tool, OPS-001 (cache-frissülési stratégia), vagy MON-001/MON-002 (AdSense-folytatás).
2. Amint a Google AdSense dönt, a hirdetéskód beillesztése (MON-001).
3. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `/api/tools` végpont ellenőrzésekor kiderült, hogy a cPanel/Apache szintjén van egy alapértelmezett `max-age=172800` (2 nap) cache-irányelv, amit a Node-kód `no-store`-ja nem tud teljesen felülírni — ez a **visszatérő** látogatóknál késleltetheti a statikus tartalom frissülését jövőbeli deploy-oknál. Felvéve: OPS-001 (`docs/10_BACKLOG.md`).

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **PROD-002 implementáció**: `POST /api/contact` végpont (honeypot mező + IP-alapú rate-limit, `express.json()` middleware), `contact_messages` tábla migrációja (006), HU/EN adatvédelmi oldalak kibővítve a formmal. Commit `e1b7954`, push, phpMyAdmin migráció, cPanel Pull+Restart — élesben ellenőrizve (`node --check`, majd curl-lal érvénytelen/érvényes/honeypot eset és HU/EN hibaüzenet).
- **Kódolási hiba felfedezve és javítva**: az élő ellenőrzés közben kiderült, hogy az ékezetes karakterek (`ü`, `ő`, `é`) torzultak a `contact_messages` táblában — a `mysql2` pool nem adott meg explicit charsetet. Javítva: `charset: 'utf8mb4'` a pool configban (`server.js`). Commit `c2b335e`, push, cPanel Pull+Restart.
- **Javítás igazolása**: fájlból küldött (garantáltan tiszta UTF-8) teszt-üzenettel megerősítve, hogy a javítás után az ékezetes szöveg helyesen kerül be a táblába. A 2. sor korábbi torzulása a saját curl-teszt parancssori kódolási mellékhatása volt, nem szerverhiba. A 3 teszt-sor (`id` 1–3) törlésre lett jelölve, a felhasználó törli phpMyAdminban.

## Aktuális munkafájlok

- `server.js` – `POST /api/contact` végpont (honeypot + rate-limit) + `charset: 'utf8mb4'` a mysql2 poolon
- `public/adatvedelem.html`, `public/en/privacy.html` – kapcsolatfelvételi űrlap + frissített „Adatkezelő”/„Érintetti jogok” szöveg
- `db/migrations/006_create_contact_messages_table.sql` – lefuttatva élesben

## Ellenőrzési állapot

- `https://quicktools.qwer.hu/api/contact` élesben tesztelve: érvénytelen email → 400 + HU/EN hibaüzenet; érvényes beküldés → `{"ok":true}` + DB-sor; honeypot mező kitöltve → `{"ok":true}`, de nincs DB-beszúrás.
- Ékezetes (magyar) szöveg torzulás nélkül kerül be a táblába a `utf8mb4` javítás után (phpMyAdminban vizuálisan igazolva).
- `adatvedelem.html`/`en/privacy.html` élő oldalon még nem lett böngészőből, valódi felhasználói interakcióval kitöltve (csak API-szinten, curl-lal) — ha szükséges, ez egy gyors kiegészítő ellenőrzés lehet később.
