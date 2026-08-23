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
| 1 | PROD-001 | P1 | `DONE` | Monetizációs modell pontosítása → átmeneti döntés: Google AdSense (ADR-007) | – |
| 2 | MON-001 | P1 | `VERIFY` | Google AdSense fiók regisztrálva (`qwer.hu` alá, `ads.txt`-vel igazolva), fiók-profil (fizetési cím, telefonszám) kész, webhely csatlakoztatva — Google belső felülvizsgálatára vár | landing oldal + adatvédelmi tájékoztató (kész) |
| 3 | MON-002 | P2 | `DEFERRED` | ~~`quicktools.qwer.hu` külön webhelyként~~ — kiderült, hogy ez az AdSense-felület **domain-szinten**, nem aldomain-szinten kezeli a „Webhelyek" listát (`qwer.hu` az egyetlen sor, a `quicktools.qwer.hu` automatikusan alá tartozik, önálló hozzáadása nem lehetséges). Ha a bevétel-jelentés aldomain-bontása mégis fontossá válik, a Jelentések (Reports) oldal URL-szűrését kell megnézni. | – |
| 3 | PLAT-001 | P1 | `DONE` | Tool-regisztrációs keret: `tools` tábla + `GET /api/tools` végpont (fiók/előfizetés elhalasztva, DR-001) | roadmap Fázis 1 |
| 4 | TOOL-001 | P2 | `DONE` | Favicon Generator megvalósítva (backend + HU/EN frontend), élesben ellenőrizve (feltöltés → ZIP-letöltés működik) | PLAT-001 (kész) |
| 5 | OPS-001 | P2 | `TODO` | Statikus tartalom (HTML/JS) cache-frissülési stratégia: az Apache-szintű `max-age=172800` alapértelmezés miatt visszatérő látogatóknál akár 2 napig elmaradhat egy frissülés | – |
| 6 | PROD-002 | **P0** | `VERIFY` | Kapcsolattartási elérhetőség: saját, DB-be mentő kapcsolatfelvételi űrlap (`POST /api/contact`, honeypot + rate-limit, nincs kimenő email) az adatvédelmi tájékoztatóban (HU+EN), nyilvános email cím nélkül — kód kész, migráció (006) élesben még nem futott, élő teszt hátravan | domain véglegesítés vagy MON-001 jóváhagyás |
| 7 | TOOL-002 | P2 | `DONE` | JSON Viewer megvalósítva (teljesen kliens-oldali, backend nélkül), élesben ellenőrizve | PLAT-001 (kész) |
| 8 | TOOL-003 | P2 | `DONE` | Termékfotó Optimalizáló megvalósítva (teljesen kliens-oldali, Canvas API), élesben ellenőrizve | PLAT-001 (kész) |

## Kiemelt feladatok elfogadási feltételei

### INFRA-001

- [x] `quicktools.qwer.hu` HTTPS-en elérhető, érvényes SSL-tanúsítvánnyal
- [x] `szablac_quicktools` adatbázis és DB-user létrehozva
- [x] Node.js App fut Passenger alatt, `server.js` válaszol
- [x] Git-alapú deploy működik (GitHub → cPanel Git Version Control pull)
- [x] Smoke-teszt szerver élesben visszaadja a várt választ

### PLAT-001

- [x] `db/migrations/001_create_tools_table.sql` lefuttatva phpMyAdmin-ban, ellenőrző lekérdezéssel igazolva
- [x] `server.js` mysql2-connection poollal kapcsolódik a DB-hez (env változókból)
- [x] `GET /api/tools` végpont válaszol (üres tömb, amíg nincs feltöltött tool) — élesben ellenőrizve: `[]`
- [x] Nyers SQL-/stack-hiba nem szivárog ki a kliens felé hibaválaszban

> Vue frontend alapváz és fiók-keret **nem** része ennek a tételnek — lásd `docs/04_DOMAIN_RULES.md` DR-001 (fiók/előfizetés elhalasztva).
