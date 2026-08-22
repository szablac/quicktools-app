# 03 – Architektúra

## Rétegek / komponensek

| Réteg | Technológia | Felelősség |
|---|---|---|
| Kliens | Vue 3 (később: Vite, PWA) | Felhasználói felület, HU+EN |
| Szerver/API | Node.js, Express (javasolt) | Üzleti logika, tool-endpointok |
| Adattár | MariaDB/MySQL (`szablac_quicktools`) | Fiókok, tool-regisztráció, előfizetés-adatok |
| Hosting/Futtatás | cPanel + CloudLinux Node.js Selector (Passenger) | `quicktools.qwer.hu`, önálló szerver |
| Verziókövetés/Deploy | Git (GitHub `szablac/quicktools-app`) + cPanel Git Version Control | Kód szinkronizálása a szerverre |

## Könyvtárszerkezet

```text
quicktools-app/
├── server.js       # jelenleg: smoke-teszt Passenger-belépési pont
├── package.json
├── docs/
└── (később: client/ – Vue frontend, server/ – strukturált backend)
```

## Célállapot vs. jelenlegi állapot

- Célállapot: teljes platform-váz (fiók, tool-regisztrációs keret, előfizetés-keret) + Vue frontend + több mikroeszköz.
- Jelenlegi állapot (Fázis 0 lezárva, 2026-08-22): csak egy minimális, Passenger-kompatibilis smoke-teszt Node szerver fut élesben, adatbázis létrehozva de még nincs bekötve a kódba. Nincs frontend, nincs fiókkezelés, nincs egyetlen valódi eszköz sem.

## Kritikus tervezési döntések

- Lásd `docs/09_DECISIONS.md` (ADR-001 – ADR-006).

## Ismert korlátok

- A cPanel-fiókon **nincs shell/SSH-hozzáférés** engedélyezve a szolgáltató által → a Git deploy jelenleg csak publikus GitHub-repóról, HTTPS-en keresztül működik, SSH deploy key nem használható. A repó emiatt ideiglenesen **publikus** (lásd ADR-006).
- Minden szerver-oldali kódfrissítés jelenleg **manuális**: cPanel Git Version Control „Pull" → Setup Node.js App „Run NPM Install" (ha változott a package.json) → „Restart". Nincs automatikus deploy-hook.
- A Node.js Selector (`server.listen()` argumentum nélkül) speciális Passenger-konvenciót követel — ezt minden jövőbeli szerver-belépési pontnak be kell tartania.
