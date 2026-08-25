# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001, UX-002, I18N-001, SEO-001, OPS-002 KÉSZ; MON-001 (AdSense hirdetéskód + consent) kódja kész, deploy hátravan |
| Aktív feladat | MON-001 — commit/push/deploy jóváhagyásra vár |
| Állapot | `adsbygoogle.js` (`ca-pub-2290062414680227`) beépítve mind a 18 HU/EN oldalra. Google Funding Choices GDPR consent-üzenet közzétéve HU+EN nyelven (elutasítás-gombbal, "bezárás=nincs beleegyezés" beállítással). `sutik.html`/`en/cookies.html` frissítve jelen időre. |
| Kiemelt következő feladat | Commit + push jóváhagyása, cPanel Pull+Restart (migráció/npm install nem kell), élő ellenőrzés |
| Aktuális kódmódosítás | 18 HTML-fájl (`adsbygoogle.js` script tag), `public/sutik.html`, `public/en/cookies.html` (szövegfrissítés), `docs/09_DECISIONS.md` (ADR-017), `docs/10_BACKLOG.md` — helyben, még nincs commitolva |
| Blokkoló | – |
| Utolsó tartós döntés | ADR-017 (2026-08-23, `ELFOGADOTT`) — AdSense hirdetéskód + Google Funding Choices GDPR consent-üzenet |

## Következő pontos lépések

1. Commit + push jóváhagyása.
2. cPanel Git Version Control „Pull” + Setup Node.js App „Restart” (nincs migráció, `package.json` sem változott) — vagy az új `scripts/deploy.sh` SSH-n keresztül.
3. Élő ellenőrzés: a hirdetéskód és a consent-üzenet megjelenik-e élesben.
4. Ezután MON-001 lezárható `VERIFY`-ra (a tényleges Google-jóváhagyásra még várni kell, az a Google oldalán történik).
5. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — referenciaként megmarad.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

> Megjegyzés: a `temp_files/` mappában (gitignore-olt) még mindig van két érintetlen, érzékeny fájl (`db`, `github token`) — nem relevánsak jelenleg.

> Megjegyzés: a `beerbelly.qwer.hu` projekthez is szeretne a felhasználó SSH-hozzáférést — ugyanaz a kulcs működni fog, de ezt a projekt saját munkamenetében kell átbeszélni.

## Legutóbbi interakciók

- **OPS-002 sikeresen tesztelve élesben**: `scripts/deploy.sh` lefuttatva SSH-n keresztül, kilépési kód 0, utóellenőrzés rendben (commit `aac822d`, `3a7a9c3`).
- **MON-001 — AdSense "beavatkozást igényel"**: a felhasználó screenshotot küldött az AdSense "Webhelyek kezelése" oldaláról, ami a hirdetéskód hiányát jelezte. Megadta a publisher ID-t (`pub-2290062414680227`).
- **GDPR consent-üzenet együttes kialakítása**: mielőtt beillesztettem a hirdetéskódot, flaggeltem, hogy a `sutik.html` már korábban ígért egy consent-bannert, ami még nem létezett. Lépésről lépésre (screenshotok alapján) végigvezettem a felhasználót a Google Funding Choices ("Európai szabályozások") beállításán: webhely-kiválasztás, kötelező logó (ehhez gyorsan generáltam egy egyszerű PNG-t `jimp`-pel, elküldve `SendUserFile`-lal), elutasítás-gomb bekapcsolása, "bezárás=nincs beleegyezés" bekapcsolása, magyar nyelv hozzáadása, majd közzététel — a felhasználó megerősítette: „Közzétéve", HU+EN nyelvi lefedettséggel.
- **Kód beépítése + dokumentáció**: az `adsbygoogle.js` script mind a 18 HU/EN oldalra bekerült (grep-pel igazolva, pontosan egyszer mindenhol), a Cookie szabályzat szövege jelen időre frissítve. ADR-017 rögzítve.

## Aktuális munkafájlok

- 18 HTML-fájl – `adsbygoogle.js` script tag hozzáadva
- `public/sutik.html`, `public/en/cookies.html` – AdSense szöveg jelen időre frissítve

## Ellenőrzési állapot

- `grep`-pel igazolva: mind a 18 fájlban pontosan egyszer szerepel a hirdetéskód.
- A felhasználó az AdSense felületén megerősítette a GDPR-üzenet "Közzétéve" állapotát, HU+EN nyelvi lefedettséggel.
- **Még nincs ellenőrizve**: élő (quicktools.qwer.hu) viselkedés — deploy szükséges hozzá.
