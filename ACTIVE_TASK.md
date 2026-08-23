# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001, UX-002, I18N-001, SEO-001 KÉSZ |
| Aktív feladat | – (nincs kijelölt aktív tétel) |
| Állapot | `robots.txt` és dinamikus `sitemap.xml` élesben igazolva (18 URL, helyes hreflang-párosítás); `canonical`/`hreflang` címkék mind a 9 HU/EN oldalpáron élnek |
| Kiemelt következő feladat | Döntés kell: következő tool, vagy MON-001/002 (AdSense) folytatása |
| Aktuális kódmódosítás | – (minden pusholva és deployolva: `4701cb9`) |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-015 (2026-08-23, `ELFOGADOTT`) — dinamikus sitemap + canonical/hreflang minden oldalpáron |

## Következő pontos lépések

1. Döntés kell a felhasználótól: következő tool, vagy MON-001/MON-002 (AdSense-folytatás).
2. Amint a Google AdSense dönt, a hirdetéskód beillesztése (MON-001).
3. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

> Megjegyzés: a `temp_files/` mappában (gitignore-olt) még mindig van két érintetlen, érzékeny fájl (`db`, `github token`) — nem relevánsak jelenleg. A titkos SSH-kulcs (`~/.ssh/id_rsa_qwer`) megtartásáról/törléséről még nem született döntés — jelenleg nincs gyakorlati haszna, mivel a shell le van tiltva a fiókon.

## Legutóbbi interakciók

- **SSH-vizsgálat lezárva**: a cPanel-generált SSH-kulcs hitelesítése sikeres, de a szerver megerősítette, hogy a shell-hozzáférés le van tiltva a fiókon. ADR-006 véglegesítve.
- **SEO-001 implementáció**: `robots.txt`, dinamikus `GET /sitemap.xml` (a `tools` táblából), `canonical`+`hreflang` címkék mind a 9 HU/EN oldalpáron (18 fájl). Node.js-ben és `grep`-pel előzetesen igazolva (ADR-015).
- **Élő igazolás + lezárás**: commit `4701cb9`, push, cPanel Pull+Restart (migráció nem kellett). `curl`-lal igazolva: `/robots.txt` és `/sitemap.xml` 200-at ad, a sitemap 18 helyes URL-t tartalmaz (beleértve az eltérő fájlnevű `adatvedelem.html`↔`en/privacy.html` párost is), a `canonical` címke jelen van egy mintaoldalon. SEO-001 lezárva `DONE`-ra.

## Aktuális munkafájlok

– (minden pusholva, deployolva és élesben igazolva)

## Ellenőrzési állapot

- `https://quicktools.qwer.hu/robots.txt` és `.../sitemap.xml` 200-at ad, curl-lal igazolva.
- A sitemap 18 `<loc>` bejegyzést tartalmaz, ellenőrizve a helyes tartalommal.
- A `canonical` címke élesben igazolva egy mintaoldalon (`css-gradient-builder.html`).
