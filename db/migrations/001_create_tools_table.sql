-- Cél: tool-regisztrációs keret első táblája (PLAT-001) — új mikroeszköz
-- felvétele DB-rekordból történjen, ne igényeljen kódszintű route-listát.
-- Backlog: PLAT-001
-- Idempotens: igen (IF NOT EXISTS)
-- Rollback: DROP TABLE IF EXISTS tools; (biztonságos, a tábla még nem tartalmaz adatot)

CREATE TABLE IF NOT EXISTS tools (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(64) NOT NULL UNIQUE,
  name_hu VARCHAR(120) NOT NULL,
  name_en VARCHAR(120) NOT NULL,
  description_hu TEXT NULL,
  description_en TEXT NULL,
  category VARCHAR(64) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Ellenőrző lekérdezés (a migráció után futtatandó, üres eredményhalmazt vár):
-- SELECT * FROM tools;
