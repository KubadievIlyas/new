
--
-- База данных: `new_technology`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Materials`
--

CREATE TABLE `Materials` (
  `material_id` int(11) NOT NULL,
  `material_type_id` int(11) NOT NULL,
  `material_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_of_measure` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'кг',
  `quantity_in_stock` decimal(15,3) NOT NULL DEFAULT '0.000',
  `min_quantity` decimal(15,3) NOT NULL DEFAULT '0.000',
  `price_per_unit` decimal(15,2) NOT NULL,
  `package_quantity` decimal(15,3) NOT NULL DEFAULT '1.000'
);

--
-- Дамп данных таблицы `Materials`
--

INSERT INTO `Materials` (`material_id`, `material_type_id`, `material_name`, `unit_of_measure`, `quantity_in_stock`, `min_quantity`, `price_per_unit`, `package_quantity`) VALUES
(12, 2, 'Песок', 'кг', '50.000', '150.000', '60.00', '40.000');

-- --------------------------------------------------------

--
-- Структура таблицы `MaterialSuppliers`
--

CREATE TABLE `MaterialSuppliers` (
  `material_id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `start_date` date NOT NULL
) ;

--
-- Дамп данных таблицы `MaterialSuppliers`
--

INSERT INTO `MaterialSuppliers` (`material_id`, `partner_id`, `start_date`) VALUES
(12, 8, '2025-05-24'),
(12, 9, '2025-05-24');

-- --------------------------------------------------------

--
-- Структура таблицы `MaterialTypes`
--

CREATE TABLE `MaterialTypes` (
  `material_type_id` int(11) NOT NULL,
  `type_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `defect_percentage` decimal(10,4) NOT NULL
) ;

--
-- Дамп данных таблицы `MaterialTypes`
--

INSERT INTO `MaterialTypes` (`material_type_id`, `type_name`, `defect_percentage`) VALUES
(1, 'Тип материала 1', '0.0020'),
(2, 'Тип материала 2', '0.0050'),
(3, 'Тип материала 3', '0.0030'),
(4, 'Тип материала 4', '0.0015'),
(5, 'Тип материала 5', '0.0018');

-- --------------------------------------------------------

--
-- Структура таблицы `PartnerRequests`
--

CREATE TABLE `PartnerRequests` (
  `request_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ;

--
-- Дамп данных таблицы `PartnerRequests`
--

INSERT INTO `PartnerRequests` (`request_id`, `product_id`, `partner_id`, `quantity`) VALUES
(1, 4, 1, 2000),
(2, 5, 2, 3000),
(3, 1, 3, 1000),
(4, 3, 4, 9500),
(5, 1, 5, 2000),
(6, 18, 6, 1100),
(7, 12, 7, 5000),
(8, 1, 8, 2500),
(9, 2, 9, 6000),
(10, 6, 10, 7000),
(11, 4, 11, 5000),
(12, 4, 12, 7500),
(13, 1, 13, 3000),
(14, 18, 14, 500),
(15, 16, 15, 7000),
(16, 9, 16, 4000),
(17, 1, 17, 3500),
(18, 1, 18, 7900),
(19, 15, 19, 9600),
(20, 15, 20, 1200),
(21, 11, 1, 1500),
(22, 8, 2, 3000),
(23, 2, 3, 3010),
(24, 7, 4, 3020),
(25, 5, 5, 3050),
(26, 14, 6, 3040),
(27, 19, 7, 3050),
(28, 4, 8, 3060),
(29, 18, 9, 3070),
(30, 9, 10, 5400),
(31, 12, 11, 5500),
(32, 11, 12, 5600),
(33, 9, 13, 5700),
(34, 14, 14, 5800),
(35, 2, 15, 5900),
(36, 12, 16, 6000),
(37, 6, 17, 6100),
(38, 9, 18, 8000),
(39, 3, 19, 7060),
(40, 17, 20, 6120),
(41, 15, 1, 5180),
(42, 10, 2, 4240),
(43, 10, 3, 3300),
(44, 10, 4, 2360),
(45, 8, 5, 1420),
(46, 11, 6, 1500),
(47, 5, 7, 1700),
(48, 12, 8, 1900),
(49, 15, 9, 2100),
(50, 12, 10, 2300),
(51, 8, 11, 2500),
(52, 15, 12, 2700),
(53, 12, 13, 2900),
(54, 1, 14, 3100),
(55, 18, 15, 3300),
(56, 20, 16, 3500),
(57, 10, 17, 3750),
(58, 14, 18, 6700),
(59, 7, 19, 6950),
(60, 11, 20, 7200),
(61, 17, 1, 7450),
(62, 19, 2, 7700),
(63, 20, 3, 7950),
(64, 8, 4, 8200),
(65, 10, 5, 8450),
(66, 7, 6, 8700),
(67, 8, 7, 8950),
(68, 20, 8, 9200),
(69, 4, 9, 1300),
(70, 16, 10, 1500),
(71, 16, 11, 1700),
(72, 12, 12, 1900),
(73, 20, 13, 2100),
(74, 9, 14, 2300),
(75, 13, 15, 2500),
(76, 13, 16, 2700),
(77, 12, 17, 2900),
(78, 3, 18, 3100),
(79, 14, 19, 3300),
(80, 18, 20, 3500);

-- --------------------------------------------------------

--
-- Структура таблицы `Partners`
--

CREATE TABLE `Partners` (
  `partner_id` int(11) NOT NULL,
  `partner_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `partner_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `director_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `legal_address` text COLLATE utf8mb4_unicode_ci,
  `inn` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int(11) NOT NULL
) ;

--
-- Дамп данных таблицы `Partners`
--

INSERT INTO `Partners` (`partner_id`, `partner_type`, `partner_name`, `director_name`, `email`, `phone`, `legal_address`, `inn`, `rating`) VALUES
(1, 'ЗАО', 'Стройдвор', 'Андреева Ангелина Николаевна', 'angelina77@kart.ru', '492 452 22 82', '143001, Московская область, город Одинцово, уд. Ленина, 21', '9432455179', 5),
(2, 'ЗАО', 'Самоделка', 'Мельников Максим Петрович', 'melnikov.maksim88@hm.ru', '812 267 19 59', '306230, Курская область, город Обоянь, ул. 1 Мая, 89', '7803888520', 3),
(3, 'ООО', 'Деревянные изделия', 'Лазарев Алексей Сергеевич', 'aleksejlazarev@al.ru', '922 467 93 83', '238340, Калининградская область, город Светлый, ул. Морская, 12', '8430391035', 4),
(4, 'ООО', 'Декор и отделка', 'Саншокова Мадина Муратовна', 'mmsanshokova@lss.ru', '413 230 30 79', '685000, Магаданская область, город Магадан, ул. Горького, 15', '4318170454', 7),
(5, 'ООО', 'Паркет', 'Иванов Дмитрий Сергеевич', 'ivanov.dmitrij@mail.ru', '921 851 21 22', '606440, Нижегородская область, город Бор, ул. Свободы, 3', '7687851800', 7),
(6, 'ПАО', 'Дом и сад', 'Аникеева Екатерина Алексеевна', 'ekaterina.anikeeva@ml.ru', '499 936 29 26', '393760, Тамбовская область, город Мичуринск, ул. Красная, 50', '6119144874', 7),
(7, 'ОАО', 'Легкий шаг', 'Богданова Ксения Владимировна', 'bogdanova.kseniya@bkv.ru', '495 445 61 41', '307370, Курская область, город Рыльск, ул. Гагарина, 16', '1122170258', 6),
(8, 'ПАО', 'СтройМатериалы', 'Холодова Валерия Борисовна', 'holodova@education.ru', '499 234 56 78', '140300, Московская область, город Егорьевск, ул. Советская, 24', '8355114917', 5),
(9, 'ОАО', 'Мир отделки', 'Крылов Савелий Тимофеевич', 'stkrylov@mail.ru', '908 713 51 88', '344116, Ростовская область, город Ростов-на-Дону, ул. Артиллерийская, 4', '3532367439', 8),
(10, 'ОАО', 'Технологии комфорта', 'Белов Кирилл Александрович', 'kirill_belov@kir.ru', '918 432 12 34', '164500, Архангельская область, город Северодвинск, ул. Ломоносова, 29', '2362431140', 4),
(11, 'ПАО', 'Твой дом', 'Демидов Дмитрий Александрович', 'dademidov@ml.ru', '919 698 75 43', '354000, Краснодарский край, город Сочи, ул. Больничная, 11', '4159215346', 10),
(12, 'ЗАО', 'Новые краски', 'Алиев Дамир Игоревич', 'alievdamir@tk.ru', '812 823 93 42', '187556, Ленинградская область, город Тихвин, ул. Гоголя, 18', '9032455179', 9),
(13, 'ОАО', 'Политехник', 'Котов Михаил Михайлович', 'mmkotov56@educat.ru', '495 895 71 77', '143960, Московская область, город Реутов, ул. Новая, 55', '3776671267', 5),
(14, 'ОАО', 'СтройАрсенал', 'Семенов Дмитрий Максимович', 'semenov.dm@mail.ru', '896 123 45 56', '242611, Брянская область, город Фокино, ул. Фокино, 23', '7447864518', 5),
(15, 'ПАО', 'Декор и порядок', 'Болотов Артем Игоревич', 'artembolotov@ab.ru', '950 234 12 12', '309500, Белгородская область, город Старый Оскол, ул. Цветочная, 20', '9037040523', 5),
(16, 'ПАО', 'Умные решения', 'Воронова Анастасия Валерьевна', 'voronova_anastasiya@mail.ru', '923 233 27 69', '652050, Кемеровская область, город Юрга, ул. Мира, 42', '6221520857', 3),
(17, 'ЗАО', 'Натуральные покрытия', 'Горбунов Василий Петрович', 'vpgorbunov24@vvs.ru', '902 688 28 96', '188300, Ленинградская область, город Гатчина, пр. 25 Октября, 17', '2262431140', 9),
(18, 'ООО', 'СтройМастер', 'Смирнов Иван Андреевич', 'smirnov_ivan@kv.ru', '917 234 75 55', '184250, Мурманская область, город Кировск, пр. Ленина, 24', '4155215346', 9),
(19, 'ООО', 'Гранит', 'Джумаев Ахмед Умарович', 'dzhumaev.ahmed@amail.ru', '495 452 55 95', '162390, Вологодская область, город Великий Устюг, ул. Железнодорожная, 36', '3961234561', 5),
(20, 'ЗАО', 'Строитель', 'Петров Николай Тимофеевич', 'petrov.nikolaj31@mail.ru', '916 596 15 55', '188910, Ленинградская область, город Приморск, ш. Приморское, 18', '9600275878', 10);

-- --------------------------------------------------------

--
-- Структура таблицы `Products`
--

CREATE TABLE `Products` (
  `product_id` int(11) NOT NULL,
  `product_type_id` int(11) NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `article_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_partner_price` decimal(15,2) NOT NULL
) ;

--
-- Дамп данных таблицы `Products`
--

INSERT INTO `Products` (`product_id`, `product_type_id`, `product_name`, `article_number`, `min_partner_price`) VALUES
(1, 1, 'Фанера ФСФ 1800х1200х27 мм бежевая береза', '6549922', '5100.00'),
(2, 2, 'Мягкие панели прямоугольник велюр цвет оливковый 600х300х35 мм', '7018556', '1880.00'),
(3, 4, 'Бетонная плитка Белый кирпич микс 30х7,3 см', '5028272', '2080.00'),
(4, 3, 'Плитка Мозаика 10x10 см цвет белый глянец', '8028248', '2500.00'),
(5, 5, 'Ламинат Дуб Античный серый 32 класс толщина 8 мм с фаской', '9250282', '4050.00'),
(6, 2, 'Стеновая панель МДФ Флора 1440x500x10 мм', '7130981', '2100.56'),
(7, 4, 'Бетонная плитка Красный кирпич 20x6,5 см', '5029784', '2760.00'),
(8, 5, 'Ламинат Канди Дизайн 33 класс толщина 8 мм с фаской', '9658953', '3200.96'),
(9, 1, 'Плита ДСП 11 мм влагостойкая 594x1815 мм', '6026662', '497.69'),
(10, 5, 'Ламинат с натуральным шпоном Дуб Эксперт толщина 6 мм с фаской', '9159043', '3750.00'),
(11, 3, 'Плитка настенная Формат 20x40 см матовая цвет мята', '8588376', '2500.00'),
(12, 1, 'Плита ДСП Кантри 16 мм 900x1200 мм', '6758375', '1050.96'),
(13, 2, 'Стеновая панель МДФ Сосна Полярная 60х280х4мсм цвет коричневый', '7759324', '1700.00'),
(14, 4, 'Клинкерная плитка коричневая 29,8х29,8 см', '5118827', '860.00'),
(15, 3, 'Плитка настенная Цветок 60x120 см цвет зелено-голубой', '8559898', '2300.00'),
(16, 2, 'Пробковое настенное покрытие 600х300х3 мм белый', '7259474', '3300.00'),
(17, 3, 'Плитка настенная Нева 30x60 см цвет серый', '8115947', '1700.00'),
(18, 4, 'Гипсовая плитка настенная Дом на берегу кирпич белый 18,5х4,5 см', '5033136', '499.00'),
(19, 5, 'Ламинат Дуб Северный белый 32 класс толщина 8 мм с фаской', '9028048', '2550.00'),
(20, 1, 'Дерево волокнистая плита Дуб Винтаж 1200х620х3 мм светло-коричневый', '6123459', '900.50');

-- --------------------------------------------------------

--
-- Структура таблицы `ProductTypes`
--

CREATE TABLE `ProductTypes` (
  `product_type_id` int(11) NOT NULL,
  `type_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_coefficient` decimal(10,2) NOT NULL
) ;

--
-- Дамп данных таблицы `ProductTypes`
--

INSERT INTO `ProductTypes` (`product_type_id`, `type_name`, `type_coefficient`) VALUES
(1, 'Древесно-плитные материалы', '1.50'),
(2, 'Декоративные панели', '3.50'),
(3, 'Плитка', '5.25'),
(4, 'Фасадные материалы', '4.50'),
(5, 'Напольные покрытия', '2.17');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Materials`
--
ALTER TABLE `Materials`
  ADD PRIMARY KEY (`material_id`),
  ADD KEY `material_type_id` (`material_type_id`);

--
-- Индексы таблицы `MaterialSuppliers`
--
ALTER TABLE `MaterialSuppliers`
  ADD PRIMARY KEY (`material_id`,`partner_id`),
  ADD KEY `partner_id` (`partner_id`);

--
-- Индексы таблицы `MaterialTypes`
--
ALTER TABLE `MaterialTypes`
  ADD PRIMARY KEY (`material_type_id`),
  ADD UNIQUE KEY `type_name` (`type_name`);

--
-- Индексы таблицы `PartnerRequests`
--
ALTER TABLE `PartnerRequests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `idx_requests_product` (`product_id`),
  ADD KEY `idx_requests_partner` (`partner_id`);

--
-- Индексы таблицы `Partners`
--
ALTER TABLE `Partners`
  ADD PRIMARY KEY (`partner_id`),
  ADD UNIQUE KEY `partner_name` (`partner_name`),
  ADD UNIQUE KEY `inn` (`inn`),
  ADD KEY `idx_partners_name` (`partner_name`),
  ADD KEY `idx_partners_inn` (`inn`);

--
-- Индексы таблицы `Products`
--
ALTER TABLE `Products`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `article_number` (`article_number`),
  ADD KEY `product_type_id` (`product_type_id`),
  ADD KEY `idx_products_name` (`product_name`),
  ADD KEY `idx_products_article` (`article_number`);

--
-- Индексы таблицы `ProductTypes`
--
ALTER TABLE `ProductTypes`
  ADD PRIMARY KEY (`product_type_id`),
  ADD UNIQUE KEY `type_name` (`type_name`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Materials`
--
ALTER TABLE `Materials`
  MODIFY `material_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `MaterialTypes`
--
ALTER TABLE `MaterialTypes`
  MODIFY `material_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `PartnerRequests`
--
ALTER TABLE `PartnerRequests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT для таблицы `Partners`
--
ALTER TABLE `Partners`
  MODIFY `partner_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `Products`
--
ALTER TABLE `Products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `ProductTypes`
--
ALTER TABLE `ProductTypes`
  MODIFY `product_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Materials`
--
ALTER TABLE `Materials`
  ADD CONSTRAINT `materials_ibfk_1` FOREIGN KEY (`material_type_id`) REFERENCES `MaterialTypes` (`material_type_id`);

--
-- Ограничения внешнего ключа таблицы `MaterialSuppliers`
--
ALTER TABLE `MaterialSuppliers`
  ADD CONSTRAINT `materialsuppliers_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `Materials` (`material_id`),
  ADD CONSTRAINT `materialsuppliers_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `Partners` (`partner_id`);

--
-- Ограничения внешнего ключа таблицы `PartnerRequests`
--
ALTER TABLE `PartnerRequests`
  ADD CONSTRAINT `partnerrequests_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Products` (`product_id`),
  ADD CONSTRAINT `partnerrequests_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `Partners` (`partner_id`);

--
-- Ограничения внешнего ключа таблицы `Products`
--
ALTER TABLE `Products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`product_type_id`) REFERENCES `ProductTypes` (`product_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
