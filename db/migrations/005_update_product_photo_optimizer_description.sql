-- Cél: Termékfotó Optimalizáló leírásának frissítése (opcionális AI háttéreltávolítás hozzáadva)
-- Backlog: TOOL-003 (bővítés)
-- Idempotens: igen (UPDATE, felülírja ugyanazzal az értékkel, ha már lefutott)
-- Rollback: futtasd le újra a régi szöveggel (lásd 004_seed_product_photo_optimizer.sql eredeti értékei)

UPDATE tools
SET
  description_hu = 'Igény szerinti AI háttéreltávolítás, majd fehér háttér, árnyék, középre igazítás, 1200×1200, automatikus WebP-tömörítés.',
  description_en = 'Optional AI background removal, then white background, shadow, centering, 1200×1200, automatic WebP compression.'
WHERE slug = 'product-photo-optimizer';

-- Ellenőrző lekérdezés:
-- SELECT slug, description_hu, description_en FROM tools WHERE slug = 'product-photo-optimizer';
