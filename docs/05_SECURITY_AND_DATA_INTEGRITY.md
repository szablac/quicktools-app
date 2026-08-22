# 05 – Biztonsági és adatintegritási minimum

> Checklist-jellegű dokumentum – pipáld/töltsd ki, ahogy a projekt igényli. Ami nem releváns, maradjon üresen jelölve, ne törölve.

## Hitelesítés és munkamenet

- [ ] [KITÖLTENDŐ – pl. munkamenet-kezelés módja]
- [ ] Szerepkör/jogosultság mindig a jelenlegi (nem gyorsítótárazott/elavult) állapot alapján érvényesül.

## Jogosultság-ellenőrzés

- [ ] Minden érzékeny művelet szerveroldalon is ellenőrzött (a kliens-oldali elrejtés nem védelem).

## Adatvédelem / titkok

- [ ] Titok/kulcs/jelszó nincs verziókezelésben.
- [ ] Titok nem kerül naplóba, dokumentációba, kliensválaszba.

## Adatintegritás

- [ ] Többlépéses adatváltoztatás tranzakcióban.
- [ ] Pénzügyi/mennyiségi mezőknél az explicit nulla és a hiányzó érték megkülönböztetett.
- [ ] Történeti/lezárt adat módosítása szerveroldalon is tiltott vagy explicit újranyitáshoz kötött.

## Bemenet-validáció

- [ ] [KITÖLTENDŐ]

## Ismert, tudatosan vállalt kockázat

- [KITÖLTENDŐ vagy „nincs”]
