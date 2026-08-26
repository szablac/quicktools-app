-- Cél: Nyomtatható PDF Készítő regisztrálása a tools táblában (TOOL-007)
-- Backlog: TOOL-007
-- Idempotens: igen (INSERT ... ON DUPLICATE KEY UPDATE a slug UNIQUE megszorítás miatt)
-- Rollback: DELETE FROM tools WHERE slug = 'pdf-maker';

INSERT INTO tools (slug, name_hu, name_en, description_hu, description_en, category, is_active)
VALUES (
  'pdf-maker',
  'Nyomtatható PDF Készítő',
  'Printable PDF Maker',
  'Állíts össze egy nyomtatható PDF-et képekből és szövegből (Markdown-formázással) — A4 vagy A3 méretben, tetszőleges sorrendben.',
  'Combine images and text (with Markdown formatting) into a single printable PDF — A4 or A3 size, in any order.',
  'PDF',
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
-- SELECT * FROM tools WHERE slug = 'pdf-maker';
