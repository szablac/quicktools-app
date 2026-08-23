# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001 KÉSZ; UX-002 (kártya-ikonok) kódja kész, deploy hátravan |
| Aktív feladat | UX-002 — commit/push/deploy jóváhagyásra vár |
| Állapot | A főoldal (HU+EN) tool-kártyái mostantól a saját tool egyedi hero-ikonját mutatják (nem egy generikus ikont mindenhol) — egy `TOOL_ICONS` slug→SVG leképezéssel, ismeretlen/jövőbeli slugra visszaesve a régi generikus ikonra. Böngészőben igazolva: 6 kártya, 6 egyedi ikon, nincs konzolhiba. |
| Kiemelt következő feladat | Commit + push jóváhagyása, cPanel Pull+Restart, élő ellenőrzés — nincs DB-migráció, csak statikus fájlok |
| Aktuális kódmódosítás | `public/index.html`, `public/en/index.html` — helyben, még nincs commitolva |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | – |

## Következő pontos lépések

1. Commit + push jóváhagyása.
2. cPanel Git Version Control „Pull” + Setup Node.js App „Restart” (nincs migráció, ez a lépés csak statikus fájlt frissít).
3. Élő ellenőrzés: a főoldal kártyáin megjelennek-e az egyedi ikonok.
4. Ezután UX-002 lezárható `DONE`-ra; utána újra döntés kell: következő tool (pl. Markdown → PDF), vagy MON-001/002 (AdSense) folytatása.
5. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **TOOL-006 lezárva**: CSS Gradient Builder élesben igazolva, egy UX-hibát is javítottunk (színválasztó húzása, ADR-013), lezárva a backlogban (commit `ac40149`, `87315d3`).
- **UX-002 — kártya-ikonok egyénivé tétele**: a felhasználó kérte, hogy a főoldal tool-kártyái a saját (belül, a tool oldalán használt) ikont mutassák a generikus kép-ikon helyett. Bevezettem egy `TOOL_ICONS` slug→SVG leképezést mindkét (HU/EN) `index.html`-ben, minden meglévő 6 toolhoz a saját hero-ikonjával; ismeretlen slugra a régi generikus ikonra esik vissza (védelem jövőbeli, még nem mappelt toolok ellen).
- **Ellenőrzés**: helyi teszt-szerverrel (mock `/api/tools` válasszal, hogy a fetch működjön `file://` nélkül) igazoltam böngészőben: mind a 6 kártya SVG-t kap, és mind a 6 egyedi (nincs két egyforma), nincs konzolhiba.

## Aktuális munkafájlok

- `public/index.html`, `public/en/index.html` – `TOOL_ICONS` leképezés hozzáadva, még nincs commitolva

## Ellenőrzési állapot

- `node --check` (a beágyazott `<script>` kinyerve mindkét fájlból): szintaktikailag hibátlan.
- Böngészőben (helyi szerver + mock `/api/tools`) igazolva: 6 kártya, 6 egyedi SVG-ikon, nincs konzolhiba.
- **Még nincs ellenőrizve**: élő (quicktools.qwer.hu) viselkedés — deploy szükséges hozzá (migráció nem kell).
