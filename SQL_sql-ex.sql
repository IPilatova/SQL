Краткая информация о базе данных "Компьютерная фирма":
Схема БД состоит из четырех таблиц:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), скорость считывающего устройства - cd (например, '4x') и цена - price. Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой модели принтера указывается, является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.

=================================
Задание: 1 (Serge I: 2002-09-30)
Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

	SELECT model, speed, hd
	FROM pc
	WHERE price < 500

=================================
Задание: 2 (Serge I: 2002-09-21)
Найдите производителей принтеров. Вывести: maker

	SELECT DISTINCT maker
	FROM product
	WHERE type = 'printer'

=================================
Задание: 3 (Serge I: 2002-09-30)
Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

	SELECT model, ram, screen
	FROM laptop
	WHERE price > 1000

=================================
Задание: 4 (Serge I: 2002-09-21)
Найдите все записи таблицы Printer для цветных принтеров.

	SELECT *
	FROM printer
	WHERE color = 'y'

=================================
Задание: 5 (Serge I: 2002-09-30)
Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

	SELECT model, speed, hd
	FROM pc
	WHERE (cd = '12x' OR cd = '24x') AND price < 600

=================================
Задание: 6 (Serge I: 2002-10-28)
Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

	SELECT DISTINCT maker, laptop.speed
	FROM product JOIN laptop
	ON product.model = laptop.model
	WHERE laptop.hd >= 10

=================================
Задание: 7 (Serge I: 2002-11-02)
Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

	SELECT product.model AS model, price
	FROM pc JOIN product ON pc.model=product.model
	WHERE product.maker = 'B'
	UNION
	SELECT product.model AS model, price
	FROM laptop JOIN product ON laptop.model=product.model
	WHERE product.maker = 'B'
	UNION
	SELECT product.model AS model, price
	FROM printer JOIN product ON printer.model=product.model
	WHERE product.maker = 'B'

=================================
Задание: 8 (Serge I: 2003-02-03)
Найдите производителя, выпускающего ПК, но не ПК-блокноты.

	SELECT maker
	FROM product
	WHERE type = 'PC'
	EXCEPT
	SELECT maker
	FROM product
	WHERE type = 'Laptop'

=================================
Задание: 9 (Serge I: 2002-11-02)
Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

	SELECT DISTINCT product.maker AS Maker
	FROM product JOIN pc
	ON product.model = pc.model
	WHERE pc.speed >= 450

=================================
Задание: 10 (Serge I: 2002-09-23)
Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

	SELECT model, price
	FROM printer
	WHERE price = (
	SELECT MAX(price)
	FROM printer)

=================================
Задание: 11 (Serge I: 2002-11-02)
Найдите среднюю скорость ПК.

	SELECT(SELECT AVG(speed)
	FROM pc)
	AS Avg_speed

=================================
Задание: 12 (Serge I: 2002-11-02)
Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

	SELECT (SELECT AVG(speed)
	FROM Laptop
	WHERE price > 1000) 
	AS Avg_speed
=================================
Задание: 13 (Serge I: 2002-11-02)
Найдите среднюю скорость ПК, выпущенных производителем A.

	SELECT (SELECT AVG(pc.speed)
	FROM pc JOIN product
	ON pc.model = product.model
	WHERE product.maker = 'A')
	AS Avg_speed
=================================
Задание: 14 (Serge I: 2002-11-05)
Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

	SELECT Ships.class AS class, 
	Ships.name AS name, 
	Classes.country AS country
	FROM Ships JOIN Classes
	ON Ships.class = Classes.class
	WHERE numGuns >= 10
=================================
Задание: 15 (Serge I: 2003-02-03)
Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

	SELECT hd AS HD
	FROM pc
	GROUP BY hd
	HAVING COUNT(hd) >= 2

=================================
Задание: 16 (Serge I: 2003-02-03)
Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

	SELECT DISTINCT A.model AS model, B.model AS model, 
	A.speed AS speed, A.ram AS ram
	FROM pc AS A, pc AS B
	WHERE A.speed = B.speed AND A.ram = B.ram AND A.model > B.model
=================================
Задание: 17 (Serge I: 2003-02-03)
Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
Вывести: type, model, speed

	SELECT product.type AS type, lap.model AS model, lap.speed
	FROM (SELECT DISTINCT model, speed 
	FROM laptop
	WHERE speed < ALL (SELECT speed
	FROM pc)) AS lap, product
	WHERE lap.model = product.model
=================================

