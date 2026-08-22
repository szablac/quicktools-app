# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz folyamatban |
| Aktív feladat | PLAT-001 – tool-regisztrációs keret (kód kész, deploy hátravan) |
| Állapot | `tools` tábla létrehozva éles DB-n; `server.js` mysql2 + `GET /api/tools`-szal bővítve, helyileg tesztelve; még nincs pusholva/deployolva |
| Kiemelt következő feladat | Push + cPanel Git pull + npm install + restart, majd élő ellenőrzés |
| Aktuális kódmódosítás | `server.js`, `package.json`, `package-lock.json` (mysql2 hozzáadva), `db/migrations/001_create_tools_table.sql` |
| Blokkoló | – (Google AdSense felülvizsgálat még fut a háttérben, MON-001, nem blokkol) |
| Utolsó tartós döntés | DR-001/DR-002 (`docs/04_DOMAIN_RULES.md`) – fiók/session elhalasztva, nyilvános hozzáférés; mysql2 nyers SQL Prisma helyett (deploy-kockázat miatt) |

## Következő pontos lépések

1. Commit + push a `server.js`/`package.json`/`db/migrations/` változásokra.
2. cPanel: Git Version Control Pull → Setup Node.js App „Run NPM Install" (mysql2 miatt) → Restart.
3. Élő ellenőrzés: `https://quicktools.qwer.hu/api/tools` üres tömböt (`[]`) adjon vissza hiba nélkül.
4. Amint a Google AdSense dönt, a hirdetéskód beillesztése (MON-001), utána MON-002 (quicktools.qwer.hu külön webhelyként).

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **Google AdSense jelentkezés (MON-001)**: fiók regisztrálva `szablac@gmail.com`-mal, `qwer.hu` gyökérre kötve (mert az AdSense a legfelső szintű domaint kéri, aldomain nem elég). Hitelesítés `ads.txt`-vel (a `quicktools.qwer.hu` külön dokumentumgyökere miatt ez volt a tisztább út a script-beágyazás helyett). GDPR-beleegyezés-üzenet beállítva, felülvizsgálat kérelmezve. Felvéve MON-002 (P0): `quicktools.qwer.hu` külön webhelyként hozzáadása, hogy a bevétel-jelentés ne keveredjen más `qwer.hu` aldomainek adataival.
- **PLAT-001 tervezés**: tisztázódott, hogy egyelőre NINCS fiók/session/előfizetés (DR-001, nyilvános hozzáférés) — a kör csak a tool-regisztrációs keretre szűkült. DB-réteg döntés: mysql2 nyers SQL, nem Prisma (natív bináris deploy-kockázat a shell nélküli cPanel-környezeten). Dokumentálva: `docs/04_DOMAIN_RULES.md`, `docs/12_DATABASE_AND_MIGRATIONS.md`, `docs/11_API_MAP.md`, `CLAUDE.md` 5. szakasz kitöltve.
- **PLAT-001 fejlesztés**: felhasználó jóváhagyta a kódolást. `tools` tábla létrehozva phpMyAdmin-ban (migráció lefutott, ellenőrizve). `server.js` mysql2-pool + `GET /api/tools` végponttal bővítve, helyi teszttel igazolva, hogy DB-hiba esetén sem szivárog ki nyers hiba (generikus 500-as JSON válasz).

## Aktuális munkafájlok

- `server.js`, `package.json`, `package-lock.json` – Express + mysql2, `/api/tools` végpont
- `db/migrations/001_create_tools_table.sql` – lefuttatva éles DB-n
- `docs/04_DOMAIN_RULES.md`, `docs/12_DATABASE_AND_MIGRATIONS.md`, `docs/11_API_MAP.md`, `CLAUDE.md` – frissítve

## Ellenőrzési állapot

- Helyi Node teszt: `/api/tools` DB-hiba esetén helyesen generikus 500-as JSON-t ad, nem szivárogtat stacket.
- `tools` tábla létrehozva és ellenőrizve phpMyAdmin-ban (0 sor, hiba nélkül).
- Éles deploy és `/api/tools` élő ellenőrzés **még hátravan**.
