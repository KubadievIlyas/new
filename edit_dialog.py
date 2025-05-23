from PyQt6.QtWidgets import (QDialog, QVBoxLayout, QFormLayout, QLineEdit,
                             QComboBox, QPushButton, QMessageBox, QDoubleSpinBox)
from PyQt6.QtCore import Qt
from PyQt6.QtGui import QIcon
from db import Database


class EditDialog(QDialog):
    def __init__(self, db, material_id=None):
        super().__init__()
        self.setWindowIcon(QIcon('logo/icon.ico'))
        self.db = db
        self.material_id = material_id
        self.setWindowTitle("Добавить материал" if material_id is None else "Редактировать материал")
        self.setModal(True)
        self.setMinimumWidth(400)
        self.init_ui()
        if material_id is not None:
            self.load_material_data()

    def init_ui(self):
        layout = QVBoxLayout(self)
        layout.setContentsMargins(15, 15, 15, 15)
        form_layout = QFormLayout()
        form_layout.setVerticalSpacing(10)

        self.name_edit = QLineEdit()
        self.name_edit.setPlaceholderText("Введите наименование материала")
        form_layout.addRow("Наименование:", self.name_edit)

        self.type_combo = QComboBox()
        for mt in self.db.get_material_types():
            self.type_combo.addItem(mt['type_name'], mt['material_type_id'])
        form_layout.addRow("Тип материала:", self.type_combo)

        self.unit_edit = QLineEdit("кг")
        form_layout.addRow("Единица измерения:", self.unit_edit)

        self.stock_spin = QDoubleSpinBox()
        self.stock_spin.setRange(0, 999999)
        self.stock_spin.setDecimals(3)
        form_layout.addRow("Количество на складе:", self.stock_spin)

        self.min_spin = QDoubleSpinBox()
        self.min_spin.setRange(0, 999999)
        self.min_spin.setDecimals(3)
        form_layout.addRow("Минимальное количество:", self.min_spin)

        self.price_spin = QDoubleSpinBox()
        self.price_spin.setRange(0, 999999)
        self.price_spin.setDecimals(2)
        self.price_spin.setPrefix("₽ ")
        form_layout.addRow("Цена за единицу:", self.price_spin)

        self.package_spin = QDoubleSpinBox()
        self.package_spin.setRange(0.001, 999999)
        self.package_spin.setDecimals(3)
        form_layout.addRow("Количество в упаковке:", self.package_spin)

        layout.addLayout(form_layout)

        self.save_button = QPushButton("Сохранить")
        self.save_button.setStyleSheet("""
            QPushButton {
                background-color: #0C4882;
                color: white;
                padding: 8px 16px;
                border-radius: 4px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #1A6BB2;
            }
        """)
        self.save_button.clicked.connect(self.save_material)
        layout.addWidget(self.save_button, alignment=Qt.AlignmentFlag.AlignRight)

    def load_material_data(self):
        material = next((m for m in self.db.get_materials() if m['material_id'] == self.material_id), None)
        if material:
            self.name_edit.setText(material['material_name'])
            index = self.type_combo.findData(material['material_type_id'])
            if index >= 0:
                self.type_combo.setCurrentIndex(index)
            self.unit_edit.setText(material['unit_of_measure'])
            self.stock_spin.setValue(float(material['quantity_in_stock']))
            self.min_spin.setValue(float(material['min_quantity']))
            self.price_spin.setValue(float(material['price_per_unit']))
            self.package_spin.setValue(float(material['package_quantity']))

    def save_material(self):
        name = self.name_edit.text().strip()
        if not name:
            QMessageBox.warning(self, "Ошибка", "Введите наименование материала")
            return

        data = (
            self.type_combo.currentData(),
            name,
            self.unit_edit.text(),
            float(self.stock_spin.value()),
            float(self.min_spin.value()),
            float(self.price_spin.value()),
            float(self.package_spin.value())
        )

        if self.material_id is None:
            self.db.add_material(data)
        else:
            self.db.update_material(self.material_id, data)
        self.accept()