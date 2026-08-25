# ACTIVE_TASK – aktuális fejlesztési állapot

> Ezt a fájlt Claude Code a beszélgetés elején elolvassa és minden érdemi (nem tiszta kérdés-válasz) kérés végén frissíti. Legfeljebb az utolsó 3 interakció maradjon benne; tartós információ a backlogba (`docs/10_BACKLOG.md`), döntési naplóba (`docs/09_DECISIONS.md`) vagy változásnaplóba (`VALTOZASOK.md`) kerüljön.

## Aktuális állapot

| Mező | Érték |
|---|---|
| Fázis | 1 – Platform-váz + TOOL-001..006 KÉSZ; PROD-002, OPS-001, UX-001, UX-002, I18N-001, SEO-001, OPS-002 KÉSZ; MON-001 hirdetéskód+consent élesben igazolva, Google-jóváhagyásra vár |
| Aktív feladat | – (nincs kijelölt aktív tétel; a Google-oldali AdSense-jóváhagyás automatikusan fut a háttérben, nem rajtunk múlik) |
| Állapot | `adsbygoogle.js` élesben fut mind a 18 HU/EN oldalon, GDPR consent-üzenet HU+EN nyelven közzétéve és élesben látszik. A deploy első alkalommal az új `scripts/deploy.sh`-val történt SSH-n keresztül (kilépési kód 0). |
| Kiemelt következő feladat | Döntés kell: következő tool (pl. Markdown → PDF), vagy más nyitott tétel |
| Aktuális kódmódosítás | – (minden pusholva és deployolva: `a5cb5f6`) |
| Blokkoló | – (a felhasználó megkérte az AdSense újra-felülvizsgálatát a hirdetéskód-hiány javítása után; napok kérdése lehet, nem rajtunk múlik) |
| Utolsó tartós döntés | ADR-017 (2026-08-23, `ELFOGADOTT`) — AdSense hirdetéskód + Google Funding Choices GDPR consent-üzenet |

## Következő pontos lépések

1. Döntés kell a felhasználótól: következő tool, vagy más nyitott tétel.
2. A Google AdSense felülvizsgálat mostantól a hirdetéskóddal együtt fut — ha Google újra visszajelez (pl. "Kész" állapotra vált), érdemes lesz ránézni, de aktív teendő most nincs vele.
3. Design-canvas: [https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5](https://claude.ai/code/artifact/1841a9b0-a360-427e-9c55-d2c41fe69ba5) — referenciaként megmarad.

> Megjegyzés: az `ads.txt` fájl a `qwer.hu` gyökerében (`/home/szablac/public_html/ads.txt`) lett manuálisan elhelyezve — ez **nem** része a `quicktools-app` git repónak.

> Megjegyzés: a `temp_files/` mappában (gitignore-olt) még mindig van két érintetlen, érzékeny fájl (`db`, `github token`) — nem relevánsak jelenleg.

> Megjegyzés: a `beerbelly.qwer.hu` projekthez is szeretne a felhasználó SSH-hozzáférést — ugyanaz a kulcs működni fog, de ezt a projekt saját munkamenetében kell átbeszélni.

## Legutóbbi interakciók

- **MON-001 — AdSense hirdetéskód + GDPR consent-üzenet**: a felhasználó megadta a publisher ID-t, majd lépésről lépésre (screenshotok alapján) végigmentünk a Google Funding Choices consent-üzenet beállításán (webhely-kiválasztás, kötelező logó — gyorsan generálva `jimp`-pel —, elutasítás-gomb, "bezárás=nincs beleegyezés", magyar nyelv hozzáadása), mielőtt a hirdetéskódot élesítettük volna. A felhasználó megerősítette: „Közzétéve", HU+EN nyelvi lefedettséggel.
- **Kód beépítve + dokumentálva**: `adsbygoogle.js` mind a 18 HU/EN oldalra, `sutik.html`/`en/cookies.html` szövege jelen időre frissítve. ADR-017 rögzítve. Commit `a5cb5f6`, push.
- **Élő deploy + igazolás**: első alkalommal az új `scripts/deploy.sh`-t használtuk SSH-n keresztül (kilépési kód 0, git pull sikeresen lehúzta mind a 21 fájlt). `curl`-lal igazolva: a főoldal és egy tool-oldal is tartalmazza a hirdetéskódot, a `sutik.html` frissült szövege él.
- **AdSense újra-felülvizsgálat kérve**: a felhasználó megmutatta a "qwer.hu — A webhelyen még nem jeleníthetők meg hirdetések" jelzést (a hirdetéskód-hiány miatti korábbi irányelvsértés), majd a hirdetéskód élesítése után bepipálta a "Megerősítem, hogy javítottam a hibákat" jelölőnégyzetet és megkérte a felülvizsgálatot. Ez már Google-oldali, nem rajtunk múlik, napok kérdése lehet.

## Aktuális munkafájlok

– (minden pusholva, deployolva és élesben igazolva)

## Ellenőrzési állapot

- `https://quicktools.qwer.hu/` és egy minta tool-oldal (`css-gradient-builder.html`) is tartalmazza a `client=ca-pub-2290062414680227` hirdetéskódot — curl-lal igazolva.
- `https://quicktools.qwer.hu/sutik.html` a frissített, jelen idejű AdSense-szöveget mutatja.
- A GDPR consent-üzenet HU+EN nyelven "Közzétéve" állapotban van (a felhasználó saját AdSense-fiókjában megerősítve).
