# 07 – Tesztelési stratégia

> Alapból KÖNNYŰ üzemmód (lásd `CLAUDE.md` 2. szakasz) – ez a dokumentum akkor válik élessé, ha a projekt mérete/kockázata indokolja a formálisabb tesztelést.

## Jelenlegi helyzet

- [KITÖLTENDŐ]

## Eszközök

- [KITÖLTENDŐ, ha van választott teszt-eszköz]

A felhasználó jóváhagyása nélkül ne cseréld le a teljes toolchaint.

## Tesztpiramis (ha releváns)

### Unit

- [KITÖLTENDŐ]

### Integráció

- [KITÖLTENDŐ]

### Végponttól végpontig / kézi smoke

- [KITÖLTENDŐ]

## Minőségi kapu kockázat szerint

| Kockázat | Elvárás |
|---|---|
| Alacsony (UI-kozmetika, doksi) | Átolvasás |
| Közepes (átlagos funkció/hiba) | Célzott smoke |
| Magas (pénzügy, jogosultság, törlés, import/export) | Build + automatikus teszt (ha van) + kézi regresszió |

## Tesztelési bizonyosság nyelve

- „Build sikeres” ≠ „a funkció működik”.
- „Statikus ellenőrzés sikeres” ≠ „integráció működik”.
- „Célzott teszt zöld” ≠ „nincs más regresszió”.
- A fejlesztési összefoglaló mindig pontosan nevezze meg, mi lett ellenőrizve.
