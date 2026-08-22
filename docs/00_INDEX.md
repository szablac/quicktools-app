# 00 – Kanonikus dokumentációs index

## Forráshitelességi sorrend

Konfliktus esetén ezt a sorrendet használd:

1. A felhasználó aktuális, egyértelmű utasítása.
2. A felhasználó által elfogadott döntés a `docs/09_DECISIONS.md` fájlban.
3. Az aktuális feladat és állapot az `ACTIVE_TASK.md` fájlban.
4. A témához tartozó kanonikus dokumentum.
5. A tényleges forráskód/adat mint jelenlegi megvalósítási bizonyíték.
6. A változásnapló (`VALTOZASOK.md`).
7. A történeti archívum (`docs/archive/`).

A jelenlegi kód nem automatikusan a kívánt működés hiteles forrása: lehet benne hiba. Ha a kód és a kanonikus szabály ellentmond, jelezd, és a backlog alapján javítsd vagy kérj döntést.

## Mindig megnyitandó (a beszélgetés elején)

- `CLAUDE.md`
- `ACTIVE_TASK.md`
- ez a fájl

## Feladattípus szerinti olvasás

| Feladat | Kötelező dokumentumok | Szükség esetén |
|---|---|---|
| Új funkció | `01`, `03`, `04`, `06`, `10` | `13`, `11`, `12` |
| Hiba | `03`, `04`, `05`, `06`, `10` | `11`, `12`, `docs/audit/` |
| Jogosultság/biztonság | `05`, `04`, `10` | `11`, `08` |
| Adat/adatbázis/migráció | `12`, `05`, `10` | `TELEPITES.md` |
| UI/felület | `13`, `04`, `06`, `10` | `07` |
| Telepítés/mentés | `TELEPITES.md`, `08`, `12` | `05` |
| Prioritás/tervezés | `roadmap/00_MASTER_PLAN.md`, `10_BACKLOG.md` | `09_DECISIONS.md` |
| Régi regresszió eredete | aktuális kanonikus fájl + célzott archív keresés | teljes archívum csak végső esetben |

> **[KITÖLTENDŐ, ha a projekt saját dokumentum-számozást vezet be]**: itt frissítsd a táblázatot.

## Dokumentumok rövid szerepe

Lásd a gyökér `MANIFEST.md`-t a teljes listáért.

## Tokenkímélési szabály

- Ne olvasd be automatikusan az összes dokumentumot.
- Előbb keress címszóra vagy backlog-azonosítóra (célzott keresés/grep).
- A nagy audit- és archív anyagot csak konkrét indokkal nyisd meg.
- Tartós tudást ne másolj több fájlba; linkelj a kanonikus helyre.
