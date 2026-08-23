-- Cél: PDF Oldal Kiválasztó regisztrálása a tools táblában (TOOL-004)
-- Backlog: TOOL-004
-- Idempotens: igen (INSERT ... ON DUPLICATE KEY UPDATE a slug UNIQUE megszorítás miatt)
-- Rollback: DELETE FROM tools WHERE slug = 'pdf-page-selector';

INSERT INTO tools (slug, name_hu, name_en, description_hu, description_en, category, is_active)
VALUES (
  'pdf-page-selector',
  'PDF Oldal Kiválasztó',
  'PDF Page Selector',
  'Tölts fel egy PDF-et, jelöld ki az oldalakat, és töltsd le csak a kiválasztottakat — vagy távolítsd el csak azokat. Minden a böngésződben történik.',
  'Upload a PDF, select pages, and download only the ones you picked — or remove just those. Everything happens in your browser.',
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
-- SELECT * FROM tools WHERE slug = 'pdf-page-selector';
