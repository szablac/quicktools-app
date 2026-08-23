# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001/002/003 KÉSZ; PROD-002, OPS-001 KÉSZ; TOOL-004 (PDF Oldal Kiválasztó) + UX-001 (dropzone-egységesítés) kódja kész, felhasználó saját böngészőjében igazolva |
| Aktív feladat | – (kód kész, commit/deploy jóváhagyásra vár) |
| Állapot | PDF Oldal Kiválasztó: teljesen kliens-oldali, `pdf-lib`+`pdfjs-dist`, megtartás/eltávolítás váltható mód, rendes magyarázó szöveggel. Menet közben egy valódi JS-hibát (`ReferenceError`, elszabadult `thumb` változó) és egy valódi CSS-hibát (`<label>` inline elem blokk-gyerekekkel → szétesett doboz, ld. ADR-012) is találtunk és javítottunk — mindkettőt a felhasználó saját böngészőjében igazoltuk vissza. A dropzone-redesign (ikon + "Fájl kiválasztása" gomb) mindhárom fájlfeltöltős toolra (Favicon, Termékfotó, PDF) alkalmazva, HU+EN. |
| Kiemelt következő feladat | Commit + push jóváhagyása, migráció (007) lefuttatása phpMyAdminban, cPanel Pull+Restart, élő ellenőrzés |
| Aktuális kódmódosítás | `public/pdf-page-selector.html`, `public/en/pdf-page-selector.html` (új), `public/favicon-generator.html`, `public/en/favicon-generator.html`, `public/product-photo-optimizer.html`, `public/en/product-photo-optimizer.html` (dropzone-redesign), `db/migrations/007_seed_pdf_page_selector.sql` (új) — helyben, még nincs commitolva |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-012 (2026-08-23) — dropzone vizuális egységesítés + `<label>` inline/blokk CSS-buktató rögzítve jövőbeli toolokhoz |

## Következő pontos lépések

1. Commit + push jóváhagyása a fenti fájlokra.
2. Migráció (`db/migrations/007_seed_pdf_page_selector.sql`) lefuttatása phpMyAdminban élesben.
3. cPanel Git Version Control „Pull” + Setup Node.js App „Restart”.
4. Élő ellenőrzés: `/api/tools` listázza-e a PDF Oldal Kiválasztót, a főoldal kártyája működik-e, és a 3 érintett tool dropzone-ja élesben is egyben van-e (nem csak helyi szerveren).
5. Ezután TOOL-004 és UX-001 lezárható `DONE`-ra; utána újra döntés kell: következő tool, vagy MON-001/002 (AdSense) folytatása.
6. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **Következő tool kiválasztása**: a felhasználó kérésére elolvastam a `E:\Dropbox\Work\micro app ötletek.docx` eredeti ötletlistát, összevetettem a meglévő 3 tool-lal, rangsorolt javaslatot adtam. A felhasználó a **PDF Oldal Kiválasztót** választotta, megtartás/eltávolítás váltható móddal (rendes magyarázó szöveggel).
- **TOOL-004 implementáció + hibajavítás**: teljesen kliens-oldali (`pdf-lib` + `pdfjs-dist` CDN import map-pel). Az automatizált előnézeti eszköz megbízhatatlannak bizonyult a canvas-renderelés ellenőrzésére (nem mindig kompozitál), ezért helyi HTTP-szerveren át a felhasználó saját böngészőjében teszteltünk. Így derült ki egy valódi `ReferenceError` (elszabadult `thumb` változó a render-ciklusban) — javítva.
- **UX-001 — dropzone redesign + CSS-hiba**: a felhasználó jelezte, hogy a fájlfeltöltő doboz nem elég beszédes mindhárom toolban. Hozzáadtunk egy ikont + "Fájl kiválasztása" gomb-elemet mindhárom toolhoz (HU+EN, 6 fájl). Ez felszínre hozott egy valódi, azóta javított CSS-hibát: a `.dropzone` `<label>` elem inline volt, blokk-gyerekekkel kombinálva szétesett a doboz — `display: block` a javítás (ADR-012). A felhasználó saját böngészőjében igazolta a végeredményt.

## Aktuális munkafájlok

- `public/pdf-page-selector.html`, `public/en/pdf-page-selector.html` – új tool, még nincs commitolva
- `public/favicon-generator.html`, `public/en/favicon-generator.html`, `public/product-photo-optimizer.html`, `public/en/product-photo-optimizer.html` – dropzone-redesign, még nincs commitolva
- `db/migrations/007_seed_pdf_page_selector.sql` – új migráció, még nincs lefuttatva

## Ellenőrzési állapot

- `node --check` (a beágyazott `<script type="module">` kinyerve mindkét PDF-tool fájlból): szintaktikailag hibátlan.
- A felhasználó saját böngészőjében (helyi HTTP-szerveren át, nem `file://`) igazolta: PDF-feltöltés, bélyegkép-előnézet, kattintható kijelölés, letöltés működik; mindhárom tool dropzone-ja (Favicon, Termékfotó, PDF) helyesen, egybefüggően jelenik meg a `display:block` javítás után.
- **Még nincs ellenőrizve**: élő (quicktools.qwer.hu) viselkedés — ehhez migráció + deploy szükséges.
