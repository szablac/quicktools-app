# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001, UX-002, I18N-001 KÉSZ; SEO-001 kódja kész, deploy hátravan |
| Aktív feladat | SEO-001 — commit/push/deploy jóváhagyásra vár |
| Állapot | `robots.txt` + dinamikus `GET /sitemap.xml` (a `tools` táblából, sosem lesz elavult) + `canonical`/`hreflang` címkék mind a 9 HU/EN oldalpáron (18 fájl). SSH-vizsgálat is lezárva (ADR-006 frissítve: shell letiltva, végleg megerősítve). | 
| Kiemelt következő feladat | Commit + push jóváhagyása, cPanel Pull+Restart (migráció nem kell), élő ellenőrzés (`/robots.txt`, `/sitemap.xml`) |
| Aktuális kódmódosítás | `server.js` (sitemap route), `public/robots.txt` (új), 18 HTML-fájl (canonical+hreflang), `docs/09_DECISIONS.md` (ADR-006 kiegészítve, ADR-015 új), `docs/10_BACKLOG.md`, `ACTIVE_TASK.md` — helyben, még nincs commitolva |
| Blokkoló | – (Google AdSense felülvizsgálat, MON-001, a háttérben fut, nem blokkol) |
| Utolsó tartós döntés | ADR-015 (2026-08-23, `ELFOGADOTT`) — dinamikus sitemap + canonical/hreflang minden oldalpáron |

## Következő pontos lépések

1. Commit + push jóváhagyása.
2. cPanel Git Version Control „Pull” + Setup Node.js App „Restart” (nincs migráció, `package.json` sem változott).
3. Élő ellenőrzés: `curl` a `/robots.txt`-re és `/sitemap.xml`-re (200, helyes tartalom, 18 URL).
4. Ezután SEO-001 lezárható `DONE`-ra; utána újra döntés kell: következő tool, vagy MON-001/002 (AdSense) folytatása.
5. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — a 3 modern irány (E/F/G) referenciaként megmarad, ha később újragondoljuk a designt.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

> Megjegyzés: a `temp_files/` mappában (gitignore-olt) még mindig van két érintetlen, érzékeny fájl (`db`, `github token`) — nem relevánsak jelenleg. A titkos SSH-kulcs (`~/.ssh/id_rsa_qwer`) megtartásáról/törléséről még nem született döntés — jelenleg nincs gyakorlati haszna, mivel a shell le van tiltva a fiókon.

## Legutóbbi interakciók

- **SSH-vizsgálat lezárva**: a felhasználó megadott egy cPanel-generált SSH-kulcsot és jelszót. Egyetlen óvatos kapcsolódási teszttel (Imunify360/IP-tiltás elkerülése miatt) megerősítettük: a hitelesítés sikeres, de a szerver válasza szerint a shell-hozzáférés le van tiltva a fiókon. ADR-006 frissítve ezzel a végleges eredménnyel.
- **SEO-001 implementáció**: a felhasználó kérésére (jó Google-helyezést szeretne) pótoltuk a korábban azonosított hiányzó SEO-alapokat: `public/robots.txt`, dinamikus `GET /sitemap.xml` a `tools` táblából (nem statikus fájl, hogy sose maradjon el a valóságtól), valamint `rel="canonical"` + `hreflang` (hu/en/x-default) címkék mind a 9 HU/EN oldalpáron (index, 6 tool, adatvedelem/privacy, sutik/cookies — 18 fájl). Schema.org strukturált adat tudatosan kimaradt ebből a körből (nice-to-have).
- **Ellenőrzés**: a sitemap XML-generáló logikát Node.js-ben önállóan futtatva igazoltuk (18 helyes `<url>` bejegyzés, korrekt hreflang-párosítás az eltérő fájlnevű oldalpároknál — pl. `adatvedelem.html`↔`en/privacy.html` — is), `node --check` hibátlan, `grep`-pel igazolva mind a 18 fájlban a `canonical` címke jelenléte.

## Aktuális munkafájlok

- `server.js` – `GET /sitemap.xml` dinamikus route
- `public/robots.txt` – új fájl
- 18 HTML-fájl (`index`, 6 tool, `adatvedelem`/`privacy`, `sutik`/`cookies`, HU+EN) – `canonical`+`hreflang` címkék

## Ellenőrzési állapot

- `node --check server.js`: szintaktikailag hibátlan.
- A sitemap XML-generálás Node.js-ben önállóan futtatva igazolva: 18 `<url>` bejegyzés, helyes hreflang-párosítás.
- Mind a 18 HTML-fájlban `grep`-pel igazolva a `canonical` címke jelenléte.
- **Még nincs ellenőrizve**: élő (quicktools.qwer.hu) viselkedés — deploy szükséges hozzá.
