OPTIONS (SKIP=1)
LOAD DATA
CHARACTERSET UTF8
INFILE 'cliente.csv'
INTO TABLE cliente
FIELDS TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS(
    ID_CLIENTE              "TRIM(:ID_CLIENTE)",
    NOMBRE                  "TRIM(:NOMBRE)",
    APELLIDO                "TRIM(:APELLIDO)",
    DIRECCION               "TRIM(:DIRECCION)",
    TELEFONO                "TRIM(:TELEFONO)",
    TARGETA                 "TRIM(:TARGETA)",
    EDAD                    "TRIM(:EDAD)",
    SALARIO                 "TRIM(:SALARIO)",
    GENERO                  "TRIM(:GENERO)",
    PAIS_ID_PAIS            "TRIM(:PAIS_ID_PAIS)"
)

