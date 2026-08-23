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
| 11 | TOOL-005 | P2 | `DONE` | Színkontraszt Ellenőrző megvalósítva (teljesen kliens-oldali, WCAG relatív-luminancia képlet), a számítás ismert referenciaértékekkel (pl. #767676/fehér = 4.54:1) igazolva, élesben ellenőrizve (`/api/tools` listázza, HU+EN oldal 200-at ad) | PLAT-001 (kész) |
| 12 | TOOL-006 | P2 | `DONE` | CSS Gradient Builder megvalósítva (teljesen kliens-oldali, lineáris/sugárirányú, tetszőleges számú színmegálló, CSS + Tailwind arbitrary-value export), élesben ellenőrizve (`/api/tools` listázza, HU+EN oldal 200-at ad) | PLAT-001 (kész) |
| 13 | UX-002 | P2 | `DONE` | Főoldal tool-kártyák: minden kártya a saját tool egyedi hero-ikonját mutatja a generikus placeholder helyett (`TOOL_ICONS` slug→SVG leképezés, ismeretlen slugra a régi generikus ikonra esik vissza), élesben ellenőrizve | TOOL-001..006 |
| 14 | I18N-001 | P2 | `VERIFY` | Nyelvi útvonalválasztás IP-alapú országfelismeréssel (`geoip-lite`, ADR-014): magyar IP → magyar kezdőoldal, külföldi → `/en/`, `qt_lang` süti emlékszik a választásra. Csak a gyökér (`/`) útvonalra vonatkozik. Adatvédelmi/cookie szabályzat frissítve. Négy eset (van cookie / magyar IP / külföldi IP / ismeretlen IP) node-ban mock kérésekkel igazolva; élesítés hátravan | – |

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

### TOOL-005

- [x] `db/migrations/008_seed_color_contrast_checker.sql` lefuttatva phpMyAdmin-ban
- [x] `GET /api/tools` élesben tartalmazza a `color-contrast-checker` slugot
- [x] `color-contrast-checker.html` és `en/color-contrast-checker.html` élesben 200-at ad
- [x] Kontrasztarány-számítás ismert referenciaértékekkel igazolva (fekete/fehér = 21:1, #767676/fehér = 4.54:1 — pontosan a WCAG AA határon)
- [x] Pass/fail jelvények (AA/AAA × normál/nagy szöveg) helyesen váltanak a határértékeknél
- [x] Érvénytelen hex-kód esetén hibajelzés jelenik meg, nem omlik össze

### TOOL-006

- [x] `db/migrations/009_seed_css_gradient_builder.sql` lefuttatva phpMyAdmin-ban
- [x] `GET /api/tools` élesben tartalmazza a `css-gradient-builder` slugot
- [x] `css-gradient-builder.html` és `en/css-gradient-builder.html` élesben 200-at ad
- [x] Lineáris/sugárirányú váltás, szög-módosítás, szín hozzáadása/eltávolítása (min. 2 szín) böngészőben igazolva
- [x] CSS és Tailwind (arbitrary-value) kimenet pontos szintaxissal (pl. `bg-[linear-gradient(135deg,#5b7f6f_0%,#a9c2b6_100%)]`)
- [x] Érvénytelen hex-kód a színmegállóknál figyelmen kívül van hagyva, nem omlik össze

### I18N-001

- [x] Ismert magyar IP-tartományra a döntési logika a magyar oldalt választja (node-teszt)
- [x] Ismert külföldi IP-tartományokra (US, AU, DE, SK) a döntési logika angol átirányítást választ (node-teszt)
- [x] Ismeretlen/helyi IP-re a magyar oldal marad az alapértelmezett
- [x] Már beállított `qt_lang` süti esetén nincs újra-átirányítás, sem újra-cookie-állítás (mock kérésekkel igazolva)
- [ ] `db/migrations`-t nem igényel; élesben ellenőrizendő: valódi böngészőből/`curl`-lal a redirect + `Set-Cookie` viselkedés
- [x] `adatvedelem.html`/`en/privacy.html` és `sutik.html`/`en/cookies.html` frissítve a `qt_lang` süti és az IP-alapú döntés feltüntetésével
