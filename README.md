# QuickTools.hu

Mikroeszköz-gyűjtemény (toolbox) platform: sok kicsi, önmagában is hasznos webes segédeszköz (PDF, kép, SEO, AI, kalkulátor, konverter stb.) egy közös fiók/előfizetés alatt. Kezdettől kétnyelvű (HU+EN) felület.

Részletek: `docs/01_PROJECT_FOUNDATIONS.md` (cél, hatókör), `docs/09_DECISIONS.md` (döntések), `docs/roadmap/00_MASTER_PLAN.md` (fázisok).

## Gyors indítás

```text
npm install
npm start
```

Éles környezet: `https://quicktools.qwer.hu`, cPanel Node.js Selector (Passenger) alatt fut. A `server.js`-nek Passenger-kompatibilisnek kell maradnia (`server.listen()` argumentum nélkül).

## Dokumentáció

A teljes fejlesztési dokumentáció a `docs/` mappában, a `docs/00_INDEX.md`-ből kiindulva. A Claude Code / AI-eszközök belépési pontja a `CLAUDE.md`.
