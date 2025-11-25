CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  data JSONB
);
-- ===========================================
--      ACTIVAR EXTENSIONES NECESARIAS
-- ===========================================
CREATE EXTENSION IF NOT EXISTS hstore;

-- ===========================================
--      TABLA CON JSONB
-- ===========================================
DROP TABLE IF EXISTS productos_jsonb CASCADE;

CREATE TABLE productos_jsonb (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    specs JSONB NOT NULL
);

-- ===========================================
--      TABLA CON HSTORE
-- ===========================================
DROP TABLE IF EXISTS productos_hstore CASCADE;

CREATE TABLE productos_hstore (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    atributos HSTORE
);

-- ===========================================
--   FUNCION PARA RESUMEN DE ATRIBUTOS
-- ===========================================
CREATE OR REPLACE FUNCTION resumen_producto(attr HSTORE)
RETURNS TEXT AS $$
BEGIN
    RETURN 'Resumen: ' || hstore_to_json(attr)::text;
END;
$$ LANGUAGE plpgsql;

-- ===========================================
--      ÍNDICES
-- ===========================================
CREATE INDEX idx_specs_gin ON productos_jsonb USING GIN (specs);
CREATE INDEX idx_hstore_gin ON productos_hstore USING GIN (atributos);

