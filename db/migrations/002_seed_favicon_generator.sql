-- Cél: Favicon Generator regisztrálása a tools táblában (TOOL-001)
-- Backlog: TOOL-001
-- Idempotens: igen (INSERT ... ON DUPLICATE KEY UPDATE a slug UNIQUE megszorítás miatt)
-- Rollback: DELETE FROM tools WHERE slug = 'favicon-generator';

INSERT INTO tools (slug, name_hu, name_en, description_hu, description_en, category, is_active)
VALUES (
  'favicon-generator',
  'Favicon Generátor',
  'Favicon Generator',
  'Tölts fel egy logót, és generálj teljes favicon-csomagot (ico, png méretek, webmanifest) egy kattintással.',
  'Upload a logo and generate a full favicon package (ico, png sizes, webmanifest) in one click.',
  'Kép/Design',
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
-- SELECT * FROM tools WHERE slug = 'favicon-generator';
