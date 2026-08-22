# [PROJEKTNÉV] – Telepítési és üzemeltetési útmutató

> Ha egy szakasz erre a projektre nem értelmezhető (pl. nincs adatbázis, nincs production-környezet), hagyd üresen vagy jelöld nem-relevánsnak – ne töröld a szakaszt, hogy a struktúra újrafelhasználható maradjon.

## 1. Előfeltételek

- [KITÖLTENDŐ: futtatókörnyezet, verziók]

## 2. Projektmappa

```text
[KITÖLTENDŐ – könyvtárszerkezet]
```

## 3. Első biztonsági ellenőrzés

```text
git status --short
git diff
```

Ne használj `git reset --hard`, `git checkout .` vagy fájlfelülírást addig, amíg nem tisztázott, mi veszne el.

## 4. Környezeti beállítás

- [KITÖLTENDŐ: `.env` vagy egyéb konfiguráció]

Biztonsági szabály: titok/kulcs/jelszó nincs verziókezelésben, nem kerül AI-nak, dokumentációnak vagy naplóba.

## 5. Függőségek

```text
[KITÖLTENDŐ – install parancs]
```

## 6. Adatbázis / adattár (ha releváns)

- [KITÖLTENDŐ – séma, migráció, seed]

## 7. Fejlesztői indítás

```text
[KITÖLTENDŐ]
```

## 8. Build ellenőrzés

```text
[KITÖLTENDŐ]
```

A build sikere nem bizonyítja a teljes üzleti működést.

## 9. Production futtatás

- [KITÖLTENDŐ]

## 10. Mentés

- [KITÖLTENDŐ – mit kell együtt menteni, hova]

## 11. Visszaállítás

1. Állítsd le vagy tedd karbantartási módba az alkalmazást.
2. Készíts külön mentést a visszaállítás előtti állapotról.
3. Ellenőrizd a mentés forrását és méretét.
4. Állítsd vissza külön teszt-környezetbe, ha lehetséges.
5. Ellenőrizd a fő funkciókat.
6. Csak ezután engedélyezd a normál használatot.

## 12. Frissítési ellenőrzőlista

- [ ] Git munkafa tisztázva.
- [ ] Friss mentés.
- [ ] Changelog/migrációk áttekintve.
- [ ] Függőség-telepítés sikeres.
- [ ] Build sikeres.
- [ ] Alapfunkció-smoke sikeres.
- [ ] `ACTIVE_TASK.md` és `VALTOZASOK.md` friss.

## 13. Gyakori hibák

- [KITÖLTENDŐ, ahogy felmerülnek]
