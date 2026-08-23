# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001/002/003/004 KÉSZ; PROD-002, OPS-001, UX-001 KÉSZ |
| Aktív feladat | – (nincs kijelölt aktív tétel) |
| Állapot | PDF Oldal Kiválasztó (4. tool) élesben ellenőrizve; mindhárom fájlfeltöltős tool dropzone-ja egységesen beszédesebb megjelenítést kapott, egy valódi CSS-hibával együtt javítva (ADR-012) |
| Kiemelt következő feladat | Döntés kell: következő tool, vagy MON-001/002 (AdSense) folytatása |
| Aktuális kódmódosítás | – (minden pusholva és deployolva: `30a7a5a`) |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-012 (2026-08-23) — dropzone vizuális egységesítés + `<label>` inline/blokk CSS-buktató rögzítve jövőbeli toolokhoz |

## Következő pontos lépések

1. Döntés kell a felhasználótól: következő tool, vagy MON-001/MON-002 (AdSense-folytatás).
2. Amint a Google AdSense dönt, a hirdetéskód beillesztése (MON-001).
3. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **TOOL-004 (PDF Oldal Kiválasztó) implementáció**: teljesen kliens-oldali (`pdf-lib` + `pdfjs-dist`), megtartás/eltávolítás váltható mód. Egy valódi `ReferenceError`-t találtunk és javítottunk a renderelő ciklusban — az automatizált előnézeti eszköz megbízhatatlannak bizonyult canvas-renderelés ellenőrzésére, ezért a felhasználó saját böngészőjében, helyi HTTP-szerveren át teszteltünk.
- **UX-001 — dropzone redesign + CSS-hiba**: a felhasználó jelezte, hogy a fájlfeltöltő doboz nem elég beszédes. Ikon + "Fájl kiválasztása" gomb került mindhárom fájlfeltöltős toolba (Favicon, Termékfotó, PDF; HU+EN). Ez felszínre hozott egy valódi CSS-hibát (`<label>` inline elem blokk-gyerekekkel → szétesett doboz), javítva `display: block`-kal (ADR-012).
- **Élő igazolás + lezárás**: commit `30a7a5a`, push, migráció (007) phpMyAdminban, cPanel Pull+Restart. `curl`-lal igazolva: `/api/tools` tartalmazza a `pdf-page-selector` slugot, mindkét nyelvi oldal 200-at ad, a `display: block` javítás élesben is jelen van. TOOL-004 és UX-001 lezárva `DONE`-ra.

## Aktuális munkafájlok

– (minden pusholva, deployolva és élesben igazolva)

## Ellenőrzési állapot

- `https://quicktools.qwer.hu/api/tools` tartalmazza a `pdf-page-selector` bejegyzést (curl-lal igazolva).
- `https://quicktools.qwer.hu/pdf-page-selector.html` és `.../en/pdf-page-selector.html` 200-at ad.
- `https://quicktools.qwer.hu/favicon-generator.html` tartalmazza a `.dropzone { display: block` javítást.
- A felhasználó saját böngészőjében megerősítette: a bélyegkép-előnézet, kijelölés, letöltés és a dropzone-megjelenítés mindhárom toolban rendben van.
