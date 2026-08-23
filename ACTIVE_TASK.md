# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001/002/003 KÉSZ; PROD-002 KÉSZ; OPS-001 kódja kész, élő ellenőrzés hátravan |
| Aktív feladat | OPS-001 — `/api` middleware (`Cache-Control: no-store` minden API-válaszra) helyben kész, még nincs commitolva/deployolva |
| Állapot | Élő fejléc-vizsgálattal (`curl -I`) kiderült, hogy az Apache/Passenger réteg minden választ megtold egy saját, második `Cache-Control`/`Expires` fejléccel (MIME-típus szerint, nem-HTML → 2 nap alapértelmezett) — ez a Node fejlécét nem felülírja, hanem kiegészíti. Statikus HTML-nél véletlenül nincs élő gond (mindkét réteg `max-age=0`), de dinamikus GET-végpontoknál kockázatos, ha kimarad az explicit `no-store`. Megoldás: ADR-011 szerint egy `/api` middleware, nem Apache-szintű beavatkozás. |
| Kiemelt következő feladat | Commit + push jóváhagyása, majd cPanel Pull+Restart, majd élő fejléc-ellenőrzés (`curl -I` a `/api/tools`, `/api/contact` végpontokon) |
| Aktuális kódmódosítás | `server.js` — `/api` middleware hozzáadva, a korábbi `/api/tools`-specifikus `no-store` sor törölve (redundáns lett) |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-011 (2026-08-23) — cache-fejléc middleware Node-oldalon, nem Apache/`.htaccess`-szinten (törékeny lenne, cPanel regenerálhatja) |

## Következő pontos lépések

1. Commit + push jóváhagyása az OPS-001 middleware-re.
2. cPanel Git Version Control „Pull” + Setup Node.js App „Restart”.
3. Élő ellenőrzés: `curl -I` a `/api/tools`-ra és `/api/contact`-ra — mindkettőn `Cache-Control: no-store`-nak kell szerepelnie (az Apache-féle második fejléccel együtt is).
4. Ezután OPS-001 lezárható a backlogban; utána újra döntés kell: következő tool, vagy MON-001/002 (AdSense) folytatása.
5. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **PROD-002 lezárva**: kapcsolatfelvételi űrlap (`POST /api/contact`, honeypot + rate-limit, `contact_messages` tábla) élesben ellenőrizve, egy `utf8mb4` kódolási hiba felfedezve és javítva (commit `e1b7954`, `c2b335e`), backlog + `ACTIVE_TASK.md` lezárva (`e92217a`).
- **OPS-001 részletes átbeszélése**: a felhasználó kérésére élő `curl -I` vizsgálattal pontosítottuk az eredeti feltételezést — kiderült, hogy a korábban dokumentált „2 napos elavulás” statikus HTML-re már nem áll fenn (Node és Apache alapértelmezése egyezik), a valódi reziduális kockázat a jövőbeli dinamikus GET-végpontoknál van, ha kimarad az explicit `no-store`.
- **OPS-001 implementáció**: egy `/api` útvonal-előtagra illesztett Express middleware mostantól minden API-választ egységesen `no-store`-ra állít, a korábbi, csak `/api/tools`-ra explicit beállított sor törölve (redundáns). `node --check` hibátlan. ADR-011 rögzítve. Még nincs commitolva.

## Aktuális munkafájlok

- `server.js` – `/api` middleware (`Cache-Control: no-store`), helyben módosítva, még nincs commitolva

## Ellenőrzési állapot

- `node --check server.js`: szintaktikailag hibátlan.
- **Még nincs ellenőrizve élesben**: a middleware tényleges hatása (`curl -I` a deploy után).
