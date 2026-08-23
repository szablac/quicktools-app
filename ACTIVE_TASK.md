# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001, UX-002, I18N-001 KÉSZ |
| Aktív feladat | – (nincs kijelölt aktív tétel) |
| Állapot | IP-alapú nyelvi útvonalválasztás élesben igazolva: külföldi IP → `/en/` átirányítás + `qt_lang=en` süti; magyar IP → marad a HU oldal + `qt_lang=hu` süti; már meglévő süti esetén nincs újra-átirányítás |
| Kiemelt következő feladat | Döntés kell: következő tool (pl. Markdown → PDF), vagy MON-001/002 (AdSense) folytatása |
| Aktuális kódmódosítás | – (minden pusholva és deployolva: `f702ba9`) |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-014 (2026-08-23, `ELFOGADOTT`) — IP-alapú nyelvi útvonalválasztás `geoip-lite`-tal, csak a gyökér útvonalon |

## Következő pontos lépések

1. Döntés kell a felhasználótól: következő tool, vagy MON-001/MON-002 (AdSense-folytatás).
2. Amint a Google AdSense dönt, a hirdetéskód beillesztése (MON-001).
3. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

## Legutóbbi interakciók

- **I18N-001 implementáció**: a felhasználó kérésére `geoip-lite`-alapú nyelvi útvonalválasztás `GET /`-re — magyar IP marad HU, külföldi átirányítva `/en/`-re, `qt_lang` süti véd a folyamatos újra-döntés ellen. Adatvédelmi tájékoztató és Cookie szabályzat frissítve (HU+EN) az IP-használat és az új süti feltüntetésével. `package.json` változott (új `geoip-lite` függőség), ezért a deploy körnél kötelező volt a cPanel „Run NPM Install” lépés is.
- **Élő igazolás**: commit `f702ba9`, push, cPanel Pull+NPM Install+Restart. `curl`-lal `X-Forwarded-For` szimulációval igazolva mind a 3 fő eset: külföldi IP → 302 + `qt_lang=en`; magyar IP → 200 + `qt_lang=hu`; meglévő `qt_lang=hu` süti + külföldi IP → 200, nincs újra-átirányítás/süti-felülírás.
- **Lezárás**: I18N-001 → `DONE`, ADR-014 → `ELFOGADOTT` a backlogban és a döntési naplóban.

## Aktuális munkafájlok

– (minden pusholva, deployolva és élesben igazolva)

## Ellenőrzési állapot

- `https://quicktools.qwer.hu/` élesben, `curl -i -H "X-Forwarded-For: <IP>"`-vel igazolva: 8.8.8.8 (US) → 302 `/en/` + `qt_lang=en`; 84.2.0.1 (HU) → 200 + `qt_lang=hu`; meglévő `qt_lang=hu` süti + 8.8.8.8 → 200, nincs beavatkozás.
