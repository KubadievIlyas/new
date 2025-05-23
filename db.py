import pymysql

class Database:
    def __init__(self):
        self.connection = pymysql.connect(
            host='localhost',
            user='root',
            password='',
            database='new_technology',
            cursorclass=pymysql.cursors.DictCursor
        )

    def get_materials(self):
        with self.connection.cursor() as cursor:
            sql = "SELECT m.*, mt.type_name, mt.defect_percentage FROM Materials m JOIN MaterialTypes mt ON m.material_type_id = mt.material_type_id"
            cursor.execute(sql)
            return cursor.fetchall()

    def get_material_types(self):
        with self.connection.cursor() as cursor:
            cursor.execute("SELECT * FROM MaterialTypes")
            return cursor.fetchall()

    def get_suppliers_for_material(self, material_id):
        with self.connection.cursor() as cursor:
            sql = "SELECT p.partner_name, p.rating, ms.start_date FROM MaterialSuppliers ms JOIN Partners p ON ms.partner_id = p.partner_id WHERE ms.material_id = %s"
            cursor.execute(sql, (material_id,))
            return cursor.fetchall()

    def add_material(self, data):
        with self.connection.cursor() as cursor:
            sql = "INSERT INTO Materials (material_type_id, material_name, unit_of_measure, quantity_in_stock, min_quantity, price_per_unit, package_quantity) VALUES (%s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, data)
            self.connection.commit()

    def update_material(self, material_id, data):
        with self.connection.cursor() as cursor:
            sql = "UPDATE Materials SET material_type_id=%s, material_name=%s, unit_of_measure=%s, quantity_in_stock=%s, min_quantity=%s, price_per_unit=%s, package_quantity=%s WHERE material_id=%s"
            cursor.execute(sql, (*data, material_id))
            self.connection.commit()

    def delete_material(self, material_id):
        with self.connection.cursor() as cursor:
            cursor.execute("DELETE FROM MaterialSuppliers WHERE material_id = %s", (material_id,))
            cursor.execute("DELETE FROM Materials WHERE material_id = %s", (material_id,))
            self.connection.commit()
            return cursor.rowcount > 0

    def close(self):
        self.connection.close()