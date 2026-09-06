-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs
-- Autor: [Tu nombre]
-- Fecha: [Fecha de entrega]
-- ══════════════════════════════════════════

USE MiniStore

-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca fueron vendidos?
-- Mostrá todos los productos y sus ventas asociadas.
-- Los productos sin ventas aparecerán con NULL en las columnas de ventas.

SELECT p.producto_id,
       p.nombre,
       p.categoria,
       v.venta_id,
       v.cantidad,
       v.fecha_venta
FROM productos p
LEFT JOIN ventas v ON p.producto_id = v.producto_id
ORDER BY p.producto_id;

-- No se agrega WHERE porque el criterio de aceptación pide mostrar los 9
-- productos del catálogo (incluyendo los 2 sin ventas), no solo las filas
-- con NULL. El filtro WHERE ventas.venta_id IS NULL del Tip aislaría
-- únicamente esos 2 productos, dejando fuera el resto del catálogo.

-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos
-- que no figuran en nuestro catálogo? (posible error de carga de datos)
-- Los registros huérfanos aparecerán con NULL en las columnas de productos.

SELECT p.producto_id,
       p.nombre,
       v.venta_id,
       v.producto_id AS producto_id_venta, -- se agrega para contrastar con p.producto_id cuando es huérfana
       v.cliente_id,
       v.cantidad,
       v.fecha_venta
FROM productos p
RIGHT JOIN ventas v ON p.producto_id = v.producto_id
ORDER BY v.venta_id;

-- No se agrega WHERE por el mismo criterio que en la Consulta 1: se prioriza
-- mostrar todas las ventas (incluyendo la huérfana con producto_id = 999)
-- en su contexto completo, en vez de aislar únicamente el registro con NULL.

-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría que muestre
-- todos los productos y todas las ventas sin perder ninguna fila,
-- identificando tanto productos sin ventas como ventas sin producto.

SELECT p.producto_id,
       p.nombre,
       v.venta_id,
       v.producto_id AS producto_id_venta,
       v.cliente_id,
       v.cantidad,
       v.fecha_venta
FROM productos p
FULL OUTER JOIN ventas v ON p.producto_id = v.producto_id
ORDER BY p.producto_id, v.venta_id;

-- No se agrega WHERE porque el criterio de aceptación exige explícitamente
-- mostrar todas las filas de ambas tablas sin perder ninguna; un filtro
-- WHERE IS NULL excluiría todas las filas con coincidencia, contradiciendo
-- ese requisito.