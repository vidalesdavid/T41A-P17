import psycopg2
import pytest

DB_CONFIG = {
    "dbname": "test_db",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": 5432
}

def run_query(query):
    with psycopg2.connect(**DB_CONFIG) as conn:
        with conn.cursor() as cur:
            cur.execute(query)
            try:
                return cur.fetchall()
            except:
                return None

# ======================================================
#                TESTS JSONB
# ======================================================

def test_jsonb_filtrar_color():
    result = run_query("""
        SELECT nombre FROM productos_jsonb
        WHERE specs->>'color' = 'rojo';
    """)
    assert len(result) == 1
    assert result[0][0] == "Tenis deportivos"

def test_jsonb_filtrar_categoria():
    result = run_query("""
        SELECT COUNT(*) FROM productos_jsonb
        WHERE specs->>'categoria' = 'electronica';
    """)
    assert result[0][0] == 2   # Laptop & Smartphone

def test_jsonb_indice_gin_existe():
    result = run_query("""
        SELECT indexname FROM pg_indexes 
        WHERE indexname = 'idx_specs_gin';
    """)
    assert len(result) == 1

# ======================================================
#                TESTS HSTORE
# ======================================================

def test_hstore_filtrar_color():
    result = run_query("""
        SELECT nombre FROM productos_hstore
        WHERE atributos->'color' = 'rojo';
    """)
    assert len(result) == 1
    assert result[0][0] == "Audífonos"

def test_hstore_operador_clave():
    result = run_query("""
        SELECT COUNT(*) FROM productos_hstore
        WHERE atributos ? 'marca';
    """)
    assert result[0][0] == 5  # Todos tienen marca

def test_hstore_indice_gin_existe():
    result = run_query("""
        SELECT indexname FROM pg_indexes
        WHERE indexname = 'idx_hstore_gin';
    """)
    assert len(result) == 1

def test_hstore_resumen_funcion():
    result = run_query("""
        SELECT resumen_producto(atributos)
        FROM productos_hstore
        WHERE id = 1;
    """)
    assert "Resumen:" in result[0][0]
