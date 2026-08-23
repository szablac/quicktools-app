# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001/002/003 KÉSZ; PROD-002 KÉSZ; OPS-001 KÉSZ |
| Aktív feladat | – (nincs kijelölt aktív tétel) |
| Állapot | Az `/api` middleware élesben igazolva: `GET /api/tools` és `POST /api/contact` is `no-store`-t küld; statikus HTML-oldalak fejléce változatlan |
| Kiemelt következő feladat | Döntés kell: következő tool, vagy MON-001/002 (AdSense) folytatása |
| Aktuális kódmódosítás | – (minden pusholva és deployolva: `e1b7954`, `c2b335e`, `5545ffb`) |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-011 (2026-08-23) — cache-fejléc middleware Node-oldalon, nem Apache/`.htaccess`-szinten |

## Következő pontos lépések

1. Döntés kell a felhasználótól: következő tool, vagy MON-001/MON-002 (AdSense-folytatás).
2. Amint a Google AdSense dönt, a hirdetéskód beillesztése (MON-001).
3. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **PROD-002 lezárva**: kapcsolatfelvételi űrlap (`POST /api/contact`, honeypot + rate-limit, `contact_messages` tábla) élesben ellenőrizve, egy `utf8mb4` kódolási hiba felfedezve és javítva.
- **OPS-001 részletes átbeszélése és implementáció**: a felhasználó kérésére élő `curl -I` vizsgálattal pontosítottuk az eredeti feltételezést (statikus HTML-re nincs élő gond, a valódi kockázat jövőbeli dinamikus GET-végpontoknál van). Megoldás: `/api` Express middleware, ami minden API-válaszra egységesen `no-store`-t tesz (ADR-011).
- **OPS-001 élő igazolás**: commit `5545ffb`, push, cPanel Pull+Restart, majd `curl -I` mindkét érintett végponton (`/api/tools`, `/api/contact`) megerősítette a `no-store` jelenlétét; statikus HTML fejléce nem változott. Backlog és decisions-doksi frissítve, OPS-001 → `DONE`.

## Aktuális munkafájlok

- `server.js` – `/api` middleware (`Cache-Control: no-store`), élesben ellenőrizve

## Ellenőrzési állapot

- `https://quicktools.qwer.hu/api/tools` és `.../api/contact` élesben `curl -I`-vel igazolva: `no-store` jelen van.
- `https://quicktools.qwer.hu/adatvedelem.html` fejléce nem változott a middleware bevezetése után (nincs regresszió).
