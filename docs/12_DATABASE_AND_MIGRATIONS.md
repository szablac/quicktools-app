# 12 – Adatbázis és migrációs szabályok

> *Csak akkor releváns, ha a projektnek van adatbázisa/perzisztens adattára. Ha nincs, hagyd üresen.*

## Jelenlegi séma / adatmodell

- [KITÖLTENDŐ – vagy hivatkozás a séma-fájlra]

## Migrációs konvenció

- [KITÖLTENDŐ – mappaszerkezet, elnevezés, sorrend]

## Új migráció kötelező tartalma

- egyedi, monoton sorszám és beszédes név;
- cél és üzleti indok kommentben;
- idempotens futás;
- előfeltételek;
- ellenőrző lekérdezés;
- rollback vagy helyreállítási terv;
- kapcsolódó backlog-ID.

## Migrációs folyamat

1. Friss mentés.
2. Teszt-környezetben próba (ha van ilyen a projektben – lásd `docs/09_DECISIONS.md`).
3. Séma-/kulcsadat-ellenőrzés.
4. Dokumentáció és changelog.
5. Éles futtatás kontrollált ablakban.

## Adattípusok / integritási cél

- [KITÖLTENDŐ]

## Destruktív változás

Oszlop/tábla törlés csak akkor: a kód már nem használja; kereséssel igazolt; mentés és rollback rendelkezésre áll; felhasználó jóváhagyta.
