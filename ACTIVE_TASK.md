# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001, UX-002, I18N-001, SEO-001 KÉSZ; OPS-002 (SSH deploy-eszközök) kódja/szerver-oldali beállítása kész, tényleges deploy-teszt hátravan |
| Aktív feladat | OPS-002 — `scripts/deploy.sh` commit/push jóváhagyásra vár, utána egy próba-futtatás |
| Állapot | Shell-hozzáférés engedélyezve a fiókon (ADR-006 felülbírálva). `scripts/deploy.sh` megírva és helyben szintaktikailag ellenőrizve (`bash -n`). `~/.my.cnf` **már létrehozva a szerveren** (chmod 600), `mysql -e "SELECT 1"` jelszó nélkül működik — migrációk mostantól `mysql < db/migrations/0XX_nev.sql` paranccsal futtathatók. |
| Kiemelt következő feladat | `scripts/deploy.sh` commit + push jóváhagyása, utána egy tényleges próba-futtatás SSH-n keresztül, hogy lássuk, működik-e élesben |
| Aktuális kódmódosítás | `scripts/deploy.sh` (új), `docs/09_DECISIONS.md` (ADR-016), `docs/10_BACKLOG.md` — helyben, még nincs commitolva |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-016 (2026-08-23, `ELFOGADOTT`) — SSH-alapú deploy-szkript + `.my.cnf`, fokozatos átállás, migráció tudatosan nem automatizált |

## Következő pontos lépések

1. Commit + push jóváhagyása a `scripts/deploy.sh`-ra és a dokumentációra.
2. Miután a szerveren is lehúzta git (a szkript maga csinálja ezt, de az *első* futtatáshoz kézzel kell egyszer `git pull`-olni, hogy maga a szkript-fájl megjelenjen a szerveren) — utána tesztfuttatás: `ssh szablac@185.75.192.93 'bash ~/quicktools.qwer.hu/scripts/deploy.sh'`.
3. Ha működik: ez lesz az elsődleges (gyorsabb) deploy-mód a jövőben, a cPanel GUI-s módszer tartalék marad.
4. **Biztonsági megjegyzés még nyitva**: a `.htaccess` SSH-s megtekintésekor egyszer megjelent az éles DB-jelszó a beszélgetésben (dokumentálva ADR-016-ban). A felhasználó mérlegelheti a jelszócserét a cPanel felületén — nem sürgős, saját helyi munkameneten belüli megjelenés volt.
5. **Beerbelly-project**: a felhasználó jelezte, hogy a `beerbelly.qwer.hu` projekthez is kellene SSH-hozzáférés — ugyanaz a kulcs működni fog (azonos hosting-fiók), de ezt a projekt saját munkamenetében kell átbeszélni, nem itt.
6. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — referenciaként megmarad.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

> Megjegyzés: a `temp_files/` mappában (gitignore-olt) még mindig van két érintetlen, érzékeny fájl (`db`, `github token`) — nem relevánsak jelenleg.

## Legutóbbi interakciók

- **SSH shell-hozzáférés véglegesen engedélyezve**: több kör próbálkozás és support-visszajelzés után a felhasználó fiókján a shell-hozzáférés aktívvá vált — valódi bejelentkezés igazolva (`whoami`, `hostname`→`c3.elin.hu`). ADR-006 felülbírálva.
- **Szerver-felmérés**: felmértem (csak olvasás jelleggel) a szervert — Node v22.23.2/npm 10.9.8 (nodevenv-aktiválás után), `mysql` kliens elérhető, Passenger `tmp/restart.txt`-tel újraindítható, a git checkout stimmel a legutóbbi push-sal. Menet közben véletlenül megjelent az éles DB-jelszó (a `.htaccess` tartalmazza a Node-env-változókat) — dokumentálva, nem ismételve, nem git alá kerülve.
- **OPS-002 — deploy-eszközök**: a felhasználó jóváhagyására megírtam a `scripts/deploy.sh`-t (git pull + feltételes npm install + Passenger-restart, biztonsági fékkel az el nem mentett szerver-oldali módosítások ellen) és létrehoztam a `~/.my.cnf`-et a szerveren (jelszó nélküli `mysql` CLI-hitelesítéshez). A `.my.cnf` működését élőben igazoltam (`SELECT 1`). A `deploy.sh` még nincs commitolva/tesztelve élesben.

## Aktuális munkafájlok

- `scripts/deploy.sh` – új, még nincs commitolva
- `docs/09_DECISIONS.md` – ADR-016 hozzáadva

## Ellenőrzési állapot

- `bash -n scripts/deploy.sh`: szintaktikailag hibátlan.
- A szerveren: `ls -la ~/.my.cnf` → `-rw-------` (600), `mysql -e "SELECT 1"` sikeresen lefutott jelszó nélkül.
- **Még nincs ellenőrizve**: maga a `deploy.sh` tényleges futtatása élesben.
