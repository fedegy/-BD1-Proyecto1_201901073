/*Consulta 1 - Mostrar el cliente que más ha comprado. Se debe de mostrar el id del cliente,
nombre, apellido, país y monto total.*/
SELECT c.ID_CLIENTE, C.NOMBRE, c.APELLIDO, p.NOMBRE AS "PAIS", SUM(o.CANTIDAD * pro.PRECIO) AS monto
FROM CLIENTE c, ORDEN o, PAIS p, PRODUCTO pro
WHERE c.ID_CLIENTE = o.CLIENTE_ID_CLIENTE AND pro.ID_PRODUCTO = o.PRODUCTO_ID_PRODUCTO
AND c.PAIS_ID_PAIS = p.ID_PAIS
GROUP BY c.ID_CLIENTE, C.NOMBRE, p.NOMBRE, c.APELLIDO ORDER BY monto DESC
FETCH FIRST 1 ROWS ONLY;


/*Consulta 2 - Mostrar el producto más y menos comprado. Se debe mostrar el id del
producto, nombre del producto, categoría, cantidad de unidades y monto
vendido.
*/
(SELECT pro.ID_PRODUCTO, pro.NOMBRE, c.NOMBRE AS "CATEGORIA", SUM(o.CANTIDAD) AS cantidad
, SUM(o.CANTIDAD * pro.PRECIO) AS "MONTO"
FROM ORDEN o, PRODUCTO pro, CATEGORIA c
WHERE pro.ID_PRODUCTO = o.PRODUCTO_ID_PRODUCTO AND c.ID_CATEGORIA = pro.CATEGORIA_ID_CATEGORIA
GROUP BY pro.ID_PRODUCTO, pro.NOMBRE, c.NOMBRE
ORDER BY cantidad DESC
FETCH FIRST 1 ROWS ONLY)
UNION ALL
(SELECT pro.ID_PRODUCTO, pro.NOMBRE, c.NOMBRE AS "CATEGORIA", SUM(o.CANTIDAD) AS cantidad
, SUM(o.CANTIDAD * pro.PRECIO) AS "MONTO"
FROM ORDEN o, PRODUCTO pro, CATEGORIA c
WHERE pro.ID_PRODUCTO = o.PRODUCTO_ID_PRODUCTO AND c.ID_CATEGORIA = pro.CATEGORIA_ID_CATEGORIA
GROUP BY pro.ID_PRODUCTO, pro.NOMBRE, c.NOMBRE
ORDER BY cantidad ASC
FETCH FIRST 1 ROWS ONLY);
;

/*Consulta 3 - Mostrar a la persona que más ha vendido. Se debe mostrar el id del
vendedor, nombre del vendedor, monto total vendido.*/
SELECT v.ID_VENDEDOR, v.NOMBRE, SUM(o.CANTIDAD * p.PRECIO) AS monto
FROM ORDEN o, VENDEDOR v, PRODUCTO p
WHERE o.VENDEDOR_ID_VENDEDOR = v.ID_VENDEDOR AND p.ID_PRODUCTO = o.PRODUCTO_ID_PRODUCTO
GROUP BY v.ID_VENDEDOR, v.NOMBRE ORDER BY monto DESC
FETCH FIRST 1 ROWS ONLY
;

/*Consulta 4 - Mostrar el país que más y menos ha vendido. Debe mostrar el nombre del 
país y el monto. (Una sola consulta).*/
(SELECT p.NOMBRE, SUM(o.CANTIDAD * pro.PRECIO) AS monto
FROM ORDEN o, PRODUCTO pro, VENDEDOR v, PAIS p
WHERE o.VENDEDOR_ID_VENDEDOR = v.ID_VENDEDOR AND
o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO AND
v.PAIS_ID_PAIS = p.ID_PAIS
GROUP BY p.NOMBRE ORDER BY monto DESC
FETCH FIRST 1 ROWS ONLY)
UNION ALL
(SELECT p.NOMBRE, SUM(o.CANTIDAD * pro.PRECIO) AS monto
FROM ORDEN o, PRODUCTO pro, VENDEDOR v, PAIS p
WHERE o.VENDEDOR_ID_VENDEDOR = v.ID_VENDEDOR AND
o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO AND
v.PAIS_ID_PAIS = p.ID_PAIS
GROUP BY p.NOMBRE ORDER BY monto ASC
FETCH FIRST 1 ROWS ONLY)
;

/*Consulta 5 - Top 5 de países que más han comprado en orden ascendente. Se le solicita
mostrar el id del país, nombre y monto total.*/
SELECT p.ID_PAIS, p.NOMBRE, SUM(o.CANTIDAD * pro.PRECIO) AS monto
FROM ORDEN o, PRODUCTO pro, PAIS p, CLIENTE c
WHERE o.CLIENTE_ID_CLIENTE = c.ID_CLIENTE
AND o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO
AND c.PAIS_ID_PAIS = p.ID_PAIS
GROUP BY p.ID_PAIS, p.NOMBRE ORDER BY monto ASC
FETCH FIRST 5 ROWS ONLY
;

/*Consulta 6 - Mostrar la categoría que más y menos se ha comprado. Debe de mostrar el 
nombre de la categoría y cantidad de unidades. (Una sola consulta*/
(SELECT cat.NOMBRE, SUM(o.CANTIDAD) as cantidad
FROM ORDEN o, PRODUCTO pro, CATEGORIA cat
WHERE o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO
AND pro.CATEGORIA_ID_CATEGORIA = cat.ID_CATEGORIA
GROUP BY cat.NOMBRE
ORDER BY cantidad DESC
FETCH FIRST 1 ROWS ONLY)
UNION ALL
(SELECT cat.NOMBRE, SUM(o.CANTIDAD) as cantidad
FROM ORDEN o, PRODUCTO pro, CATEGORIA cat
WHERE o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO
AND pro.CATEGORIA_ID_CATEGORIA = cat.ID_CATEGORIA
GROUP BY cat.NOMBRE
ORDER BY cantidad ASC
FETCH FIRST 1 ROWS ONLY )
;

/*Consulta 7 - Mostrar la categoría más comprada por cada país. Se debe de mostrar el
nombre del país, nombre de la categoría y cantidad de unidades.*/
SELECT p.NOMBRE, cat.NOMBRE, SUM(o.CANTIDAD) as cantidad
FROM PAIS p, CATEGORIA cat, ORDEN o, PRODUCTO pro, CLIENTE c
WHERE o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO
AND pro.CATEGORIA_ID_CATEGORIA = cat.ID_CATEGORIA
AND o.CLIENTE_ID_CLIENTE = c.ID_CLIENTE
AND c.PAIS_ID_PAIS = p.ID_PAIS
GROUP BY p.NOMBRE, cat.NOMBRE ORDER BY cantidad DESC 
;

/*Consulta 8 - Mostrar las ventas por mes de Inglaterra. Debe de mostrar el número del mes
y el monto.
*/
SELECT EXTRACT(MONTH FROM o.FECHA_ORDEN) as mes, SUM(o.CANTIDAD * pro.PRECIO) as monto
FROM ORDEN o, VENDEDOR v, PRODUCTO pro, PAIS p
WHERE o.VENDEDOR_ID_VENDEDOR = v.ID_VENDEDOR
AND o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO
AND v.PAIS_ID_PAIS = p.ID_PAIS
AND p.NOMBRE = 'Inglaterra'
GROUP BY EXTRACT(MONTH FROM o.FECHA_ORDEN) ORDER BY mes ASC;


/*Consulta 9 - Mostrar el mes con más y menos ventas. Se debe de mostrar el número de
mes y monto. (Una sola consulta).*/
(SELECT EXTRACT(MONTH FROM o.FECHA_ORDEN) AS mes, SUM(o.CANTIDAD * pro.PRECIO) AS monto
FROM ORDEN o, PRODUCTO pro
WHERE o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO
GROUP BY EXTRACT(MONTH FROM o.FECHA_ORDEN) ORDER BY monto DESC
FETCH FIRST 1 ROWS ONLY)
UNION ALL
(SELECT EXTRACT(MONTH FROM o.FECHA_ORDEN) AS mes, SUM(o.CANTIDAD * pro.PRECIO) AS monto
FROM ORDEN o, PRODUCTO pro
WHERE o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO
GROUP BY EXTRACT(MONTH FROM o.FECHA_ORDEN) ORDER BY monto ASC
FETCH FIRST 1 ROWS ONLY)
;

/*Consulta 10 - Mostrar las ventas de cada producto de la categoría deportes. Se debe de
mostrar el id del producto, nombre y monto.*/
SELECT pro.ID_PRODUCTO, pro.NOMBRE, SUM(o.CANTIDAD * pro.PRECIO) AS monto
FROM PRODUCTO pro, ORDEN o, CATEGORIA cat
WHERE o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO
AND pro.CATEGORIA_ID_CATEGORIA = cat.ID_CATEGORIA
AND cat.NOMBRE = 'Deportes'
GROUP BY pro.ID_PRODUCTO, pro.NOMBRE ORDER BY pro.ID_PRODUCTO ASC;