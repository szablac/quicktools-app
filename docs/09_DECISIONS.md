# 09 – Tartós döntési napló

## Használat

- Csak tartós, több későbbi feladatot befolyásoló döntés kerüljön ide.
- A napi munkanapló az `ACTIVE_TASK.md` fájlba kerül.
- Claude javaslatát `JAVASOLT` állapotban rögzítsd; csak a felhasználó egyértelmű jóváhagyása után legyen `ELFOGADOTT`.
- Elfogadott döntést ne írj át történet nélkül; új döntés váltsa fel (és utaljon a régire).

## Sablon

```markdown
### ADR-NNN – [rövid cím]

- Állapot: **JAVASOLT** / **ELFOGADOTT**
- Dátum: ÉÉÉÉ-HH-NN
- Döntés: [mit döntöttünk]
- Indok: [miért]
```

## Döntések

### ADR-001 – Tech stack

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-22
- Döntés: Frontend Vue, Backend Node.js (Express javasolt), adatbázis MariaDB/MySQL.
- Indok: a felhasználó explicit választása; az Express javaslat azért esett erre, mert a cPanel Node.js Selector minden keretrendszert egyformán támogat, és a WorkSheet projektben már meglévő Express-tapasztalat közvetlenül átvihető (legegyszerűbb működő megoldás elve).

### ADR-002 – MVP hatókör és sorrend

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-22
- Döntés: előbb a platform-váz épül (fiók, tool-regisztrációs keret, előfizetés-keret), és csak utána kerül rá az első valódi eszköz, ami a **Favicon Generator** lesz.
- Indok: a felhasználó döntése; hosszú távon stabilabb architektúrát ad, mint egy izolált első tool köré utólag platformot építeni.

### ADR-003 – Kétnyelvű UI kezdettől

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-22
- Döntés: a felület kezdettől HU+EN kétnyelvű.
- Indok: a forrás-dokumentum (`micro app ötletek.docx`) kifejezetten ezt javasolja, mert a magyar piac önmagában szűk; utólag drágább i18n-t bevezetni.

### ADR-004 – Nincs határidő/budget-korlát

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-22
- Döntés: nincs kötött határidő és nincs kifejezett költségkeret.
- Indok: hobbi/mellékprojekt-jellegű indítás, szabad ütemezéssel.

### ADR-005 – Hosting és aldomain

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-22
- Döntés: önálló, új cPanel-szerver, `quicktools.qwer.hu` aldomain a `qwer.hu` fő domain alatt.
- Indok: a felhasználó választása, teljesen független a WorkSheet infrastruktúrától.

### ADR-006 – Git deploy publikus repóval, SSH helyett HTTPS

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-22
- Döntés: a `szablac/quicktools-app` GitHub-repó ideiglenesen **publikus**, a cPanel Git Version Control HTTPS-sel (hitelesítés nélkül) klónozza/pull-olja.
- Indok: a cPanel-fiókon nincs shell-hozzáférés engedélyezve, emiatt az SSH-kulcsos klónozás nem működött megbízhatóan (néma hiba a klónozásnál). Mivel a repóban egyelőre nincs érzékeny adat, a publikussá tétel kockázatmentes átmeneti megoldás. **Felülvizsgálandó**, amint (a) shell-hozzáférés elérhetővé válik, vagy (b) a repóba érzékeny tartalom kerülne.

### ADR-007 – Átmeneti monetizáció: Google AdSense

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-22
- Döntés: a fejlesztési időszak alatt Google AdSense hirdetések kerülnek az oldalra, meglévő Google-fiókkal. A végleges monetizációs modellről (a `micro app ötletek.docx`-ban javasoltakhoz — freemium/előfizetés/kredit stb. — képest) később döntünk.
- Indok: a felhasználó döntése; egyszerű, gyorsan bevezethető átmeneti bevételi forrás, amíg a platform-váz és az első eszközök épülnek. Előfeltétele volt egy valódi tartalmú landing oldal és adatvédelmi tájékoztató (elkészült 2026-08-22, lásd `VALTOZASOK.md`).

### ADR-008 – Vizuális design irány: „Soft Calm"

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-23
- Döntés: a Claude Design canvasban bemutatott 3+4 irány közül (techno vonal elvetve) a **„Soft Calm"** irány lett kiválasztva: puha lekerekített kártyák (24px), meleg törtfehér háttér (`#f9f8f5`), zsályazöld akcentus (`#5b7f6f`), Plus Jakarta Sans betűtípus. A főoldal kártyás eszköz-elrendezést kap, az egyes tool-aloldalak részletesebben mutatják be az adott eszközt (lépések, csomag-tartalom).
- Indok: a felhasználó választása — barátságos, széles közönségnek (kisvállalkozók, fejlesztők, kreatívok) is befogadható megjelenés. **Tudatosan ideiglenes/iterálható**: a felhasználó jelezte, hogy a design később, több eszköz megléte után újragondolásra kerül — ez nem végleges márka-döntés.

### ADR-009 – Email cím és copyright eltávolítása az oldalról

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-23
- Döntés: a `szablac@gmail.com` email cím és a „© 2026 QuickTools.hu" copyright-sor eltávolítva minden oldalról, **beleértve** az adatvédelmi tájékoztató szövegét is (adatkezelői elérhetőség, érintetti jogok szakasz).
- Indok: a felhasználó döntése — (1) elkerülni a bot-scraping miatti spam-forgalmat, (2) a domainnév (`quicktools.qwer.hu`) nem végleges, ezért korai lenne rá copyright-márkanevet kötni.
- **Kockázat, amit tudatosan vállal a felhasználó**: az adatvédelmi tájékoztatóban jelenleg nincs semmilyen látható kapcsolattartási elérhetőség az adatkezelőhöz — ez a GDPR szerint általában elvárt lenne, amint tényleges személyes adatkezelés (pl. AdSense-sütik) élesedik. **Felülvizsgálandó**, mielőtt az AdSense (MON-001) ténylegesen élesedik, vagy a domain véglegesül.
- **Frissítés (2026-08-23, PROD-002)**: a kockázat lezárva — nyilvános email cím helyett saját, DB-be mentő kapcsolatfelvételi űrlap került az adatvédelmi tájékoztatóba (HU+EN), `POST /api/contact` végponttal, honeypot mezővel és alap IP-alapú rate-limittel a spam ellen. Nincs kimenő email-küldés/értesítés, a beérkező üzeneteket kézzel, phpMyAdminban kell ellenőrizni (`contact_messages` tábla). Ezzel az eredeti (1) indok (bot-scraping elkerülése) is jobban teljesül, mint egy kiírt email címmel.

### ADR-010 – AI háttéreltávolítás: engedékeny licencű lánc, kliens-oldalon

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-23
- Döntés: a Termékfotó Optimalizáló opcionális háttéreltávolítás-funkciója a `modern-rembg` (MIT) csomagot használja, `onnxruntime-web` (MIT) peer-dependency-vel, u2netp.onnx modellel (Apache 2.0). Mindhárom komponens CDN-ről (unpkg), import map-pel töltődik be — nincs npm-telepítés, nincs build-lépés, teljesen kliens-oldali (WASM), nincs szerver-terhelés.
- Indok: a vezető, legjobb minőségű megoldás (`@imgly/background-removal`) **AGPL** licencű, ami hálózaton keresztüli használat esetén is kiterjeszti a copyleft-kötelezettséget — ez összeegyeztethetetlen egy esetleges jövőbeli zárt forráskódú/előfizetéses modellel (lásd a `micro app ötletek.docx` monetizációs ötleteit). A `modern-rembg`+u2netp lánc minden eleme MIT/Apache 2.0, nincs forráskód-nyilvánossági kötelezettség.
- **Kockázat, amit tudatosan vállal a felhasználó**: a `modern-rembg` egyetlen karbantartó által gondozott, alacsony release-aktivitású csomag (utolsó verzió kb. egy éve) — hosszabb távon karbantartási/ellátási-lánc kockázatot jelent. Ha a CDN-ről betöltött verzió valaha elérhetetlenné válna vagy komoly hibát találnánk benne, alternatívát kell keresni.
- **Technikai buktató, amit érdemes rögzíteni**: az `onnxruntime-web` csomag `dist/ort.min.js` fájlja **nem** valódi ESM (nincs benne névvel exportált `InferenceSession` stb.) — a helyes import-map célpont a `dist/esm/ort.min.js`. Enélkül a `import * as ort from 'onnxruntime-web'` némán elbukik egy "does not provide an export named ..." hibával.

### ADR-011 – OPS-001 cache-fejléc: `/api` middleware, nem Apache-szintű beavatkozás

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-23
- Döntés: a `server.js`-ben egy `/api` útvonal-előtagra illesztett middleware minden API-válaszra egységesen `Cache-Control: no-store`-t állít be, a korábbi, csak `GET /api/tools`-ra explicit beállított fejléc helyett/mellett.
- Indok: élő fejléc-vizsgálat (`curl -I`) kiderítette, hogy az Apache/Passenger réteg minden váloszhoz hozzáfűz egy **saját, második** `Cache-Control`/`Expires` fejlécet (feltehetően `mod_expires`, MIME-típus szerinti alapértelmezéssel: `text/html` → azonnali lejárat, minden más, pl. `application/json` → 2 nap) — ezt a Node-oldali fejléc nem *felülírja*, hanem duplikált fejlécként egészíti ki. A statikus HTML-oldalak esetén ez véletlenül nem okoz gondot (mindkét réteg `max-age=0`-t küld), de bármilyen jövőbeli dinamikus GET-végpont, ami elfelejt explicit `no-store`-t beállítani, csendben örökölné a 2 napos alapértelmezést.
- **Miért nem Apache-szintű javítás**: a cPanel-fiókon nincs shell-hozzáférés, a `.htaccess`-t a "Setup Node.js App" felület kezeli/regenerálhatja — egy oda kézzel beírt `mod_headers` szabály törékeny lenne. A Node-oldali middleware egyszerűbb, verziókövetett, és minden jövőbeli `/api/*` végpontra automatikusan érvényes.
- **Ismert, tudatosan vállalt kockázat**: mivel a válasz technikailag két `Cache-Control` fejlécet tartalmaz, egy nem szabványkövető kliens/proxy elméletileg csak az egyiket veheti figyelembe. A gyakorlatban használt böngészők (Chrome/Firefox/Safari) helyesen összefűzik és a `no-store`-t érvényesítik.

### ADR-012 – Dropzone vizuális egységesítés + `<label>` inline/blokk CSS-buktató

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-23
- Döntés: mindhárom fájlfeltöltős tool (Favicon Generator, Termékfotó Optimalizáló, PDF Oldal Kiválasztó, HU+EN) dropzone-ja egységesen kapott egy felhő-feltöltés ikont (`.dz-icon`) és egy kiemelt, gomb-szerű "Fájl kiválasztása" elemet (`.dz-btn`) — a felhasználó jelezte, hogy a korábbi, tisztán szöveges dropzone nem volt egyértelműen felismerhető feltöltő felületként.
- **Technikai buktató, amit érdemes rögzíteni**: a `.dropzone` mindhárom toolban egy `<label>` elem, ami CSS-ben alapból **inline** — blokk-szintű `<div>` gyerekelemekkel (pl. `.dz-title`) kombinálva ez a böngészőt arra kényszeríti, hogy a dashed border/background-ot több, anonim blokk-fragmensre törje szét ("szétesett doboz" — a border csak egy vékony csíkként jelenik meg a bal szélen, a szöveges tartalom pedig külön, középre igazítva "lebeg" tőle). A jelenség a `.dz-icon` + `.dz-btn` hozzáadásával (több blokk-gyerek) vált ténylegesen észrevehetővé, de a hiba szerkezetileg már korábban is jelen volt. **Javítás**: `display: block;` a `.dropzone` szabályban. Új tool készítésekor, ha a dropzone `<label>`-ként készül és blokk-szintű gyerekeket tartalmaz, mindig kell rá explicit `display: block` (vagy `flex`) — sima `text-align: center` önmagában nem elég.
- Ellenőrzés: a felhasználó saját böngészőjében (nem csak az automatizált előnézeti eszközben, ami nem minden esetben kompozitál megbízhatóan) igazolta mindhárom tool javított megjelenését.
