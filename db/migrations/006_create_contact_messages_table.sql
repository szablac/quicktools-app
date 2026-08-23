-- Cél: kapcsolatfelvételi/GDPR-érintetti csatorna a nyilvános email cím kiváltására
-- (PROD-002, ADR-009 kockázat lezárása) — a beérkező üzenetek adatbázisba kerülnek,
-- kézi ellenőrzés phpMyAdminban, nincs kimenő email-küldés/értesítés.
-- Backlog: PROD-002
-- Idempotens: igen (IF NOT EXISTS)
-- Előfeltétel: -
-- Rollback: DROP TABLE IF EXISTS contact_messages; (biztonságos, amíg nincs megőrzendő adat)

CREATE TABLE IF NOT EXISTS contact_messages (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NULL,
  email VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  is_read TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Ellenőrző lekérdezés (a migráció után futtatandó, üres eredményhalmazt vár):
-- SELECT * FROM contact_messages;
