# 10 – Kanonikus backlog

## Állapotok

- `TODO` – még nem kezdődött el.
- `READY` – minden előfeltétel megvan, kezdhető.
- `IN_PROGRESS` – aktív munka.
- `BLOCKED` – döntés vagy külső feltétel hiányzik.
- `VERIFY` – elkészült, ellenőrzésre vár.
- `DONE` – elfogadási feltételekkel igazolt.
- `DEFERRED` – tudatosan későbbre halasztva.

## Prioritás

- `P0` – kritikus: adatbiztonság, hozzáférés, adatintegritás vagy alapvető fejlesztési biztonság.
- `P1` – karbantarthatóság, konzisztencia, középtávú stabilitás.
- `P2` – UX, optimalizálás, termékminőség.

> A P0/P1/P2 elnevezés szabadon átnevezhető/átdefiniálható a projekt igénye szerint – csak legyen egyetlen, következetesen használt prioritás-skála.

## Logikai végrehajtási sorrend

| Sorrend | ID | Prioritás | Állapot | Rövid leírás | Függőség |
|---:|---|---|---|---|---|
| 0 | INFRA-001 | P0 | `DONE` | Aldomain + adatbázis + Node.js App + git deploy pipeline felállítása | – |
| 1 | PROD-001 | P1 | `BLOCKED` | Monetizációs modell pontosítása (felhasználó módosítana a dokumentumban javasolthoz képest) | felhasználói döntés |
| 2 | PLAT-001 | P1 | `TODO` | Platform-váz tervezése: fiók-keret, tool-regisztrációs keret, előfizetés-keret, DB-séma első migrációja | PROD-001 (részben), roadmap Fázis 1 |
| 3 | TOOL-001 | P2 | `TODO` | Favicon Generator megvalósítása a platform-vázon | PLAT-001 |

## Kiemelt feladatok elfogadási feltételei

### INFRA-001

- [x] `quicktools.qwer.hu` HTTPS-en elérhető, érvényes SSL-tanúsítvánnyal
- [x] `szablac_quicktools` adatbázis és DB-user létrehozva
- [x] Node.js App fut Passenger alatt, `server.js` válaszol
- [x] Git-alapú deploy működik (GitHub → cPanel Git Version Control pull)
- [x] Smoke-teszt szerver élesben visszaadja a várt választ

### PLAT-001

- [ ] DB-séma első migrációja létrehozva és lefuttatva (`docs/12_DATABASE_AND_MIGRATIONS.md` szerint)
- [ ] Backend API legalább egy valódi (nem smoke-teszt) végponttal válaszol
- [ ] Vue frontend alapváz fut és eléri a backendet
- [ ] Fiók-keret és tool-regisztrációs keret terve dokumentálva (`docs/04_DOMAIN_RULES.md`)
