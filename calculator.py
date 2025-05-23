from PyQt6.QtWidgets import (QDialog, QVBoxLayout, QTableWidget, QTableWidgetItem,
                             QLabel, QFormLayout, QSpinBox, QDoubleSpinBox, QPushButton)
from PyQt6.QtCore import Qt
from decimal import Decimal, getcontext


class CalculatorDialog(QDialog):
    def __init__(self, db, material_id):
        super().__init__()
        self.db = db
        self.material_id = material_id
        self.setWindowTitle("Расчеты по материалу")
        self.setModal(True)
        self.setMinimumWidth(600)
        getcontext().prec = 10
        self.init_ui()
        self.load_suppliers()

    def init_ui(self):
        layout = QVBoxLayout(self)
        layout.setContentsMargins(15, 15, 15, 15)

        self.suppliers_table = QTableWidget()
        self.suppliers_table.setColumnCount(3)
        self.suppliers_table.setHorizontalHeaderLabels(["Поставщик", "Рейтинг", "Дата начала работы"])
        self.suppliers_table.horizontalHeader().setStretchLastSection(True)
        self.suppliers_table.setStyleSheet("""
            QTableWidget { border: 1px solid #BBDCFA; border-radius: 5px; }
            QHeaderView::section { background-color: #0C4882; color: white; padding: 5px; }
        """)

        layout.addWidget(QLabel("Поставщики материала:"))
        layout.addWidget(self.suppliers_table)

        layout.addSpacing(15)
        layout.addWidget(QLabel("Расчет количества продукции:"))

        form_layout = QFormLayout()
        form_layout.setVerticalSpacing(10)

        self.product_type_spin = QSpinBox()
        self.product_type_spin.setRange(1, 100)
        form_layout.addRow("ID типа продукции:", self.product_type_spin)

        self.param1_spin = QDoubleSpinBox()
        self.param1_spin.setRange(0.01, 1000)
        self.param1_spin.setDecimals(4)
        form_layout.addRow("Параметр продукции 1:", self.param1_spin)

        self.param2_spin = QDoubleSpinBox()
        self.param2_spin.setRange(0.01, 1000)
        self.param2_spin.setDecimals(4)
        form_layout.addRow("Параметр продукции 2:", self.param2_spin)

        self.material_qty_spin = QDoubleSpinBox()
        self.material_qty_spin.setRange(0.01, 100000)
        self.material_qty_spin.setDecimals(4)
        form_layout.addRow("Количество сырья:", self.material_qty_spin)

        layout.addLayout(form_layout)

        self.calculate_button = QPushButton("Рассчитать")
        self.calculate_button.setStyleSheet("""
            QPushButton {
                background-color: #0C4882; color: white; padding: 8px 16px;
                border-radius: 4px; font-weight: bold; min-width: 100px;
            }
            QPushButton:hover { background-color: #1A6BB2; }
        """)
        self.calculate_button.clicked.connect(self.calculate_products)
        layout.addWidget(self.calculate_button, alignment=Qt.AlignmentFlag.AlignRight)

        self.result_label = QLabel("Результат: ")
        self.result_label.setStyleSheet("font-weight: bold;")
        layout.addWidget(self.result_label)

    def load_suppliers(self):
        suppliers = self.db.get_suppliers_for_material(self.material_id)
        self.suppliers_table.setRowCount(len(suppliers))

        for row, supplier in enumerate(suppliers):
            self.suppliers_table.setItem(row, 0, QTableWidgetItem(supplier['partner_name']))
            self.suppliers_table.setItem(row, 1, QTableWidgetItem(str(supplier['rating'])))
            self.suppliers_table.setItem(row, 2, QTableWidgetItem(supplier['start_date'].strftime('%d.%m.%Y')))

        self.suppliers_table.resizeColumnsToContents()

    def calculate_products(self):
        product_type_id = self.product_type_spin.value()
        param1 = Decimal(str(self.param1_spin.value()))
        param2 = Decimal(str(self.param2_spin.value()))
        material_qty = Decimal(str(self.material_qty_spin.value()))

        with self.db.connection.cursor() as cursor:
            cursor.execute(
                "SELECT type_coefficient FROM ProductTypes WHERE product_type_id = %s",
                (product_type_id,)
            )
            product_type = cursor.fetchone()

            cursor.execute("""
                SELECT mt.defect_percentage 
                FROM Materials m
                JOIN MaterialTypes mt ON m.material_type_id = mt.material_type_id
                WHERE m.material_id = %s
            """, (self.material_id,))
            material = cursor.fetchone()

            product_coeff = Decimal(str(product_type['type_coefficient']))
            defect_percent = Decimal(str(material['defect_percentage']))

            material_per_unit = param1 * param2 * product_coeff
            effective_material = material_qty * (Decimal('1') - defect_percent)
            product_qty = int(effective_material / material_per_unit)

            self.result_label.setText(
                f"<b>Результат:</b> {product_qty} единиц продукции<br>"
                f"<b>Коэффициент типа:</b> {float(product_coeff):.4f}<br>"
                f"<b>Потери материала:</b> {float(defect_percent) * 100:.2f}%<br>"
                f"<b>Эффективное количество сырья:</b> {float(effective_material):.4f}"
            )