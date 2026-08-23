-- Cél: Színkontraszt Ellenőrző regisztrálása a tools táblában (TOOL-005)
-- Backlog: TOOL-005
-- Idempotens: igen (INSERT ... ON DUPLICATE KEY UPDATE a slug UNIQUE megszorítás miatt)
-- Rollback: DELETE FROM tools WHERE slug = 'color-contrast-checker';

INSERT INTO tools (slug, name_hu, name_en, description_hu, description_en, category, is_active)
VALUES (
  'color-contrast-checker',
  'Színkontraszt Ellenőrző',
  'Color Contrast Checker',
  'Válassz szöveg- és háttérszínt — azonnal megkapod a WCAG kontrasztarányt, és hogy megfelel-e az AA/AAA szintnek.',
  'Pick a text and background color — instantly get the WCAG contrast ratio, and whether it passes AA/AAA.',
  'Fejlesztői eszközök',
  1
)
ON DUPLICATE KEY UPDATE
  name_hu = VALUES(name_hu),
  name_en = VALUES(name_en),
  description_hu = VALUES(description_hu),
  description_en = VALUES(description_en),
  category = VALUES(category),
  is_active = VALUES(is_active);

-- Ellenőrző lekérdezés:
-- SELECT * FROM tools WHERE slug = 'color-contrast-checker';
