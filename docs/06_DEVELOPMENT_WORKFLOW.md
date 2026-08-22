# 06 – Fejlesztési munkafolyamat

> Ez a dokumentum a `CLAUDE.md` 2–3. szakaszának részletezése. Alapból már token-hatékony, könnyű üzemmódra van hangolva – csak akkor szigorítsd (és rögzítsd `docs/09_DECISIONS.md`-ben, miért), ha a projekt kockázati profilja indokolja.

## Egy fejlesztési kör menete

1. Kérés osztályozása (kérdés / hiba / funkció / adat / UI / biztonság / üzemeltetés / dokumentáció).
2. Célzott dokumentum-olvasás a `docs/00_INDEX.md` táblázata szerint.
3. Kapcsolódó backlog-tétel megkeresése/létrehozása (`docs/10_BACKLOG.md`).
4. Tényleges kód/adat vizsgálata módosítás előtt.
5. Legkisebb biztonságos változtatási csomag megvalósítása.
6. Ellenőrzés a kockázathoz mért szinten (lásd alább).
7. `ACTIVE_TASK.md` frissítés, szükség esetén backlog/döntés/changelog frissítés.
8. Commit-javaslat – commit/push csak felhasználói engedéllyel.

## Ellenőrzési szintek (válaszd a kockázathoz mérten)

| Szint | Mikor | Mit jelent |
|---|---|---|
| Minimál | Tiszta kérdés, dokumentáció, kis kozmetikai módosítás | Vizuális/logikai átolvasás elég |
| Célzott smoke | Legtöbb funkció-/hibajavítás | Egy konkrét, érintett útvonal/funkció kézi vagy böngészős kipróbálása |
| Teljes | Pénzügyi/jogosultsági/törlési/import-export logika, vagy felhasználó explicit kéri | Build + automatikus teszt (ha van) + kézi regressziós smoke |

## Mikor KELL build/automatikus teszt

- A felhasználó explicit kéri.
- Pénzügyi, jogosultsági, lezárási, törlési, import/export logikát érint a változás.
- `docs/09_DECISIONS.md` másképp nem rendelkezik.

## Kód-minőségi alapelvek

- Legkisebb biztonságos, visszaellenőrizhető csomag.
- Reprodukálás/felmérés a javítás előtt.
- Meglévő megoldás keresése új logika írása előtt; duplikáció helyett közös függvény.
- Nincs premature abstraction – three similar lines is better than a premature abstraction.
- Nincs feature flag/kompatibilitási shim, ha egyszerűen át lehet írni a kódot.
- Nincs felesleges kommentár – csak akkor, ha a MIÉRT nem-nyilvánvaló.

## Commit-fegyelem

- Minden logikai egység végén commit-javaslat, de commit/push csak külön engedéllyel.
- Commit-üzenet a projekt saját nyelvén/konvenciója szerint (alapból magyar, imperatív/leíró forma).
