from PyQt6.QtWidgets import (QMainWindow, QVBoxLayout, QHBoxLayout, QLabel,
                             QWidget, QScrollArea, QPushButton, QMessageBox,
                             QSizePolicy, QSpacerItem, QFrame)
from PyQt6.QtCore import Qt, pyqtSignal
from PyQt6.QtGui import QIcon, QMouseEvent
from edit_dialog import EditDialog
from calculator import CalculatorDialog
from db import Database


class MaterialCard(QFrame):
    clicked = pyqtSignal(int)

    def __init__(self, material, parent=None):
        super().__init__(parent)
        self.material_id = material['material_id']
        self.setup_ui(material)

    def setup_ui(self, material):
        self.setObjectName("material-card")
        self.setStyleSheet("""
            QFrame#material-card { background-color: #FFFFFF; border: 1px solid #BBDCFA; border-radius: 5px; padding: 15px; }
            QFrame#material-card-selected { background-color: #FFFFFF; border: 2px solid #0C4882; border-radius: 5px; padding: 15px; }
        """)

        layout = QVBoxLayout(self)
        layout.setSpacing(5)

        header = QLabel(f"{material['type_name']} | {material['material_name']}")
        header.setStyleSheet("font-weight: bold; color: #0C4882; font-size: 14px; margin-bottom: 5px;")
        layout.addWidget(header)

        row1 = QWidget()
        row1_layout = QHBoxLayout(row1)
        row1_layout.setContentsMargins(0, 0, 0, 0)

        min_qty_label = QLabel(f"Минимальное количество: {material['min_quantity']} {material['unit_of_measure']}")
        row1_layout.addWidget(min_qty_label)

        cost_label = QLabel(f"Стоимость партии: {self.calculate_batch_cost(material):.2f} р")
        cost_label.setStyleSheet("font-weight: bold; color: #0C4882;")
        row1_layout.addWidget(cost_label, alignment=Qt.AlignmentFlag.AlignRight)
        layout.addWidget(row1)

        layout.addWidget(QLabel(f"Количество на складе: {material['quantity_in_stock']} {material['unit_of_measure']}"))
        layout.addWidget(QLabel(f"Цена: {material['price_per_unit']:.2f} р / Единица измерения: {material['unit_of_measure']}"))

    def calculate_batch_cost(self, material):
        if material['quantity_in_stock'] < material['min_quantity']:
            needed = material['min_quantity'] - material['quantity_in_stock']
            packages = int(needed // material['package_quantity']) + (1 if needed % material['package_quantity'] > 0 else 0)
            return packages * material['package_quantity'] * material['price_per_unit']
        return 0

    def mousePressEvent(self, event):
        self.clicked.emit(self.material_id)
        super().mousePressEvent(event)


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowIcon(QIcon('logo/icon.ico'))
        self.setWindowTitle("Управление материалами")
        self.setGeometry(100, 100, 800, 600)
        self.db = Database()
        self.selected_material_id = None
        self.material_cards = {}
        self.init_ui()
        self.load_data()

    def init_ui(self):
        main_widget = QWidget()
        main_layout = QVBoxLayout(main_widget)
        main_layout.setContentsMargins(0, 0, 0, 0)

        button_panel = QWidget()
        button_panel.setStyleSheet("background-color: #BBDCFA; padding: 10px;")
        button_layout = QHBoxLayout(button_panel)

        self.add_button = self.create_button("Добавить", self.add_material)
        self.edit_button = self.create_button("Редактировать", self.edit_material)
        self.delete_button = self.create_button("Удалить", self.delete_material)
        self.calculate_button = self.create_button("Расчеты", self.show_calculator)

        button_layout.addWidget(self.add_button)
        button_layout.addWidget(self.edit_button)
        button_layout.addWidget(self.delete_button)
        button_layout.addWidget(self.calculate_button)
        button_layout.addItem(QSpacerItem(40, 20, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum))

        self.scroll_area = QScrollArea()
        self.scroll_area.setWidgetResizable(True)
        self.container = QWidget()
        self.layout = QVBoxLayout(self.container)
        self.layout.setContentsMargins(15, 15, 15, 15)
        self.scroll_area.setWidget(self.container)

        main_layout.addWidget(button_panel)
        main_layout.addWidget(self.scroll_area)
        self.setCentralWidget(main_widget)

    def create_button(self, text, handler):
        button = QPushButton(text)
        button.setStyleSheet("""
            QPushButton { background-color: #0C4882; color: white; padding: 8px 15px; 
                         border-radius: 4px; min-width: 100px; }
            QPushButton:hover { background-color: #1A6BB2; }
        """)
        button.setFixedHeight(35)
        button.clicked.connect(handler)
        return button

    def load_data(self):
        for card in self.material_cards.values():
            card.setParent(None)
        self.material_cards.clear()

        for material in self.db.get_materials():
            card = MaterialCard(material)
            card.clicked.connect(self.on_material_selected)
            self.material_cards[material['material_id']] = card
            self.layout.addWidget(card)

            if self.selected_material_id == material['material_id']:
                card.setObjectName("material-card-selected")
                card.style().unpolish(card)
                card.style().polish(card)

        self.layout.addItem(QSpacerItem(20, 40, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding))

    def on_material_selected(self, material_id):
        if self.selected_material_id in self.material_cards:
            old_card = self.material_cards[self.selected_material_id]
            old_card.setObjectName("material-card")
            old_card.style().unpolish(old_card)
            old_card.style().polish(old_card)

        self.selected_material_id = material_id

        if material_id in self.material_cards:
            card = self.material_cards[material_id]
            card.setObjectName("material-card-selected")
            card.style().unpolish(card)
            card.style().polish(card)

    def add_material(self):
        EditDialog(self.db).exec()
        self.load_data()

    def edit_material(self):
        if not self.selected_material_id:
            QMessageBox.warning(self, "Ошибка", "Выберите материал")
            return
        EditDialog(self.db, self.selected_material_id).exec()
        self.load_data()

    def delete_material(self):
        if not self.selected_material_id:
            QMessageBox.warning(self, "Ошибка", "Выберите материал")
            return

        if QMessageBox.question(self, "Подтверждение", "Удалить материал?") == QMessageBox.StandardButton.Yes:
            self.db.delete_material(self.selected_material_id)
            self.selected_material_id = None
            self.load_data()

    def show_calculator(self):
        if not self.selected_material_id:
            QMessageBox.warning(self, "Ошибка", "Выберите материал")
            return
        CalculatorDialog(self.db, self.selected_material_id).exec()

    def closeEvent(self, event):
        self.db.close()
        event.accept()