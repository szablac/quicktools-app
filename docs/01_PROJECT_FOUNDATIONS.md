# 01 – Projektalapok és döntési keret

> Ez a dokumentum egy ÁLTALÁNOS döntési keret, nem egy konkrét projekt kitöltött űrlapja. Azt írja le, MILYEN kérdéskörökön kell végigmenni egy vadonatúj projekt indításakor – a válaszok (amik specifikusak) csak az induló kérdés-válasz kör UTÁN kerülnek ide.
>
> Kizárólag új, most induló projektre vonatkozik – nem meglévő kódbázis/projekt utólagos dokumentálására. Ha egy meglévő projektet kell dokumentálni, ez a keret akkor is használható kiindulásnak, de a kérdések sorrendje és súlya eltérhet.

## A kérdéskeret

Az induló beszélgetésben ezekben a kategóriákban kérdezz, ebben a nagyságrendi sorrendben – nem kell mindegyiket kimerítően végigvenni, csak annyira mélyen, amennyire a projekt mérete indokolja:

1. **Cél és probléma** – Mit épít a projekt, és milyen problémát old meg? Miért most?
2. **Célközönség / használó** – Kinek készül?
3. **Hatókör-határ** – Mi NEM tartozik bele (explicit kizárás ugyanolyan fontos, mint amit vállalunk)?
4. **Siker-kritérium** – Miről lehet megállapítani, hogy a projekt (vagy egy szakasza) kész és jó?
5. **Kényszerek és keretfeltételek** – Technológia, határidő, költség/erőforrás, jogi/megfelelőségi elvárás. Ha egyik sincs kikötve, azt is rögzítsd (`„szabadon választható”`).
6. **Érintettek és döntési jogkör** – Ki dönt üzleti/termék kérdésben, ki fejleszt.
7. **Kezdeti kockázatok** – Mi az, ami induláskor már látszik veszélyesnek/bizonytalannak.
8. **Munkamódszer** – Marad-e az alapértelmezett token-hatékony, könnyű ellenőrzési mód (`CLAUDE.md` 2. szakasz), vagy a projekt kockázati profilja miatt már induláskor szigorúbb kell?

## Válaszok (kitöltés az induló beszélgetés után)

- Cél és probléma: QuickTools.hu egy mikroeszköz-gyűjtemény (toolbox) platform lesz — sok kicsi, önmagában is hasznos webes segédeszköz (PDF, kép, SEO, AI, kalkulátor, konverter stb.) egy közös fiók/előfizetés alatt. Az ötletlista forrása egy korábbi AI-konzultáció (`E:\Dropbox\Work\micro app ötletek.docx`).
- Célközönség: kezdetben elsősorban magyar felhasználók (kisvállalkozók, grafikusok, fejlesztők, webshop-tulajdonosok), de a felület **kezdettől kétnyelvű (HU+EN)**, mert a magyar piac önmagában szűk.
- Hatókör-határ: MVP-ben NEM cél egyszerre sok (50-100+) eszköz; NEM cél éles fizetős előfizetés induláskor (a keret felépül, a tényleges fizetési integráció külön backlog-tétel); NEM cél natív mobilalkalmazás induláskor (PWA-ként indul).
- Siker-kritérium: a platform-váz (fiók/bejelentkezés-keret, tool-regisztrációs keret, előfizetés-keret) elkészül, és rajta él az első valódi eszköz (Favicon Generator) a `quicktools.qwer.hu` aldomainen.
- Kényszerek: Frontend Vue, Backend Node.js (Express javasolt és elfogadott — indoklás: `docs/09_DECISIONS.md` ADR-001); adatbázis MariaDB/MySQL; aldomain `quicktools.qwer.hu`, önálló, új cPanel-hoszting; nincs határidő, nincs kifejezett budget-korlát.
- Érintettek: egyedül a felhasználó (termék- és üzleti döntéshozó, egyben fejlesztő is) + Claude Code mint fejlesztő-asszisztens.
- Kezdeti kockázatok: (1) scope creep — nagyon sok ötlet van, könnyű elveszni bennük; (2) korai túlbonyolítás — előfizetés/fizetés/AI-kredit rendszer élesítése még túl korai, amíg nincs éles felhasználó; (3) a hosting-fiókon nincs shell-hozzáférés, ami korlátozza a deploy-automatizálást (lásd `docs/09_DECISIONS.md` ADR-006).
- Munkamódszer: alapértelmezett, token-hatékony könnyű ellenőrzési mód (`CLAUDE.md` 2. szakasz); szigorúbb ellenőrzés csak fizetés/jogosultság/törlés érintésekor lesz kötelező.

> Nyitott, még nem lezárt kérdés: a felhasználó jelezte, hogy a monetizációs modellen módosítana a dokumentumban javasolthoz képest, de a részleteket még nem adta meg — lásd `ACTIVE_TASK.md`.

## Ami innen tovább öröklődik

A fenti válaszok alapozzák meg a `docs/04_DOMAIN_RULES.md` (üzleti szabályok), `docs/03_ARCHITECTURE.md` (technológiai irány) és `docs/10_BACKLOG.md` (első feladatok) kitöltését – ne ismételd meg ott a választ, hivatkozz vissza ide.
