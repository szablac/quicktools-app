# [PROJEKTNÉV] – Claude Code belépési pont

> Ez a fájl szándékosan rövid. Ne bővítsd hibajavítási naplóvá. A részletes tudás a `docs/` mappában található.
>
> **Ez egy üres projekt-skeleton.** Az `[EZ]`, `[PROJEKTNÉV]` és hasonló szögletes-zárójeles helyőrzők az induló kérdés-válasz körben töltendők ki. Ha egy szakasz a projektre nem értelmezhető, hagyd üresen vagy jelöld `– nem releváns –`-nek; ne találj ki tartalmat.

## 0. Projektindítás (új projekt esetén)

Ha az `ACTIVE_TASK.md` fázis mezője „– nincs még –”, vagy a `docs/01_PROJECT_FOUNDATIONS.md` válaszai még `[KITÖLTENDŐ]` állapotúak, ez egy vadonatúj, most induló projekt.

Ilyenkor:

1. **Ne** kezdj kódot írni, dokumentumot kitölteni vagy backlog-tételt felvenni kérdés nélkül.
2. Az első kérdésed mindig ez legyen: **„Mi az, amit fel fogunk építeni?”**
3. A felhasználó válasza (projektterv) alapján lépj **tervező módba**: vidd végig vele a `docs/01_PROJECT_FOUNDATIONS.md` kérdéskeretét (cél, célközönség, hatókör, siker-kritérium, kényszerek, érintettek, kezdeti kockázatok, munkamódszer) – nem kell mindet egyszerre, kimerítően kérdezni, elég annyira mélyen, amennyire a projekt mérete indokolja.
4. Tervezés közben folyamatosan, lépésenként töltsd ki (ne írj át egyszerre mindent, csak amiről már tényleges válasz van):
   - `docs/01_PROJECT_FOUNDATIONS.md` – válaszok;
   - `docs/03_ARCHITECTURE.md` – irány;
   - `docs/04_DOMAIN_RULES.md` – induló szabályok;
   - `docs/roadmap/00_MASTER_PLAN.md` – fázisok és kapu-feltételek;
   - `docs/10_BACKLOG.md` – első tételek (`TODO`/`READY` állapottal).
5. Tervezés közben **kódot nem írsz** – kizárólag dokumentumot.
6. Amint egy backlog-tétel `READY` állapotba kerül (van elfogadási feltétele, tisztázott hatóköre), állj meg, és kérj kifejezett jóváhagyást a fejlesztés megkezdésére. Jóváhagyás nélkül ne kezdj kódot írni.
7. Jóváhagyás után térj át a normál munkamódra (1–8. szakasz), és onnantól mindvégig érvényesek a 4. szakasz alapelvei, különösen: **kis lépések, egyszerű javaslatok, egyszerű de hatékony tesztek**.

## 1. Nyelv és szerepek

- A felhasználóval, a dokumentációban, commit-javaslatokban és fejlesztési összefoglalókban **magyarul** kommunikálj.
- A felhasználó a termék- és üzleti döntéshozó. Javasolhatsz megoldásokat, de ne változtass irányt, üzleti szabályt, technológiát vagy hatókört az engedélye nélkül.
- Kódot, migrációt, adatot, fájlt, commitot vagy push-t ne módosíts a felhasználó kérésén túl.
- **Commitot és push-t csak kifejezett felhasználói engedéllyel** hajts végre. Ettől függetlenül minden logikai egység végén adj commit-javaslatot.

## 2. Ellenőrzési munkamódszer (alapértelmezett – token-hatékony)

> Build/teszt-szerver/adatbázis üzemeltetése minden körben feleslegesen sok tokent fogyaszt. Alapból a KÖNNYŰ üzemmód érvényes; nehezebb ellenőrzést csak akkor végezz, ha a kockázat vagy a felhasználó kérése indokolja.

- Alapértelmezetten **NE** buildelj, és **NE** üzemeltess teszt szervert/adatbázist minden körben. A fejlesztői gép a felhasználó saját tesztkörnyezete is – ő kézzel is tesztel.
- Ha van beépített böngésző-eszköz, elsősorban azt használd ellenőrzésre, ha a változás UI-t érint.
- Migráció/adatbázis-változtatás előtt elég egy célzott smoke-teszt (nem kell teljes automatikus csomag minden körben).
- Build és teljes automatikus teszt csak akkor kötelező, ha: a felhasználó explicit kéri, VAGY a változás pénzügyi/jogosultsági/törlési/import-export logikát érint, VAGY a `docs/09_DECISIONS.md`-ben más szabály áll.
- Kérésre adj kézi tesztesetet (lépések, elvárt eredmény) a felhasználónak, ahelyett hogy magad futtatnál mindent.
- A `CLAUDE.md`/`ACTIVE_TASK.md` kötelező beolvasása a beszélgetés ELEJÉRE vonatkozik, nem minden egyes üzenetre egy folyamatban lévő beszélgetésen belül.
- Tiszta kérdés-válasz (nincs kód-, dokumentum- vagy adatváltoztatás) esetén az `ACTIVE_TASK.md` frissítés és az 5-részes válaszszerkezet (lásd 5. szakasz) NEM kötelező – elég egy rövid, szabad formájú válasz.
- Kanonikus dokumentumból csak a releváns rész kerüljön beolvasásra (célzott keresés/grep), ne a teljes fájl, ha nem szükséges.

## 3. Minden érdemi (nem tiszta kérdés-válasz) felhasználói kérés elején

1. Olvasd el ezt a fájlt és az `ACTIVE_TASK.md` fájlt (ha még nem történt meg ebben a beszélgetésben).
2. Nézd meg a `git status --short` és szükség esetén a `git diff` kimenetét. Ne írj felül ismeretlen helyi módosítást.
3. Osztályozd a kérést: kérdés, hibakeresés, kódmódosítás, adat/adatbázis, UI, biztonság, üzemeltetés vagy dokumentáció.
4. A `docs/00_INDEX.md` alapján csak a témához szükséges kanonikus fájlokat olvasd be.
5. Keresd meg a kapcsolódó backlog-azonosítót. Ha nincs, adj újat a `docs/10_BACKLOG.md` szabályai szerint.
6. Módosítás előtt vizsgáld meg a tényleges kódot/adatot/hívási láncot. A dokumentáció nem helyettesíti a forrás ellenőrzését.

## 4. Munkavégzési alapelvek

- **Kis lépések** – egy fejlesztési kör egyetlen kis, önmagában ellenőrizhető egységet vigyen végig; ne halmozz több független változtatást egy körbe.
- **Egyszerű javaslatok** – mindig a legegyszerűbb működő megoldást javasold először; bonyolultabb/rugalmasabb megoldást csak akkor, ha a felhasználó ezt külön kéri, vagy a kockázat (pénzügy, jogosultság, törlés) indokolja.
- **Egyszerű, de hatékony tesztek** – minden elkészült egységhez legyen tényleges ellenőrzés (futtatható teszt vagy dokumentált kézi smoke, lásd `docs/07_TEST_STRATEGY.md`), de kerüld a túltervezett/túlméretezett tesztelést.
- A legkisebb biztonságos, visszaellenőrizhető változtatási csomaggal dolgozz.
- Előbb reprodukáld és mérd fel a hibát, utána javítsd.
- Új logika előtt keress azonos vagy nagyon hasonló megoldást a teljes projektben.
- Ha ugyanaz a szabály két vagy több helyen él, ne készíts harmadik másolatot: javasolj vagy készíts közös függvényt/szolgáltatást.
- Ne végezz nagy refaktorálást és viselkedésváltoztatást ugyanabban a körben.
- Pénzügyi, jogosultsági, lezárási, törlési, import- és visszaállítási műveletnél mindig vizsgáld a tranzakciót, idempotenciát, versenyhelyzetet és visszaállíthatóságot.
- Titkot, jelszót, tokent, `.env`-értéket vagy személyes adatot ne írj naplóba, dokumentációba vagy kliensválaszba.
- Ne használj „majd később” jellegű üres TODO-t backlog-azonosító és elfogadási feltétel nélkül.

## 5. Kritikus, kötelező kódszabályok

> **[KITÖLTENDŐ a projekt megismerése/fejlődése során.]** Ide kerülnek a projekt saját, visszatérő hibamintái/szabályai – pl. adattípus-csapdák, sorrend-függő route-regisztráció, közös UI-komponens-konvenciók, tranzakció-kötelezettségek. Amíg üres, nincs ilyen rögzített szabály.

Részletek: `docs/04_DOMAIN_RULES.md`, `docs/05_SECURITY_AND_DATA_INTEGRITY.md`, `docs/12_DATABASE_AND_MIGRATIONS.md`.

## 6. Minden érdemi kérés végén – állapotfrissítés

Érdemi (nem tiszta kérdés-válasz) kérés után frissítsd az `ACTIVE_TASK.md` fájlt. Tartsd röviden, legfeljebb az utolsó 3 interakciót őrizd benne.

Rögzítsd: mit kért a felhasználó; mit vizsgáltál/módosítottál; mely fájlok változtak; milyen ellenőrzés történt (ha történt); mi maradt nyitva; mi a következő pontos lépés; kell-e felhasználói döntés; javasolt commit-pont.

Ezután szükség szerint frissítsd: `docs/10_BACKLOG.md`, `docs/09_DECISIONS.md`, `VALTOZASOK.md`, érintett kanonikus dokumentum.

A végső válasz szerkezete (csak érdemi, több lépéses kérésnél kötelező – tiszta kérdés-válasznál elhagyható):

1. **Mit tettem**
2. **Miért így**
3. **Ellenőrzés**
4. **Nyitott kérdés vagy következő döntés**
5. **Commit-javaslat** – ha van commitra érett logikai egység

## 7. Olvasási útválasztás

Mindig (beszélgetés elején): `ACTIVE_TASK.md`, majd `docs/00_INDEX.md`.

A feladattípus szerinti pontos olvasási listát a `docs/00_INDEX.md` táblázata adja.

## 8. Tiltott működés

- Ne olvasd be minden körben a teljes dokumentációt vagy a teljes archívumot.
- Ne állítsd, hogy egy folyamat működik, ha csak buildet vagy szintaxist ellenőriztél.
- Ne törölj vagy írj felül felhasználói adatot, mentést vagy helyi módosítást megerősítés nélkül.
- Ne készíts „gyors” közvetlen adat-/adatbázis-javítást terv és mentés nélkül.
- Ne vezesd be ugyanazt a szabályt újabb helyen hardkódolva.
- Ne módosíts egyszerre nagy számú, egymástól független fájlt csak azért, mert technikailag lehetséges.
