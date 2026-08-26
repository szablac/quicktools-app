# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001, UX-002, I18N-001, SEO-001, OPS-002 KÉSZ; MON-001 Google-jóváhagyásra vár; TOOL-007 (Nyomtatható PDF Készítő) kódja kész és alaposan tesztelve, deploy hátravan |
| Aktív feladat | TOOL-007 — commit/push/deploy jóváhagyásra vár |
| Állapot | Kliens-oldali PDF-készítő (képek + Markdown-szöveg → A4/A3 PDF) elkészült. Böngészős tesztelés közben két valódi hibát találtunk és javítottunk: (1) szabványos PDF-betűtípus nem bírja a magyar ő/ű betűket — beágyazott Noto Sans a megoldás (ADR-018); (2) kép utáni szöveg ráíródott a kép oldalára — javítva. |
| Kiemelt következő feladat | Commit + push jóváhagyása, migráció (010) lefuttatása phpMyAdminban, deploy (`scripts/deploy.sh` vagy cPanel), élő ellenőrzés |
| Aktuális kódmódosítás | `public/pdf-maker.html`, `public/en/pdf-maker.html` (új), `db/migrations/010_seed_pdf_maker.sql` (új), `docs/09_DECISIONS.md` (ADR-018), `docs/10_BACKLOG.md` — helyben, még nincs commitolva |
| Blokkoló | – |
| Utolsó tartós döntés | ADR-018 (2026-08-26, `ELFOGADOTT`) — beágyazott Unicode betűtípus (Noto Sans + `@pdf-lib/fontkit`) a magyar ékezetek miatt, nem szabványos PDF-font |

## Következő pontos lépések

1. Commit + push jóváhagyása.
2. Migráció (`db/migrations/010_seed_pdf_maker.sql`) lefuttatása phpMyAdminban élesben.
3. Deploy: `ssh szablac@185.75.192.93 'bash ~/quicktools.qwer.hu/scripts/deploy.sh'` vagy cPanel Pull+Restart (nincs `package.json`-változás, NPM Install nem kell).
4. Élő ellenőrzés: `/api/tools` listázza-e a `pdf-maker`-t, HU+EN oldal 200-at ad-e, és érdemes egy valódi böngészőben (nem csak a szandbox-olt tesztelőben) is kipróbálni magyar ékezetes szöveggel.
5. Ezután TOOL-007 lezárható `DONE`-ra; utána újra döntés kell: következő tool, vagy más nyitott tétel.
6. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — referenciaként megmarad.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

> Megjegyzés: a `temp_files/` mappában (gitignore-olt) még mindig van két érintetlen, érzékeny fájl (`db`, `github token`) — nem relevánsak jelenleg.

> Megjegyzés: a `beerbelly.qwer.hu` projekthez is szeretne a felhasználó SSH-hozzáférést — ugyanaz a kulcs működni fog, de ezt a projekt saját munkamenetében kell átbeszélni.

## Legutóbbi interakciók

- **MON-001 lezárva**: AdSense hirdetéskód + GDPR consent-üzenet élesben igazolva, a felhasználó megkérte az újra-felülvizsgálatot (Google-oldali, nem rajtunk múlik).
- **TOOL-007 kérés + tisztázás**: a felhasználó egy "bármiből PDF-et csináló" toolt kért, A4 alap + A3 opcióval. Tisztáztam, hogy "bármi" (pl. `.xls`) nem reális kliens-oldalon; a felhasználó elfogadta a kép+szöveg (Markdown) kombinációt, táblázat-támogatás nélkül.
- **Implementáció + alapos böngészős tesztelés**: a `pdf-lib`-et már ismert mintára építve (mint a PDF Oldal Kiválasztónál) saját Markdown-feldolgozót (címsor/lista/félkövér), szó-tördelést és Canvas-alapú képkonverziót írtam. A tesztelés során két valódi hibát találtam: a szabványos Helvetica betűtípus elszállt magyar ő/ű karaktereken (megoldás: beágyazott Noto Sans a `@pdf-lib/fontkit` UMD buildjével, mivel az ESM build bundler-függő "pako" importot tartalmazott), és egy oldaltördelési hibát (kép utáni szöveg ráíródott a kép oldalára). Mindkettőt javítottam, majd újratesztelve: magyar ékezetek, A4/A3 pontos méret, kép+szöveg helyes oldalszám, hosszú szöveg többoldalas tördelése, sorrendezés, eltávolítás, üres állapot — mind hibátlan.

## Aktuális munkafájlok

- `public/pdf-maker.html`, `public/en/pdf-maker.html` – új tool, még nincs commitolva
- `db/migrations/010_seed_pdf_maker.sql` – új migráció, még nincs lefuttatva

## Ellenőrzési állapot

- `node --check` (beágyazott `<script type="module">` kinyerve): mindkét fájl szintaktikailag hibátlan.
- Böngészőben (`javascript_exec`, blob-elfogással) igazolva: magyar ékezetes szöveg hiba nélkül, A4/A3 pontos méret, kép+szöveg helyes oldalszám (2 elem → 2 oldal), hosszú szöveg helyes többoldalas tördelése (5 oldal), sorrendezés, eltávolítás, üres állapot.
- **Még nincs ellenőrizve**: élő (quicktools.qwer.hu) viselkedés — migráció + deploy szükséges hozzá.
