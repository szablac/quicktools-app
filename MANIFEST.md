# MANIFEST – a dokumentációs csomag tartalma

> Ez a fájl írja le, mi micsoda ebben a skeletonban/dokumentációs rendszerben. Ha egy fájlt törölsz vagy átnevezel a saját projektedben, itt is vezesd át.

## Gyökér

| Fájl | Szerepe |
|---|---|
| `CLAUDE.md` | Kötelező belépési pont Claude Code / AI-eszközök számára. |
| `NYITO_PROMPT.md` | Első üzenetként bemásolandó szöveg egy új projekt indításakor. |
| `ACTIVE_TASK.md` | Önfrissítő, rövid munkamemória – mit csinálunk éppen. |
| `AGENTS.md` | Pointer más AI-eszközöknek a `CLAUDE.md`-re. |
| `README.md` | Emberi olvasóknak szóló, hagyományos projekt-README. |
| `VALTOZASOK.md` | Kanonikus, csak-elkészült-változás changelog. |
| `TELEPITES.md` | Telepítési/üzemeltetési útmutató. |
| `MANIFEST.md` | Ez a fájl. |

## `docs/`

| Fájl | Szerepe |
|---|---|
| `00_INDEX.md` | Dokumentációs index, forráshitelességi sorrend, olvasási útválasztás. |
| `01_PROJECT_FOUNDATIONS.md` | Általános döntési keret új projekt indításához – kérdéskörök, nem kitöltött válaszok. |
| `02_CURRENT_SYSTEM.md` | Mi található ténylegesen a forrásban. |
| `03_ARCHITECTURE.md` | Kódszervezés, célállapot. |
| `04_DOMAIN_RULES.md` | Üzleti szabályok, állapotok, invariánsok. |
| `05_SECURITY_AND_DATA_INTEGRITY.md` | Biztonsági és adatintegritási minimum. |
| `06_DEVELOPMENT_WORKFLOW.md` | Egy fejlesztési kör pontos menete. |
| `07_TEST_STRATEGY.md` | Mit és mikor kell tesztelni. |
| `08_OPERATIONS_POLICY.md` | Production, mentés, naplózás, titkok. |
| `09_DECISIONS.md` | Elfogadott és javasolt tartós döntések (ADR-napló). |
| `10_BACKLOG.md` | Mit kell javítani, milyen sorrendben, milyen állapotban. |
| `11_API_MAP.md` | Hol található egy funkció az API-ban *(csak ha van API)*. |
| `12_DATABASE_AND_MIGRATIONS.md` | Séma és migráció *(csak ha van adatbázis)*. |
| `13_UI_UX.md` | Felületi konvenciók *(csak ha van UI)*. |
| `14_USER_DOCUMENTATION_PLAN.md` | Felhasználói kézikönyv terve *(opcionális)*. |
| `15_GLOSSARY.md` | Fogalomtár – azonos fogalmak azonos jelentéssel. |

## `docs/roadmap/`

Fázisolt tervezés: `00_MASTER_PLAN.md` + fázisonkénti kártyafájlok (lásd `01_PHASE_TEMPLATE.md` mintát).

## `docs/templates/`

Ismétlődő dokumentum-formátumok: feladatkártya, döntési rekord, session-lezárás, hibajegy.

## `docs/audit/`

Dátumozott, egyszeri állapotfelmérések (technikai audit pillanatképek).

## `docs/archive/`

Elavult, de megőrzendő dokumentumok változatlan másolata, dátumozott almappákban.

## Csomag-elv

Minden fájl LÉTEZIK a struktúrában (érinthető), de egyik sem KÖTELEZŐ kitölteni. Üresen hagyott fájl nem hiba – csak azt jelzi, hogy az adott terület erre a projektre (még) nem releváns vagy nem dolgoztuk ki.
