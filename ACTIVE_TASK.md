# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001, UX-002, I18N-001, SEO-001, OPS-002 KÉSZ |
| Aktív feladat | – (nincs kijelölt aktív tétel) |
| Állapot | SSH-alapú deploy-szkript (`scripts/deploy.sh`) élesben sikeresen lefutott (kilépési kód 0), utána a főoldal (200) és `/api/tools` (6 tool) is helyesen válaszolt. Mostantól ez a gyorsabb alternatíva a cPanel GUI-s Pull+Restart helyett, a `.my.cnf` pedig jelszó nélküli `mysql` CLI-hozzáférést ad migrációkhoz. |
| Kiemelt következő feladat | Döntés kell: következő tool, vagy MON-001/002 (AdSense) folytatása |
| Aktuális kódmódosítás | – (minden pusholva és deployolva: `aac822d`) |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-016 (2026-08-23, `ELFOGADOTT`) — SSH-alapú deploy-szkript + `.my.cnf`, élesben igazolva |

## Következő pontos lépések

1. Döntés kell a felhasználótól: következő tool, vagy MON-001/MON-002 (AdSense-folytatás).
2. Jövőbeli deploy-hoz mostantól választható: `ssh szablac@185.75.192.93 'bash ~/quicktools.qwer.hu/scripts/deploy.sh'` (gyors), vagy a megszokott cPanel Pull+Restart (ha `package.json` változik, a szkript automatikusan felismeri és lefuttatja az `npm install`-t is).
3. Migráció futtatásához mostantól: `ssh`-val bejelentkezve, `cd ~/quicktools.qwer.hu && mysql < db/migrations/0XX_nev.sql` — jelszó-begépelés nélkül.
4. Amint a Google AdSense dönt, a hirdetéskód beillesztése (MON-001).
5. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — referenciaként megmarad.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

> Megjegyzés: a `temp_files/` mappában (gitignore-olt) még mindig van két érintetlen, érzékeny fájl (`db`, `github token`) — nem relevánsak jelenleg.

> Megjegyzés: a `beerbelly.qwer.hu` projekthez is szeretne a felhasználó SSH-hozzáférést — ugyanaz a kulcs működni fog (azonos hosting-fiók), de ezt a projekt saját munkamenetében kell átbeszélni.

## Legutóbbi interakciók

- **OPS-002 — deploy-eszközök megírva és bevezetve**: `scripts/deploy.sh` (git pull + feltételes npm install + Passenger-restart) és `~/.my.cnf` a szerveren, jóváhagyás után létrehozva és tesztelve (`SELECT 1` jelszó nélkül).
- **Bootstrap + élő tesztfuttatás**: mivel a szkript még nem létezett a szerveren, egy egyszeri kézi `git pull`-lal bootstrappeltem, majd ténylegesen lefuttattam a `deploy.sh`-t SSH-n keresztül. Kilépési kód 0, minden lépés (biztonsági ellenőrzés, pull, feltételes npm install, restart) helyesen lefutott.
- **Utóellenőrzés**: a Passenger-restart után a főoldal 200-at adott, az `/api/tools` helyesen 6 toolt listázott — a szkript valóban működik éles környezetben. OPS-002 lezárva `DONE`-ra.

## Aktuális munkafájlok

– (minden pusholva, deployolva és élesben igazolva)

## Ellenőrzési állapot

- `scripts/deploy.sh` élesben lefuttatva SSH-n keresztül: kilépési kód 0, minden lépés naplózva és helyesnek bizonyult.
- Restart utáni utóellenőrzés: `https://quicktools.qwer.hu/` → 200; `/api/tools` → 6 tool helyesen listázva.
