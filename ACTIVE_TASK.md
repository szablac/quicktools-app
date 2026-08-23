# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001 KÉSZ; vizuális design (ADR-008, Soft Calm) élesben |
| Aktív feladat | – (TOOL-003 Termékfotó Optimalizáló lezárva, élesben ellenőrizve) |
| Állapot | Claude Design canvasban 7 irány (3 techno, elvetve + 3 modern + 1 hibrid) bemutatva; felhasználó az **F — Soft Calm** irányt választotta; beépítve az élő oldalba, ellenőrizve |
| Kiemelt következő feladat | Nincs kijelölt aktív tétel — döntés kell: következő tool, vagy OPS-001 (cache-stratégia), vagy MON-001/002 (AdSense) |
| Aktuális kódmódosítás | – (minden pusholva és deployolva) |
| Blokkoló | – (Google AdSense felülvizsgálat még fut a háttérben, MON-001, nem blokkol) |
| Utolsó tartós döntés | ADR-008 — Soft Calm design irány, tudatosan ideiglenes/iterálható több tool megléte után |

## Következő pontos lépések

1. Döntés kell a felhasználótól: következő tool, OPS-001 (cache-frissülési stratégia), vagy MON-001/MON-002 (AdSense-folytatás).
2. Amint a Google AdSense dönt, a hirdetéskód beillesztése (MON-001), utána MON-002 (quicktools.qwer.hu külön webhelyként).
3. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `/api/tools` végpont ellenőrzésekor kiderült, hogy a cPanel/Apache szintjén van egy alapértelmezett `max-age=172800` (2 nap) cache-irányelv, amit a Node-kód `no-store`-ja nem tud teljesen felülírni — ez a **visszatérő** látogatóknál késleltetheti a statikus tartalom frissülését jövőbeli deploy-oknál. Felvéve: OPS-001 (`docs/10_BACKLOG.md`).

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **`/api/tools` `ER_ACCESS_DENIED_ERROR` — megoldva**: a `DB_USER` env változó `szablac_qt_app` volt, de a cPanel MySQL-felület a fióknevet duplán prefixelte, a valódi név `szablac_szablac_qt_app`. Javítva, dokumentálva (`docs/12_DATABASE_AND_MIGRATIONS.md`), debug-kód eltávolítva és deployolva.
- **TOOL-001 fejlesztés (Favicon Generator)**: felhasználó jóváhagyta a sima HTML+JS irányt (Vue elhalasztva). Két csomag-API-kompatibilitási hibát találtam és javítottam helyi teszt közben (`png-to-ico` és `archiver` v8 más export-formátumot használ, mint a dokumentációjuk klasszikus példája). Migráció (002) regisztrálja a toolt a `tools` táblában.
- **Élő ellenőrzés + cache-felfedezés**: a feltöltés→ZIP-letöltés folyamat élesben (`curl`-lal) igazolva, működik. Menet közben kiderült, hogy a cPanel/Apache réteg egy `max-age=172800` cache-irányelvet ad hozzá minden váloszhoz, amit a Node `no-store` fejléce nem tud teljesen felülírni — ez valódi (nem teszt-)felhasználóknál is késleltetheti a jövőbeli frissülések megjelenését. Felvéve OPS-001-ként a backlogba.

## Aktuális munkafájlok

- `server.js` – `/api/tools/favicon-generator/generate` végpont, `no-store` cache fejléc
- `public/favicon-generator.html`, `public/en/favicon-generator.html` – éles, működő tool-oldalak
- `db/migrations/002_seed_favicon_generator.sql` – lefuttatva éles DB-n

## Ellenőrzési állapot

- `https://quicktools.qwer.hu/api/tools` élesben helyesen listázza a Favicon Generatort.
- `https://quicktools.qwer.hu/api/tools/favicon-generator/generate` élesben, valódi képfeltöltéssel tesztelve (`curl`): helyes 8 fájlos ZIP-et ad vissza.
- Felhasználó saját böngészőjében is megerősítette: a főoldal helyesen mutatja a Favicon Generátor linket.
