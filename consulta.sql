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
GROUP BY p.ID_PAIS, p.NOMBRE ORDER BY monto DESC
FETCH FIRST 5 ROWS ONLY
;

