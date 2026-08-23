# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001/002/003/004 KÉSZ; PROD-002, OPS-001, UX-001 KÉSZ; TOOL-005 (Színkontraszt Ellenőrző) kódja kész, deploy hátravan |
| Aktív feladat | TOOL-005 — commit/push/migráció/deploy jóváhagyásra vár |
| Állapot | Színkontraszt Ellenőrző elkészült: teljesen kliens-oldali, WCAG relatív-luminancia képlet, élő előnézet, 4 pass/fail jelvény (AA/AAA × normál/nagy szöveg), színcsere gomb. A számítást Node.js-ben ismert referenciaértékekkel (fekete/fehér=21:1, #767676/fehér=4.54:1) és böngészőben is igazoltam. |
| Kiemelt következő feladat | Commit + push jóváhagyása, migráció (008) lefuttatása phpMyAdminban, cPanel Pull+Restart, élő ellenőrzés |
| Aktuális kódmódosítás | `public/color-contrast-checker.html`, `public/en/color-contrast-checker.html`, `db/migrations/008_seed_color_contrast_checker.sql` — helyben, még nincs commitolva |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | – |

## Következő pontos lépések

1. Commit + push jóváhagyása.
2. Migráció (`db/migrations/008_seed_color_contrast_checker.sql`) lefuttatása phpMyAdminban élesben.
3. cPanel Git Version Control „Pull” + Setup Node.js App „Restart”.
4. Élő ellenőrzés: `/api/tools` listázza-e, a főoldal kártyája működik-e.
5. Ezután TOOL-005 lezárható `DONE`-ra; utána újra döntés kell: következő tool (pl. CSS Gradient Builder, Markdown → PDF), vagy MON-001/002 (AdSense) folytatása.
6. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **TOOL-004 + UX-001 lezárva**: PDF Oldal Kiválasztó és a dropzone-egységesítés élesben igazolva, lezárva a backlogban (commit `30a7a5a`, `77c2fcd`).
- **Következő tool: Színkontraszt Ellenőrző**: a felhasználó a korábbi ötletlistából ezt választotta („Legyen a Színkontraszt ellenőrző, azzal kezdjünk”). Alacsony ambiguitású, jól definiált feladat (szabványos WCAG-képlet), ezért tisztázó kérdés nélkül, közvetlenül implementáltam.
- **TOOL-005 implementáció + ellenőrzés**: teljesen kliens-oldali tool, `pdf-page-selector`-hoz hasonló szerkezetű oldal (nem dropzone-alapú, hanem szín-inputok). A WCAG relatív-luminancia képletet Node.js-ben külön, ismert referenciaértékekkel (fekete/fehér, #767676 határeset) igazoltam, majd böngészőben is teszteltem a pass/fail jelvények határeset-viselkedését és az érvénytelen bemenet kezelését.

## Aktuális munkafájlok

- `public/color-contrast-checker.html`, `public/en/color-contrast-checker.html` – új tool, még nincs commitolva
- `db/migrations/008_seed_color_contrast_checker.sql` – új migráció, még nincs lefuttatva

## Ellenőrzési állapot

- `node --check` (a beágyazott `<script>` kinyerve mindkét fájlból): szintaktikailag hibátlan.
- A kontrasztarány-képlet Node.js-ben ismert WCAG referenciaértékekkel igazolva (21:1, 4.54:1 a #767676/fehér határesetnél).
- Böngészőben (helyi fájlként) tesztelve: alapértelmezett színpár minden jelvényen megfelel; gyenge kontraszt (#aaaaaa/fehér, 2.32:1) minden jelvényen helyesen bukik; határeset (#767676/fehér, 4.54:1) pontosan az AA-nál billen; érvénytelen hex-kódra hibajelzés jelenik meg.
- **Még nincs ellenőrizve**: élő (quicktools.qwer.hu) viselkedés — migráció + deploy szükséges hozzá.
