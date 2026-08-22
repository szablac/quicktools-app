# 11 – API-térkép

> *Csak akkor releváns, ha a projektnek van API-ja (REST/GraphQL/RPC/stb.). Ha nincs, hagyd üresen.*

## Végpontok

| Módszer | Útvonal | Cél | Jogosultság | Fájl:sor |
|---|---|---|---|---|
| GET | `/api/tools` | Aktív toolok listája (slug, név HU/EN, kategória) | nyilvános | `server.js` (tervezett) |

## Konvenciók

- Autentikáció: nincs (lásd `docs/04_DOMAIN_RULES.md` DR-001).
- Hibaválasz: `{ "error": "üzenet" }` JSON, megfelelő HTTP státuszkóddal. Nyers SQL-/stack-hiba a kliensnek soha nem küldhető (`CLAUDE.md` 4. szakasz).
