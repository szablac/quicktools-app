# 04 – Üzleti modell és kanonikus szabályok

## Fő entitások

| Entitás | Leírás |
|---|---|
| Tool | Egy önálló mikroeszköz (pl. Favicon Generator). Adatbázisban regisztrált, hogy új eszköz felvétele ne igényeljen kódszintű route-listát máshol. |

> Felhasználói fiók, előfizetés egyelőre **nincs** entitásként — lásd Nyitott üzleti döntések.

## Szerepkörök / jogosultsági szintek

_(nincs jogosultsági szint egyelőre — lásd alább)_

## Kanonikus invariánsok

### DR-001 – Nyilvános hozzáférés, fiók nélkül

Minden aktív (`is_active = 1`) tool regisztráció/bejelentkezés nélkül, nyilvánosan használható. Ez a keret nem tartalmaz fiók-, session- vagy jogosultsági logikát — ha ez a jövőben változik (pl. Pro-funkciók bevezetésekor), ez a szabály és a hozzá tartozó backend-ellenőrzés felülvizsgálandó.

### DR-002 – Tool-slug egyediség

A `tools.slug` mező egyedi, URL-safe azonosító (pl. `favicon-generator`), ez határozza meg a tool publikus útvonalát. Kódban és adatbázisban is kényszerítve (DB: `UNIQUE` megszorítás).

## Nyitott üzleti döntések

- Felhasználói fiók, session-kezelés, előfizetési szintek (`free`/`pro`) bevezetése: **elhalasztva**, amíg nincs tényleges ok rá (pl. Pro-funkció vagy éles fizetés). Amikor aktuálissá válik, itt és a `docs/09_DECISIONS.md`-ben kell rögzíteni.
