-- Cél: CSS Gradient Builder regisztrálása a tools táblában (TOOL-006)
-- Backlog: TOOL-006
-- Idempotens: igen (INSERT ... ON DUPLICATE KEY UPDATE a slug UNIQUE megszorítás miatt)
-- Rollback: DELETE FROM tools WHERE slug = 'css-gradient-builder';

INSERT INTO tools (slug, name_hu, name_en, description_hu, description_en, category, is_active)
VALUES (
  'css-gradient-builder',
  'CSS Gradient Builder',
  'CSS Gradient Builder',
  'Állíts össze lineáris vagy sugárirányú színátmenetet tetszőleges számú színnel, és másold ki azonnal a CSS-t vagy a Tailwind osztályt.',
  'Build a linear or radial gradient with any number of colors, and copy the CSS or Tailwind class instantly.',
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
-- SELECT * FROM tools WHERE slug = 'css-gradient-builder';
