# 12 – Adatbázis és migrációs szabályok

> *Csak akkor releváns, ha a projektnek van adatbázisa/perzisztens adattára. Ha nincs, hagyd üresen.*

## Jelenlegi séma / adatmodell

- `tools` tábla (PLAT-001 óta): `id, slug (UNIQUE), name_hu, name_en, description_hu, description_en, category, is_active, created_at`. Lásd `db/migrations/001_create_tools_table.sql`.

## Migrációs konvenció

- Mappa: `db/migrations/`, fájlnév `NNN_leíró_név.sql` (monoton sorszám, `001`-től).
- **Futtatás módja**: mivel a cPanel-fiókon nincs shell-hozzáférés (lásd ADR-006), a migrációkat egyelőre **kézzel, phpMyAdmin SQL-fülén** kell lefuttatni éles adatbázison. A fájl a repóban csak dokumentáció/verziókövetés célját szolgálja, nem fut automatikusan.
- Adattípus-szabály: logikai (igaz/hamis) mezőkhöz mindig `TINYINT(1)` használandó, **soha ne `CHAR(1)` `'0'`/`'1'`** — a WorkSheet projektben ez ismételten dátum-/típushibát okozott (a `'0'` string JavaScriptben truthy). Lásd `CLAUDE.md` 5. szakasz.

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
