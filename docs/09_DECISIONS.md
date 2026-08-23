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
- **Végleges megerősítés (2026-08-23)**: a felhasználó egy cPanel-ben generált SSH-kulcspárral (`id_rsa`, jelszóval védett) közvetlen kapcsolódási tesztet végeztünk (`ssh szablac@185.75.192.93`). A hitelesítés **sikeres** volt (kulcs + felhasználónév helyes), de a szerver egyértelmű választ adott: *"Shell access is not enabled on your account! If you need shell access please contact support."* — tehát ez nem technikai hiba vagy hiányzó beállítás, hanem a szolgáltató tudatos korlátozása a csomagon. A shell-hozzáférés engedélyezéséhez a szolgáltatónál kell jelezni/kérni, vagy magasabb csomagra váltani. Amíg ez nem történik meg, a jelen ADR (git deploy HTTPS-sel, kézi phpMyAdmin-migráció, cPanel GUI-alapú deploy) érvényben marad.

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

### ADR-013 – Dinamikus lista + natív `<input type="color">`: ne építsd újra a DOM-ot minden inputnál

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-23
- Döntés: a CSS Gradient Builder (TOOL-006) színmegálló-listájában szétválasztottuk a "sorok felépítése" (`renderStopsList()`) és a "kimenetek frissítése" (`updateOutputs()`) logikát. Az előbbi csak akkor fut, amikor a lista szerkezete ténylegesen változik (szín hozzáadása/eltávolítása); az utóbbi minden bemenet-változásnál (szín, pozíció, típus, szög), de **nem nyúl** a szín-input DOM-elemekhez.
- Indok: a felhasználó jelezte, hogy a színválasztóban nem lehet húzni a natív felugró ablak köröcskéjét, csak kattintani. Az ok: az eredeti kód minden `input` eseménynél (ami húzás közben folyamatosan tüzel) újraépítette a teljes szín-lista `innerHTML`-jét, beleértve az éppen aktív `<input type="color">` elemet is — ez bezárta a böngésző natív színválasztó popupját minden apró egérmozdulatnál.
- **Általánosítható tanulság**: ha egy dinamikus lista natív interaktív elemet (color picker, `<video>`, fókuszban lévő input) tartalmaz, a lista újrarenderelését szét kell választani "csak kimenet frissül" és "a szerkezet is változik" esetekre — az utóbbi keretében sosem szabad DOM-ot cserélni egy éppen aktívan használt natív widget alól.
- Ellenőrzés: böngészőben (`javascript_exec`) igazolva, hogy a szín-input DOM-node azonos marad több egymást követő `input` esemény között (`samePickerNodeAcrossDrag: true`).

### ADR-014 – Nyelvi útvonalválasztás IP-alapú országfelismeréssel

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-23
- Döntés: a `GET /`-re érkező kérésnél a `geoip-lite` (Apache-2.0, helyben futó, MaxMind GeoLite2-alapú, **nincs külső API-hívás**) csomaggal megnézzük a látogató IP-címéből az országkódot. Ha nem `HU`, 302-es átirányítás `/en/`-re. Az eredményt (nem az IP-címet) egy `qt_lang` sütiben (1 év) jegyezzük meg, hogy (a) ne fusson le a lekérdezés minden egyes kérésnél, és (b) a felhasználó kézi nyelvválasztása/vissza-navigálása felülírja az automatikus döntést, ne írja azt felül folyamatosan.
- Indok: a felhasználó kérése — magyar IP-ről a magyar, külföldiről az angol kezdőoldal töltődjön be.
- **Hatókör, tudatosan szűkítve**: csak a gyökér (`/`) útvonalra vonatkozik. Egy konkrét tool-oldalra (pl. `/json-viewer.html` vagy `/en/json-viewer.html`) mutató közvetlen/megosztott linket nem térítünk el — ez megvédi a mélylinkeket és a keresőindexelést a váratlan átirányítástól.
- **Miért helyi könyvtár, nem külső geolokációs API**: nincs hálózati függőség/late­ncia, nincs harmadik félnek elküldött látogatói IP-cím, nincs API-kulcs/költség. Cserébe a `geoip-lite` beépített adatbázisa csak a csomag frissítésével (`npm update`) frissül — **tudatosan vállalt kockázat**: országszinten ritkán, de előfordulhat elavult/pontatlan besorolás egy-egy újonnan kiosztott IP-tartományra.
- **Ismeretlen/fel nem ismerhető IP** (pl. helyi teszt, privát tartomány) esetén a magyar oldal marad az alapértelmezett — a célközönség elsődlegesen magyar (`docs/01_PROJECT_FOUNDATIONS.md`), ezért a biztonságosabb feltételezés a hazai nyelv.
- **Adatvédelmi vonatkozás**: az IP-címet a döntéshez átmenetileg használjuk, nem tároljuk; a sütibe csak a nyelvi eredmény kerül. `adatvedelem.html`/`en/privacy.html` és `sutik.html`/`en/cookies.html` frissítve ennek megfelelően (a `qt_lang` mint technikailag elengedhetetlen süti feltüntetve, hozzájárulás nélkül is jogszerű).
- Ellenőrzés: a döntési logikát (cookie már van / magyar IP / külföldi IP / ismeretlen IP, mind a négy eset) mock kérés-válasz objektumokkal, valamint a `geoip-lite` országfelismerését több ismert magyar és külföldi IP-tartománnyal (HU, US, AU, DE, SK) node-ban igazoltuk. Élesben is igazolva `curl`-lal (`X-Forwarded-For` fejléc szimulációval): külföldi IP → 302 + `qt_lang=en`; magyar IP → 200 + `qt_lang=hu`; meglévő `qt_lang=hu` süti mellett külföldi IP → 200, nincs új átirányítás/süti-felülírás.

### ADR-015 – SEO-alapok: dinamikus sitemap + canonical/hreflang minden oldalpáron

- Állapot: **ELFOGADOTT**
- Dátum: 2026-08-23
- Döntés: (1) `public/robots.txt` — mindent enged, hivatkozik a sitemapra. (2) `GET /sitemap.xml` — **dinamikusan** generált a `server.js`-ben, a `tools` táblából (ugyanaz a forrás, mint a `/api/tools`-nál), nem statikus fájl. (3) Mind a 9 HU/EN oldalpár (18 fájl) `<head>`-jébe `rel="canonical"` (önmagára) és `rel="alternate" hreflang="hu/en/x-default"` címkék kerültek.
- Indok: a felhasználó jó Google-helyezést szeretne; ezek a ténylegesen helyezést/indexelést befolyásoló, korábban hiányzó alapelemek (szemben a CSS beágyazásával, aminek nincs SEO-hatása).
- **Miért dinamikus sitemap, nem statikus fájl**: a tools tábla már most 6 tétel, és minden új tool hozzáadásakor (eddig 6 alkalommal történt) egy statikus sitemapot el kellene felejteni frissíteni — ez pontosan az a fajta csendes elavulás, amit a `/api/tools` minta is elkerül. A `/sitemap.xml` végpont `Cache-Control: public, max-age=3600`-at kap (nem esik az OPS-001/ADR-011 `/api`-only `no-store` middleware alá, mert nem `/api` előtagú — ez tudatos, hiszen egy sitemapnak nem kell azonnal frissülnie minden kéréshez, az 1 órás cache ésszerű).
- **hreflang `x-default`**: mindig a magyar verzióra mutat, összhangban az I18N-001 (ADR-014) saját alapértelmezésével (ismeretlen látogató → magyar oldal).
- **Tudatosan kimaradt ebből a körből**: schema.org strukturált adat az egyes toolokhoz — inkább "nice to have", nem alapkövetelmény, külön kérésre pótolható.
- Ellenőrzés: a sitemap XML-generáló logikáját Node.js-ben önállóan futtatva igazoltuk (18 `<url>` bejegyzés, helyes hreflang-párosítás — beleértve az eltérő fájlnevű `adatvedelem.html`/`en/privacy.html` és `sutik.html`/`en/cookies.html` párokat is), `node --check`-kel szintaktikailag hibátlan; mind a 18 HTML-fájlban `grep`-pel igazolva a `canonical` címke jelenléte.
