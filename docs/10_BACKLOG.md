# 10 – Kanonikus backlog

## Állapotok

- `TODO` – még nem kezdődött el.
- `READY` – minden előfeltétel megvan, kezdhető.
- `IN_PROGRESS` – aktív munka.
- `BLOCKED` – döntés vagy külső feltétel hiányzik.
- `VERIFY` – elkészült, ellenőrzésre vár.
- `DONE` – elfogadási feltételekkel igazolt.
- `DEFERRED` – tudatosan későbbre halasztva.

## Prioritás

- `P0` – kritikus: adatbiztonság, hozzáférés, adatintegritás vagy alapvető fejlesztési biztonság.
- `P1` – karbantarthatóság, konzisztencia, középtávú stabilitás.
- `P2` – UX, optimalizálás, termékminőség.

> A P0/P1/P2 elnevezés szabadon átnevezhető/átdefiniálható a projekt igénye szerint – csak legyen egyetlen, következetesen használt prioritás-skála.

## Logikai végrehajtási sorrend

| Sorrend | ID | Prioritás | Állapot | Rövid leírás | Függőség |
|---:|---|---|---|---|---|
| 0 | INFRA-001 | P0 | `DONE` | Aldomain + adatbázis + Node.js App + git deploy pipeline felállítása | – |
| 1 | PROD-001 | P1 | `DONE` | Monetizációs modell pontosítása → átmeneti döntés: Google AdSense (ADR-007) | – |
| 2 | MON-001 | P1 | `VERIFY` | Google AdSense fiók regisztrálva (`qwer.hu` alá, `ads.txt`-vel igazolva), fiók-profil (fizetési cím, telefonszám) kész, webhely csatlakoztatva — Google belső felülvizsgálatára vár | landing oldal + adatvédelmi tájékoztató (kész) |
| 3 | MON-002 | P2 | `DEFERRED` | ~~`quicktools.qwer.hu` külön webhelyként~~ — kiderült, hogy ez az AdSense-felület **domain-szinten**, nem aldomain-szinten kezeli a „Webhelyek" listát (`qwer.hu` az egyetlen sor, a `quicktools.qwer.hu` automatikusan alá tartozik, önálló hozzáadása nem lehetséges). Ha a bevétel-jelentés aldomain-bontása mégis fontossá válik, a Jelentések (Reports) oldal URL-szűrését kell megnézni. | – |
| 3 | PLAT-001 | P1 | `DONE` | Tool-regisztrációs keret: `tools` tábla + `GET /api/tools` végpont (fiók/előfizetés elhalasztva, DR-001) | roadmap Fázis 1 |
| 4 | TOOL-001 | P2 | `DONE` | Favicon Generator megvalósítva (backend + HU/EN frontend), élesben ellenőrizve (feltöltés → ZIP-letöltés működik) | PLAT-001 (kész) |
| 5 | OPS-001 | P2 | `DONE` | Cache-frissülési stratégia: élő fejléc-vizsgálat kiderítette, hogy statikus HTML-re a Node (`max-age=0`) és az Apache-alapértelmezés már egyezik (nincs élő gond), de nem-HTML dinamikus válaszokra (pl. JSON) az Apache mindig hozzáfűz egy saját `max-age=172800` fejlécet a Node fejléce *mellé* (nem helyette) — egy `/api` middleware minden API-válaszra egységesen `no-store`-t tesz; élesben igazolva `GET /api/tools`-on és `POST /api/contact`-on is | – |
| 6 | PROD-002 | **P0** | `DONE` | Kapcsolattartási elérhetőség: saját, DB-be mentő kapcsolatfelvételi űrlap (`POST /api/contact`, honeypot + rate-limit, nincs kimenő email) az adatvédelmi tájékoztatóban (HU+EN), nyilvános email cím nélkül — élesben ellenőrizve (érvénytelen/érvényes/honeypot eset, HU+EN hibaüzenet, `utf8mb4` kódolás javítva és igazolva) | domain véglegesítés vagy MON-001 jóváhagyás |
| 7 | TOOL-002 | P2 | `DONE` | JSON Viewer megvalósítva (teljesen kliens-oldali, backend nélkül), élesben ellenőrizve | PLAT-001 (kész) |
| 8 | TOOL-003 | P2 | `DONE` | Termékfotó Optimalizáló megvalósítva (teljesen kliens-oldali, Canvas API), élesben ellenőrizve | PLAT-001 (kész) |
| 9 | TOOL-004 | P2 | `DONE` | PDF Oldal Kiválasztó megvalósítva (teljesen kliens-oldali, `pdf-lib` + `pdfjs-dist` CDN-ről, megtartás/eltávolítás mód), élesben ellenőrizve (`/api/tools` listázza, HU+EN oldal 200-at ad) | PLAT-001 (kész) |
| 10 | UX-001 | P2 | `DONE` | Feltöltő doboz (dropzone) egységes, beszédesebb megjelenítése mindhárom fájlfeltöltős toolban (Favicon Generator, Termékfotó Optimalizáló, PDF Oldal Kiválasztó): ikon + kiemelt "Fájl kiválasztása" gomb-szerű elem. Menet közben egy valódi CSS-hibát is feltárt és javított (ld. ADR-012), élesben igazolva. | TOOL-001, TOOL-003 (kész), TOOL-004 |

## Kiemelt feladatok elfogadási feltételei

### INFRA-001

- [x] `quicktools.qwer.hu` HTTPS-en elérhető, érvényes SSL-tanúsítvánnyal
- [x] `szablac_quicktools` adatbázis és DB-user létrehozva
- [x] Node.js App fut Passenger alatt, `server.js` válaszol
- [x] Git-alapú deploy működik (GitHub → cPanel Git Version Control pull)
- [x] Smoke-teszt szerver élesben visszaadja a várt választ

### PLAT-001

- [x] `db/migrations/001_create_tools_table.sql` lefuttatva phpMyAdmin-ban, ellenőrző lekérdezéssel igazolva
- [x] `server.js` mysql2-connection poollal kapcsolódik a DB-hez (env változókból)
- [x] `GET /api/tools` végpont válaszol (üres tömb, amíg nincs feltöltött tool) — élesben ellenőrizve: `[]`
- [x] Nyers SQL-/stack-hiba nem szivárog ki a kliens felé hibaválaszban

> Vue frontend alapváz és fiók-keret **nem** része ennek a tételnek — lásd `docs/04_DOMAIN_RULES.md` DR-001 (fiók/előfizetés elhalasztva).

### PROD-002

- [x] `db/migrations/006_create_contact_messages_table.sql` lefuttatva phpMyAdmin-ban
- [x] `POST /api/contact` élesben: érvénytelen bemenetre 400 + helyes HU/EN hibaüzenet
- [x] `POST /api/contact` élesben: érvényes bemenetre `{"ok":true}` és sor kerül a `contact_messages` táblába
- [x] Honeypot mező kitöltésekor `{"ok":true}`, de **nincs** DB-beszúrás
- [x] Ékezetes (magyar) szöveg torzulás nélkül kerül be a táblába (`utf8mb4` javítás után igazolva)
- [x] `adatvedelem.html` és `en/privacy.html` már nem hivatkozik „projekt véglegesítésével kerül ide” placeholderre, helyette a kapcsolatfelvételi űrlapra mutat

### OPS-001

- [x] `GET /api/tools` élesben `Cache-Control: no-store`-t küld
- [x] `POST /api/contact` élesben `Cache-Control: no-store`-t küld (korábban semmilyen cache-fejléce nem volt)
- [x] Statikus HTML-oldalak fejléce nem változott (`max-age=0`, nincs regresszió)

### TOOL-004

- [x] `db/migrations/007_seed_pdf_page_selector.sql` lefuttatva phpMyAdmin-ban
- [x] `GET /api/tools` élesben tartalmazza a `pdf-page-selector` slugot
- [x] `pdf-page-selector.html` és `en/pdf-page-selector.html` élesben 200-at ad
- [x] Bélyegkép-előnézet, kattintható kijelölés, megtartás/eltávolítás mód és letöltés a felhasználó saját böngészőjében igazolva

### UX-001

- [x] Mindhárom fájlfeltöltős tool (Favicon Generator, Termékfotó Optimalizáló, PDF Oldal Kiválasztó) dropzone-ja ikont + "Fájl kiválasztása" gombot kapott, HU+EN
- [x] A `<label>` inline/blokk CSS-hiba (ADR-012) javítva, élesben igazolva (`display: block` jelen van)
