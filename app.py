from flask import Flask, jsonify
import cx_Oracle

app = Flask(__name__)

try:
    conexion = cx_Oracle.connect(
        user = 'userproyecto',
        password = 'oracle123',
        dsn = 'localhost/xe',
        encoding = 'UTF-8'
    )
    @app.route('/')
    def index():
        return "Hello World!"
    
    @app.route('/consulta1', methods = ['GET'])
    def consulta1():
        try:
            cur = conexion.cursor()
            consulta = '''
            SELECT c.ID_CLIENTE, C.NOMBRE, c.APELLIDO, p.NOMBRE AS "PAIS", SUM(o.CANTIDAD * pro.PRECIO) AS monto
            FROM CLIENTE c, ORDEN o, PAIS p, PRODUCTO pro
            WHERE c.ID_CLIENTE = o.CLIENTE_ID_CLIENTE AND pro.ID_PRODUCTO = o.PRODUCTO_ID_PRODUCTO
            AND c.PAIS_ID_PAIS = p.ID_PAIS
            GROUP BY c.ID_CLIENTE, C.NOMBRE, p.NOMBRE, c.APELLIDO ORDER BY monto DESC
            FETCH FIRST 1 ROWS ONLY
            '''
            cur.execute(consulta)
            rows = cur.fetchall()
            REPORTE = ''
            REPORTE += '''
            <table border = '1'>
                <thead>
                    <tr>
                        <th>ID_CLIENTE</th>
                        <th>NOMBRE</th>
                        <th>APELLIDO</th>
                        <th>PAIS</th>
                        <th>MONTO TOTAL</th>
                    </tr>
                </thead>
                <tbody>
            '''
            for row in rows:
                REPORTE += '<tr>'
                for column in row:
                    REPORTE += f'''<td>{column}</td>'''
                REPORTE += '</tr>'
            REPORTE += '''
                </tbody>
            </table>
            '''
            return REPORTE

        except Exception as err:
            print('Error ', err)
            return err
    
    @app.route('/consulta2')
    def consulta2():
        try:
            cur = conexion.cursor()
            consulta = '''
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
            FETCH FIRST 1 ROWS ONLY)
            '''

            cur.execute(consulta)
            rows = cur.fetchall()
            REPORTE = ''
            REPORTE += '''
            <table border = '1'>
                <thead>
                    <tr>
                        <th>ID_PRODUCTO</th>
                        <th>NOMBRE</th>
                        <th>CATEGORIA</th>
                        <th>CANTIDAD UNIDADES</th>
                        <th>MONTO VENDIDO</th>
                    </tr>
                </thead>
                <tbody>
            '''
            for row in rows:
                REPORTE += '<tr>'
                for column in row:
                    REPORTE += f'''<td>{column}</td>'''
                REPORTE += '</tr>'
            REPORTE += '''
                </tbody>
            </table>
            '''
            return REPORTE
        except Exception as err:
            print('Error ', err)
            return err
    
    @app.route('/consulta3', methods = ['GET'])
    def consulta3():
        try:
            cur = conexion.cursor()
            consulta = '''
            SELECT v.ID_VENDEDOR, v.NOMBRE, SUM(o.CANTIDAD * p.PRECIO) AS monto
            FROM ORDEN o, VENDEDOR v, PRODUCTO p
            WHERE o.VENDEDOR_ID_VENDEDOR = v.ID_VENDEDOR AND p.ID_PRODUCTO = o.PRODUCTO_ID_PRODUCTO
            GROUP BY v.ID_VENDEDOR, v.NOMBRE ORDER BY monto DESC
            FETCH FIRST 1 ROWS ONLY
            '''

            cur.execute(consulta)
            rows = cur.fetchall()
            REPORTE = ''
            REPORTE += '''
            <table border = '1'>
                <thead>
                    <tr>
                        <th>ID_VENDEDOR</th>
                        <th>NOMBRE</th>
                        <th>MONTO TOTAL</th>
                    </tr>
                </thead>
                <tbody>
            '''
            for row in rows:
                REPORTE += '<tr>'
                for column in row:
                    REPORTE += f'''<td>{column}</td>'''
                REPORTE += '</tr>'
            REPORTE += '''
                </tbody>
            </table>
            '''
            return REPORTE

        except Exception as err:
            print(err)
    
    @app.route('/consulta4', methods = ['GET'])
    def consulta4():
        try:
            cur = conexion.cursor()
            consulta = '''
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
            '''

            cur.execute(consulta)
            rows = cur.fetchall()
            REPORTE = ''
            REPORTE += '''
            <table border = '1'>
                <thead>
                    <tr>
                        <th>NOMBRE</th>
                        <th>MONTO TOTAL</th>
                    </tr>
                </thead>
                <tbody>
            '''
            for row in rows:
                REPORTE += '<tr>'
                for column in row:
                    REPORTE += f'''<td>{column}</td>'''
                REPORTE += '</tr>'
            REPORTE += '''
                </tbody>
            </table>
            '''
            return REPORTE
        except Exception as err:
            print(err)
    
    @app.route('/consulta5', methods = ['GET'])
    def consulta5():
        try:
            cur = conexion.cursor()
            consulta = '''
            SELECT p.ID_PAIS, p.NOMBRE, SUM(o.CANTIDAD * pro.PRECIO) AS monto
            FROM ORDEN o, PRODUCTO pro, PAIS p, CLIENTE c
            WHERE o.CLIENTE_ID_CLIENTE = c.ID_CLIENTE
            AND o.PRODUCTO_ID_PRODUCTO = pro.ID_PRODUCTO
            AND c.PAIS_ID_PAIS = p.ID_PAIS
            GROUP BY p.ID_PAIS, p.NOMBRE ORDER BY monto DESC
            FETCH FIRST 5 ROWS ONLY
            '''

            cur.execute(consulta)
            rows = cur.fetchall()
            REPORTE = ''
            REPORTE += '''
            <table border = '1'>
                <thead>
                    <tr>
                        <th>ID_PAIS</th>
                        <th>NOMBRE</th>
                        <th>MONTO TOTAL</th>
                    </tr>
                </thead>
                <tbody>
            '''
            for row in rows:
                REPORTE += '<tr>'
                for column in row:
                    REPORTE += f'''<td>{column}</td>'''
                REPORTE += '</tr>'
            REPORTE += '''
                </tbody>
            </table>
            '''
            return REPORTE
        except Exception as err:
            print(err)


    if __name__ == "__main__":
        app.run(threaded=True, port=5000, debug=True)

except Exception as err:
    print('Error ', err)
else:
    print('Conectado a db')
conexion.close()