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
