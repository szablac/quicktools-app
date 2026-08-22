# Roadmap 00 – Mesterterv

> Fázisolt végrehajtási sorrend, mindegyik fázishoz egy explicit "kapu" (gate) feltétellel – ne kezdj flancos munkát azelőtt, hogy az alap (adatbiztonság, reprodukálhatóság) stabil lenne.

## Fázisok

| Fázis | Cél | Kapu-feltétel |
|---:|---|---|
| 0 | Infrastruktúra-alap: aldomain, adatbázis, git-alapú deploy-pipeline, futó smoke-teszt szerver | **KÉSZ** (2026-08-22): `quicktools.qwer.hu` HTTPS-en él, DB+user létrehozva, Node.js App fut Passengeren, git pull-lal frissíthető, smoke-teszt szerver válaszol |
| 1 | Platform-váz: fiók/bejelentkezés-keret, tool-regisztrációs keret, előfizetés-keret (fizetés nélkül), Vue frontend alapváz | Legalább egy publikus oldal fut a Vue frontendből, backend API válaszol, DB-séma migrációval létrehozva |
| 2 | Első valódi eszköz: Favicon Generator integrálva a keretbe | Éles, használható tool a `quicktools.qwer.hu`-n, végponttól végpontig tesztelve |

Fázisonként egy kártyafájl készül a `docs/roadmap/` mappában, a `01_PHASE_TEMPLATE.md` mintáját követve, pl. `01_FAZIS1_NEV.md`.
