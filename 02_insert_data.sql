INSERT INTO usuarios (data)
VALUES 
  ('{"nombre": "Ana", "activo": true, "edad": 30}'),
  ('{"nombre": "Juan", "activo": false, "edad": 25}');

-- ===========================================
--      INSERTS JSONB
-- ===========================================
INSERT INTO productos_jsonb (nombre, specs) VALUES
('Tenis deportivos', '{"color": "rojo", "talla": "27", "categoria": "ropa"}'),
('Laptop', '{"color": "gris", "ram": "16GB", "categoria": "electronica"}'),
('Camisa', '{"color": "azul", "talla": "M", "material": "algodon"}'),
('Smartphone', '{"color": "negro", "almacenamiento": "128GB", "categoria": "electronica"}'),
('Silla', '{"color": "negro", "material": "metal", "categoria": "muebles"}');

-- ===========================================
--      INSERTS HSTORE
-- ===========================================
INSERT INTO productos_hstore (nombre, atributos) VALUES
('TV Sony', 'marca=>"Sony", color=>"negro", peso=>"10kg"'),
('Audífonos', 'marca=>"Sony", color=>"rojo"'),
('Laptop Dell', 'marca=>"Dell", peso=>"1.5kg"'),
('Mouse Logitech', 'marca=>"Logitech", color=>"azul"'),
('Teclado Logitech', 'marca=>"Logitech", peso=>"0.9kg"');

