¿Por qué usaste LEFT JOIN para la Consulta 1 y no INNER JOIN?

Se utilizó un LEFT JOIN entre la tabla de productos (tabla de la izquierda) y la tabla ventas (tabla de la derecha porque se querían mostrar todos los productos de la tabla producto, inclusive aquellos productos que no tengan una venta asociada.
No se utilizó INNER JOIN porque la pregunta de negocio es sobre productos que no tienen ventas, y un INNER JOIN solo devuelve las filas donde hay coincidencia en ambas tablas. 
Con INNER JOIN, los productos 108 (Hub USB-C) y 109 (Parlante Bluetooth) desaparecerían del resultado directamente, porque ninguno tiene ninguna venta asociada.

¿Por qué usaste RIGHT JOIN para la Consulta 2? ¿Qué tabla está a la izquierda y cuál a la derecha?

Se usa RIGHT JOIN porque la pregunta de negocio es sobre ventas que no tienen un producto válido en el catálogo, y esas ventas viven en la tabla de la derecha (tabla de ventas). Un RIGHT JOIN garantiza que todas las filas de ventas (tabla de la derecha) aparezcan en el resultado, tengan o no un producto que coincida (tabla de la izquierda). De esta manera, la venta_id 10 (con producto_id 999, que no existe en el catálogo) no desaparece del resultado.
La tabla productos está a la izquierda y la tabla ventas está a la derecha.

¿Qué representan los valores NULL en cada resultado?

Un NULL en estas consultas no es un error ni un dato faltante por descuido. Es la señal de que no hubo coincidencia entre las dos tablas para esa fila.
En la Consulta 1, que venta_id sea NULL significa que ese producto nunca apareció en ninguna venta. Los producto 108 y 109 aparecen con NULL porque que nunca fueron vendidos.
En la Consulta 2, que producto_id (del lado de productos) sea NULL significa que esa venta hace referencia a un producto que no existe en el catálogo. La venta_id 10 es NULL porque no tiene ninguna fila correspondiente en productos; es el registro huérfano que indica un posible error de carga de datos.

¿Cuándo usarías FULL OUTER JOIN en un caso real de negocio?

Se utilizaría FULL OUTER JOIN cuando se quieren ver todas las filas de ambas tablas en el resultado; por ejemplo en análisis de integridad, auditoría o validación de datos ya que permite ver tanto coincidencias como ausencias en ambas tablas. También se puede utilizar en procesos de migración de datos ya que en una sola consulta permite detectar tanto los registros que se perdieron (existen en origen, no en destino) como los que se generaron de más o por error (existen en destino, no en origen) sin necesitar dos consultas separadas.
