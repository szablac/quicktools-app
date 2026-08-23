# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001, UX-002 KÉSZ; I18N-001 (nyelvi útvonalválasztás) kódja kész, deploy hátravan |
| Aktív feladat | I18N-001 — commit/push/deploy jóváhagyásra vár (ADR-014 egyelőre `JAVASOLT`, jóváhagyás után `ELFOGADOTT`-ra vált) |
| Állapot | `GET /`-re a `geoip-lite` csomaggal országfelismerés: nem magyar IP → 302 a `/en/`-re, `qt_lang` süti (1 év) emlékszik a döntésre, hogy ne fusson le újra és a kézi navigálást ne írja felül. Csak a gyökér útvonalra vonatkozik, mélylinkeket nem érint. Adatvédelmi tájékoztató + Cookie szabályzat (HU+EN) frissítve. |
| Kiemelt következő feladat | Commit + push jóváhagyása, cPanel Pull + **NPM Install** (package.json változott!) + Restart, élő ellenőrzés |
| Aktuális kódmódosítás | `server.js`, `package.json`, `package-lock.json`, `public/adatvedelem.html`, `public/en/privacy.html`, `public/sutik.html`, `public/en/cookies.html` — helyben, még nincs commitolva |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-014 (2026-08-23, `JAVASOLT`) — IP-alapú nyelvi útvonalválasztás `geoip-lite`-tal, csak a gyökér útvonalon |

## Következő pontos lépések

1. Commit + push jóváhagyása.
2. cPanel Git Version Control „Pull” → **Run NPM Install** (mivel a `package.json` változott, ez most kötelező lépés, nem hagyható ki) → Setup Node.js App „Restart”.
3. Élő ellenőrzés: `curl -I` a `/`-re külföldi IP-t szimulálva (ha lehetséges), és/vagy manuális teszt VPN-nel vagy a felhasználó saját (magyar) böngészőjével — a magyar oldalnak kell maradnia, redirect nélkül.
4. Ezután I18N-001 lezárható `DONE`-ra, ADR-014 `ELFOGADOTT`-ra; utána újra döntés kell: következő tool, vagy MON-001/002 (AdSense) folytatása.
5. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **UX-002 lezárva**: főoldal tool-kártyák egyedi ikonokkal élesben igazolva, lezárva a backlogban (commit `7361284`).
- **I18N-001 kérés**: a felhasználó kérte, hogy magyar IP-ről a magyar, külföldiről az angol kezdőoldal töltődjön be. Tisztázó kérdés közben ("külföldiként nem csak US és AU...") megerősítettem: a logika minden nem-HU országkódra vonatkozik, nincs szűkített lista.
- **I18N-001 implementáció + ellenőrzés**: `geoip-lite` (Apache-2.0, helyi adatbázis, nincs külső API-hívás) hozzáadva függőségként. `GET /`-re middleware: cookie-ellenőrzés → geoip-lekérdezés → redirect vagy `next()`. Node.js-ben igazolva ismert HU/US/AU/DE/SK IP-tartományokkal, majd mock kérés-válasz objektumokkal mind a 4 döntési ág (van cookie / magyar / külföldi / ismeretlen IP). Adatvédelmi tájékoztató és Cookie szabályzat (HU+EN) frissítve a `qt_lang` süti és az IP-használat feltüntetésével.

## Aktuális munkafájlok

- `server.js` – `geoip-lite` alapú nyelvi redirect middleware `GET /`-re
- `package.json`, `package-lock.json` – új függőség: `geoip-lite`
- `public/adatvedelem.html`, `public/en/privacy.html` – IP-alapú nyelvi döntés feltüntetve
- `public/sutik.html`, `public/en/cookies.html` – `qt_lang` süti feltüntetve

## Ellenőrzési állapot

- `node --check server.js`: szintaktikailag hibátlan.
- `geoip-lite` országfelismerés Node.js-ben igazolva öt ismert IP-tartománnyal (HU, US, AU, DE, SK) — mind helyes.
- A middleware döntési logikája (cookie-ellenőrzés, redirect, cookie-beállítás) mock `req`/`res` objektumokkal mind a 4 esetben (van cookie / magyar IP / külföldi IP / ismeretlen IP) a várt módon viselkedik.
- **Még nincs ellenőrizve**: élő (quicktools.qwer.hu) viselkedés valódi HTTP-kéréssel — deploy szükséges hozzá (package.json változott, NPM Install kötelező lépés).
