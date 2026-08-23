-- Cél: Termékfotó Optimalizáló regisztrálása a tools táblában (TOOL-003)
-- Backlog: TOOL-003
-- Idempotens: igen (INSERT ... ON DUPLICATE KEY UPDATE a slug UNIQUE megszorítás miatt)
-- Rollback: DELETE FROM tools WHERE slug = 'product-photo-optimizer';

INSERT INTO tools (slug, name_hu, name_en, description_hu, description_en, category, is_active)
VALUES (
  'product-photo-optimizer',
  'Termékfotó Optimalizáló',
  'Product Photo Optimizer',
  'Fehér háttér, finom árnyék, középre igazítás, 1200×1200, automatikus WebP-tömörítés — webshop-eladóknak.',
  'White background, soft shadow, centering, 1200×1200, automatic WebP compression — for marketplace sellers.',
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
-- SELECT * FROM tools WHERE slug = 'product-photo-optimizer';
