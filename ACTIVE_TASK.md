# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001/002/003 KÉSZ; vizuális design (ADR-008, Soft Calm) élesben |
| Aktív feladat | PROD-002 — kapcsolatfelvételi űrlap kódja kész, élő migráció + teszt hátravan |
| Állapot | `POST /api/contact` végpont (honeypot + rate-limit, `contact_messages` táblába ment) + HU/EN adatvédelmi oldal űrlappal elkészült, helyi statikus renderelés ellenőrizve böngészőben; DB-írás élesben még nincs tesztelve |
| Kiemelt következő feladat | 006-os migráció lefuttatása phpMyAdminban, majd élő smoke-teszt (form beküldés + `contact_messages` tartalom ellenőrzése) |
| Aktuális kódmódosítás | `server.js`, `public/adatvedelem.html`, `public/en/privacy.html`, `db/migrations/006_create_contact_messages_table.sql` — helyi, még nincs commitolva |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-009 frissítve (2026-08-23) — a kiírt email helyett saját, DB-be mentő űrlap zárja le a kapcsolattartási kockázatot |

## Következő pontos lépések

1. Felhasználó lefuttatja a `db/migrations/006_create_contact_messages_table.sql`-t phpMyAdminban élesben.
2. Commit + push jóváhagyása, majd cPanel Git Version Control „Pull” (nincs `package.json` változás, NPM Install nem kell) + Node app „Restart”.
3. Élő smoke-teszt: `adatvedelem.html`/`en/privacy.html` űrlap valódi beküldése, majd `SELECT * FROM contact_messages;` phpMyAdminban az igazoláshoz; honeypot- és hibaüzenet-eset is érdemes egyszer kipróbálni.
4. Ezután PROD-002 lezárható `DONE`-ra a backlogban; utána újra döntés kell: következő tool, OPS-001 (cache-stratégia), vagy MON-001/002 (AdSense) folytatása.
5. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `/api/tools` végpont ellenőrzésekor kiderült, hogy a cPanel/Apache szintjén van egy alapértelmezett `max-age=172800` (2 nap) cache-irányelv, amit a Node-kód `no-store`-ja nem tud teljesen felülírni — ez a **visszatérő** látogatóknál késleltetheti a statikus tartalom frissülését jövőbeli deploy-oknál. Felvéve: OPS-001 (`docs/10_BACKLOG.md`).

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **Termékfotó Optimalizáló (TOOL-003) + AdSense fiók-profil (MON-001/002)**: több kör alatt elkészült a teljesen kliens-oldali tool (vágólap-beillesztés, opcionális AI háttéreltávolítás, nagyítható előnézet és HiDPI/felbontás-javítások), majd az AdSense fiók-profil is kész lett; kiderült, hogy a MON-002 elképzelt aldomain-szintű webhely-bontás nem lehetséges, ezért elhalasztva.
- **PROD-002 döntés**: átbeszéltük a kapcsolattartási elérhetőség pótlásának lehetőségeit (obfuszkált email / saját űrlap / harmadik fél szolgáltatás); a felhasználó a saját, DB-be mentő űrlapot választotta, mert ez oldja meg ténylegesen az eredeti bot-scraping problémát is, nem csak megkerüli.
- **PROD-002 implementáció**: `POST /api/contact` végpont (honeypot mező + IP-alapú rate-limit, `express.json()` middleware hozzáadva), `contact_messages` tábla migrációja (006), és a HU/EN adatvédelmi oldalak kibővítése a formmal + a „projekt véglegesítésével kerül ide” szövegek cseréje. Helyben, böngészőben (statikus fájlként) ellenőrizve: renderelés és a JS hibakezelési ág rendben; a tényleges DB-írás élő teszte még hátravan (migráció nincs lefuttatva élesben).

## Aktuális munkafájlok

- `server.js` – `POST /api/contact` végpont hozzáadva (honeypot + rate-limit), `express.json()` middleware
- `public/adatvedelem.html`, `public/en/privacy.html` – kapcsolatfelvételi űrlap + frissített „Adatkezelő”/„Érintetti jogok” szöveg
- `db/migrations/006_create_contact_messages_table.sql` – **még nincs lefuttatva élesben**, phpMyAdminban kézzel kell

## Ellenőrzési állapot

- `node --check server.js`: szintaktikailag hibátlan.
- HU és EN adatvédelmi oldal helyben (fájlként) böngészőben megnézve: az űrlap helyesen renderelődik, a JS submit-kezelő hálózati hiba esetén is hibátlanul, konzol-hiba nélkül fut le (a valódi POST csak élő szerver + DB mellett tesztelhető).
- **Még nincs ellenőrizve**: élő migráció-futtatás, valódi `POST /api/contact` sikeres beszúrás, honeypot- és rate-limit-eset élesben.
