-- Cél: JSON Viewer regisztrálása a tools táblában (TOOL-002)
-- Backlog: TOOL-002
-- Idempotens: igen (INSERT ... ON DUPLICATE KEY UPDATE a slug UNIQUE megszorítás miatt)
-- Rollback: DELETE FROM tools WHERE slug = 'json-viewer';

INSERT INTO tools (slug, name_hu, name_en, description_hu, description_en, category, is_active)
VALUES (
  'json-viewer',
  'JSON Viewer',
  'JSON Viewer',
  'Illessz be egy JSON-t, és azonnal áttekinthető, összecsukható fastruktúrát kapsz — validálással.',
  'Paste a JSON payload and get an instant, collapsible tree view — with validation.',
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
-- SELECT * FROM tools WHERE slug = 'json-viewer';
