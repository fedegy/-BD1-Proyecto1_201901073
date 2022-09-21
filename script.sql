CREATE TABLE categoria (
    id_categoria INTEGER NOT NULL,
    nombre       VARCHAR2(100) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE cliente (
    id_cliente   INTEGER NOT NULL,
    nombre       VARCHAR2(100),
    apellido     VARCHAR2(100),
    direccion    VARCHAR2(250),
    telefono     INTEGER NOT NULL,
    targeta      INTEGER,
    edad         INTEGER,
    salario      NUMBER,
    genero       VARCHAR2(1),
    pais_id_pais INTEGER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE orden (
    id_orden             INTEGER,
    linea_orden          INTEGER,
    fecha_orden          DATE,
    cliente_id_cliente   INTEGER NOT NULL,
    vendedor_id_vendedor INTEGER NOT NULL,
    producto_id_producto INTEGER NOT NULL,
    cantidad             INTEGER
);

CREATE TABLE pais (
    id_pais INTEGER NOT NULL,
    nombre  VARCHAR2(100)
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE producto (
    id_producto            INTEGER NOT NULL,
    nombre                 VARCHAR2(100),
    precio                 NUMBER,
    categoria_id_categoria INTEGER NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE vendedor (
    id_vendedor  INTEGER NOT NULL,
    nombre       VARCHAR2(100),
    pais_id_pais INTEGER NOT NULL
);

ALTER TABLE vendedor ADD CONSTRAINT vendedor_pk PRIMARY KEY ( id_vendedor );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE orden
    ADD CONSTRAINT orden_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE orden
    ADD CONSTRAINT orden_producto_fk FOREIGN KEY ( producto_id_producto )
        REFERENCES producto ( id_producto );

ALTER TABLE orden
    ADD CONSTRAINT orden_vendedor_fk FOREIGN KEY ( vendedor_id_vendedor )
        REFERENCES vendedor ( id_vendedor );

ALTER TABLE producto
    ADD CONSTRAINT producto_categoria_fk FOREIGN KEY ( categoria_id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE vendedor
    ADD CONSTRAINT vendedor_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );