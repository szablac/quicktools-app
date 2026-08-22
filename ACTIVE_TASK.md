# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 0 – Infrastruktúra-alap (KÉSZ), induló Fázis 1 – Platform-váz |
| Aktív feladat | PROD-001 – monetizációs modell pontosítása (BLOCKED, felhasználói döntésre vár) |
| Állapot | Fázis 0 lezárva és ellenőrizve; Fázis 1 még nem indult |
| Kiemelt következő feladat | PROD-001 lezárása, utána PLAT-001 (platform-váz tervezése) |
| Aktuális kódmódosítás | – (INFRA-001 lezárva, nincs nyitott kódváltoztatás) |
| Blokkoló | Monetizáció-részletek a felhasználótól |
| Utolsó tartós döntés | ADR-006 – Git deploy publikus repóval, SSH helyett HTTPS (`docs/09_DECISIONS.md`) |

## Következő pontos lépések

1. Felhasználó pontosítja, mit módosítana a monetizációs modellen a `micro app ötletek.docx`-ban javasolthoz képest.
2. PLAT-001 tervezése: fiók-keret, tool-regisztrációs keret, DB-séma első migrációja (`docs/04_DOMAIN_RULES.md`, `docs/12_DATABASE_AND_MIGRATIONS.md`).
3. `server.js` bővítése: tényleges DB-kapcsolat (env változókból: `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`), Express bevezetése.

## Legutóbbi interakciók

- **QuickTools.hu projekt indítása**: új, önálló mappa (`D:\quicktools-app`) létrehozva, majd felfedezve, hogy már létezett benne egy előkészített „project-skeleton" sablon. A felhasználó elolvastatta a `micro app ötletek.docx`-ot (AI-konzultáció a koncepcióról), ez alapján tisztázódtak a founding kérdések (cél, célközönség, MVP-sorrend: platform-váz előbb, első tool a Favicon Generator, HU+EN UI, nincs határidő/budget). Módosított fájlok: `docs/01_PROJECT_FOUNDATIONS.md`, `docs/03_ARCHITECTURE.md`, `docs/09_DECISIONS.md` (ADR-001–005), `docs/roadmap/00_MASTER_PLAN.md`, `docs/10_BACKLOG.md`.
- **Aldomain + adatbázis + Node.js App + git deploy (INFRA-001)**: `quicktools.qwer.hu` aldomain létrehozva cPanel alatt, SSL kiadva; `szablac_quicktools` MariaDB adatbázis + DB-user létrehozva; GitHub repó (`szablac/quicktools-app`) létrehozva és pusholva; cPanel Git Version Control beállítva (SSH-kulcsos klónozás nem működött shell-hozzáférés hiánya miatt → repó ideiglenesen publikussá téve, ADR-006); Node.js App (Passenger, Node 22) beállítva és elindítva egy minimális smoke-teszt `server.js`-sel. Több köztes hiba is felmerült és javításra került (elgépelt Application Root mappanév, hiányzó `.htaccess` a Node Selector számára, stale File Manager nézet) — a folyamat végén `https://quicktools.qwer.hu` böngészőből ellenőrizve, helyesen válaszol.
- **`.gitignore` hozzáadása**: `temp_files/` mappa kizárva a verziókövetésből, jóváhagyva és commitolva (`ff53aef`).

## Aktuális munkafájlok

- `server.js`, `package.json` (repó gyökér) – minimális Passenger-kompatibilis smoke-teszt szerver
- `docs/01_PROJECT_FOUNDATIONS.md`, `docs/03_ARCHITECTURE.md`, `docs/09_DECISIONS.md`, `docs/roadmap/00_MASTER_PLAN.md`, `docs/10_BACKLOG.md` – frissítve ebben a körben

## Ellenőrzési állapot

- `https://quicktools.qwer.hu` böngészőből ellenőrizve (Claude Browser pane): helyes válasz, `QuickTools.hu backend - smoke test OK` + Node verzió.
- Adatbázis és DB-user cPanel felületen létrehozva, de a `server.js` még nem kapcsolódik hozzá (Fázis 1 feladat).
