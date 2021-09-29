+---------+-----------------------+------------------+--------+--------+
| book_id | title                 | author           | price  | amount |
+---------+-----------------------+------------------+--------+--------+
| 1       | Мастер и Маргарита    | Булгаков М.А.    | 670.99 | 3      |
| 2       | Белая гвардия         | Булгаков М.А.    | 540.50 | 5      |
| 3       | Идиот                 | Достоевский Ф.М. | 460.00 | 10     |
| 4       | Братья Карамазовы     | Достоевский Ф.М. | 799.01 | 2      |
| 5       | Стихотворения и поэмы | Есенин С.А.      | 650.00 | 15     |
+---------+-----------------------+------------------+--------+--------+

Сформулируйте SQL запрос для создания таблицы book
	CREATE TABLE book(
	   book_id INT PRIMARY KEY AUTO_INCREMENT,
	   title VARCHAR(50),
	   author VARCHAR(30),
	   price DECIMAL(8, 2),
	   amount INT
	);
_______________________________________________
Занесите новую строку в таблицу book
	INSERT INTO book(title, author, price, amount)
	VALUES ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3);
	SELECT * FROM book;
_______________________________________________
Занесите три записи в таблицу book, первая запись уже добавлена
	INSERT INTO book(title, author, price, amount)
	VALUE ('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
		('Идиот', 'Достоевский Ф.М.', 460.00, 10),
		('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2)
	SELECT * FROM book;
_______________________________________________
Вывести информацию о всех книгах, хранящихся на складе.
	SELECT *
	FROM book;
_______________________________________________
Выбрать авторов, название книг и их цену из таблицы book.
	SELECT author, title, price
	FROM book;
_______________________________________________
Выбрать названия книг и авторов из таблицы book, для поля title задать имя(псевдоним) Название, для поля author –  Автор.
	SELECT title AS Название, author AS Автор
	FROM book;
_______________________________________________
Для упаковки каждой книги требуется 1 лист бумаги, цена которого 1 рубль 65 копеек. Сколько денег потребуется, чтобы упаковать все экземпляры книги?. В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack.
	SELECT title, amount, amount * 1.65 AS pack
	FROM book;
_______________________________________________
В конце года цену всех книг на складе пересчитывают – снижают ее на 30%. Написать SQL запрос, который из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг. Столбец с новой ценой назвать new_price, цену округлить до 2-х знаков после запятой.
	SELECT title, author, amount, ROUND(price*(1-30/100), 2) AS new_price
	FROM book;
_______________________________________________
При анализе продаж книг выяснилось, что наибольшей популярностью пользуются книги Михаила Булгакова, на втором месте книги Сергея Есенина. Исходя из этого решили поднять цену книг Булгакова на 10%, а цену книг Есенина - на 5%. Написать запрос, куда включить автора, название книги и новую цену, последний столбец назвать new_price. Значение округлить до двух знаков после запятой.
	SELECT author, title, 
		ROUND(IF(author='Булгаков М.А.', price*(1+10/100), IF(author='Есенин С.А.', price*(1+5/100), price)),2) AS           new_price
	FROM book;
_______________________________________________
Вывести автора, название  и цены тех книг, количество которых меньше 10.
	SELECT author, title, price
	FROM book
	WHERE amount < 10;
_______________________________________________
Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600, а стоимость всех экземпляров этих книг больше или равна 5000.
	SELECT title, author, price, amount
	FROM book
	WHERE (price < 500 OR price > 600) AND price * amount >= 5000;
_______________________________________________
Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),  а количество или 2, или 3, или 5, или 7 .
	SELECT title, author
	FROM book
	WHERE (price BETWEEN 540.50 AND 800) AND (amount IN (2, 3, 5, 7));
_______________________________________________
Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 (включая границы). Информацию  отсортировать сначала по авторам (в обратном алфавитном порядке), а затем по названиям книг (по алфавиту).
	SELECT author, title
	FROM book
	WHERE amount BETWEEN 2 AND 14
	ORDER BY author DESC, title;
_______________________________________________
Вывести название и автора тех книг, название которых состоит из двух и более слов, а инициалы автора содержат букву «С». Считать, что в названии слова отделяются друг от друга пробелами и не содержат знаков препинания, между фамилией автора и инициалами обязателен пробел, инициалы записываются без пробела в формате: буква, точка, буква, точка. Информацию отсортировать по названию книги в алфавитном порядке.
	SELECT title, author
	FROM book
	WHERE title LIKE "_% _%"
		AND author LIKE "%_ %С.%"
	ORDER BY title;
_______________________________________________
Отобрать различные (уникальные) элементы столбца amount таблицы book.
	SELECT DISTINCT amount
	FROM book;
_______________________________________________
Посчитать, количество различных книг и количество экземпляров книг каждого автора , хранящихся на складе.  Столбцы назвать Автор, Различных_книг и Количество_экземпляров соответственно.
	SELECT author AS Автор, COUNT(*) AS Различных_книг, SUM(amount) AS Количество_экземпляров
	FROM book
	GROUP BY author;
_______________________________________________
Вывести фамилию автора, минимальную, максимальную и среднюю цену книг каждого автора . Вычисляемые столбцы назвать Минимальная_цена, Максимальная_цена и Средняя_цена соответственно.
	SELECT author, 
		MIN(price) AS 'Минимальная_цена', 
		MAX(price) AS 'Максимальная_цена', 
		AVG(price) AS 'Средняя_цена'
	FROM book
	GROUP BY author;
_______________________________________________
Для каждого автора вычислить суммарную стоимость книг S (имя столбца Стоимость), а также вычислить налог на добавленную стоимость  для полученных сумм (имя столбца НДС ) , который включен в стоимость и составляет k = 18%,  а также стоимость книг  (Стоимость_без_НДС) без него. Значения округлить до двух знаков после запятой.
	SELECT author, SUM(price * amount) AS Стоимость, 
		SUM(ROUND((price * amount * 18 / 100) / (1 + 18 / 100), 2)) AS НДС,
		SUM(price * amount - ROUND((price * amount * 18 / 100) / (1 + 18 / 100), 2)) AS Стоимость_без_НДС
	FROM book
	GROUP BY author;
_______________________________________________
Вывести  цену самой дешевой книги, цену самой дорогой и среднюю цену книг на складе. Названия столбцов Минимальная_цена, Максимальная_цена, Средняя_цена соответственно. Среднюю цену округлить до двух знаков после запятой.
	SELECT MIN(price) AS Минимальная_цена,
		MAX(price) AS Максимальная_цена,
		ROUND(AVG(price), 2) AS Средняя_цена
	FROM book;
_______________________________________________
Вычислить среднюю цену и суммарную стоимость тех книг, количество экземпляров которых принадлежит интервалу от 5 до 14, включительно. Столбцы назвать Средняя_цена и Стоимость, значения округлить до 2-х знаков после запятой.
	SELECT ROUND(AVG(price), 2) AS Средняя_цена, 
		ROUND(SUM(price * amount), 2) AS Стоимость
	FROM book
	WHERE amount BETWEEN 5 AND 14;
_______________________________________________
Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия». В результат включить только тех авторов, у которых суммарная стоимость книг более 5000 руб. Вычисляемый столбец назвать Стоимость. Результат отсортировать по убыванию стоимости.
	SELECT author, SUM(price * amount) AS Стоимость
	FROM book
	WHERE title NOT IN ('Идиот','Белая гвардия')
	GROUP BY author
	HAVING SUM(price * amount) > 5000
	ORDER BY Стоимость DESC;
_______________________________________________
Вывести информацию (автора, название и цену) о  книгах, цены которых меньше или равны средней цене книг на складе. Информацию вывести в отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги.
	SELECT author, title, price
	FROM book
	WHERE price <= (
		SELECT AVG(price)
		FROM book
		)
	ORDER BY price DESC;
_______________________________________________
Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде.
	SELECT author, title, price
	FROM book
	WHERE price - (
		SELECT MIN(price)
		FROM book
		) <= 150
	ORDER BY price;
_______________________________________________
Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется.
	SELECT author, title, amount
	FROM book
	WHERE amount IN (
		SELECT amount
		FROM book
		GROUP BY amount
		HAVING COUNT(title) = 1
		);
_______________________________________________
Вывести информацию о книгах(автор, название, цена), цена которых меньше самой большой из минимальных цен, вычисленных для каждого автора.
	SELECT author, title, price
	FROM book
	WHERE price < ANY (
		SELECT MIN(price)
		FROM book
		GROUP BY author
		);
_______________________________________________
Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало одинаковое количество экземпляров каждой книги, равное значению самого большего количества экземпляров одной книги на складе. Вывести название книги, ее автора, текущее количество экземпляров на складе и количество заказываемых экземпляров книг. Последнему столбцу присвоить имя Заказ.
	SELECT title, author, amount, 
		(SELECT MAX(amount) FROM book) - amount AS Заказ
	FROM book
	WHERE amount <> (SELECT MAX(amount) FROM book);
_______________________________________________
Вывести информацию по самой дорогой книге из тех, у которых минимальный запас на складе. Дополнительным столбцом вывести долю количества этой книги в общем остатке всех книг на складе.
	SELECT author, title, price, amount, ROUND(amount / 
		(
		SELECT SUM(amount)
		FROM book
		),
	2) AS Доля_книг                                      
	FROM book
	WHERE amount = 
		(
		SELECT MIN(amount)
		FROM book
		)
		AND
		price = 
		(
		SELECT MAX(price)
		FROM book
		WHERE amount = 
			(
			SELECT MIN(amount)
			FROM book
			) 
		)
_______________________________________________
Создать таблицу поставка (supply), которая имеет ту же структуру, что и таблица book.
	CREATE TABLE supply(
	   supply_id INT PRIMARY KEY AUTO_INCREMENT,
	   title VARCHAR(50),
	   author VARCHAR(30),
	   price DECIMAL(8, 2),
	   amount INT
	)
_______________________________________________
Занесите в таблицу supply четыре записи, чтобы получилась следующая таблица:

supply_id	title	author	price	amount
1	Лирика	Пастернак Б.Л.	518.99	2
2	Черный человек 	Есенин С.А.	570.20	6
3	Белая гвардия	Булгаков М.А.	540.50	7
4	Идиот	Достоевский Ф.М.	360.80	3
	INSERT INTO supply (title, author, price, amount)
	VALUES 
		('Лирика', 'Пастернак Б.Л.', 518.99, 2),
		('Черный человек', 'Есенин С.А.', 570.20, 6),
		('Белая гвардия', 'Булгаков М.А.', 540.50, 7),
		('Идиот', 'Достоевский Ф.М.', 360.80, 3);
_______________________________________________
Добавить из таблицы supply в таблицу book, все книги, кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.
	INSERT INTO book (title, author, price, amount)
	SELECT title, author, price, amount
	FROM supply
	WHERE author NOT LIKE 'Булгаков%'
		AND author NOT LIKE 'Достоев%'
_______________________________________________
Занести из таблицы supply в таблицу book только те книги, авторов которых нет в  book.
	INSERT INTO book (title, author, price, amount)
	SELECT title, author, price, amount
	FROM supply
	WHERE author NOT IN
		(SELECT author
		 FROM book)
_______________________________________________
Уменьшить на 10% цену тех книг в таблице book, количество которых принадлежит интервалу от 5 до 10, включая границы.
	UPDATE book
	SET price = (1 - 10/100) * price
	WHERE amount BETWEEN 5 AND 10;
_______________________________________________
В таблице book необходимо скорректировать значение для покупателя в столбце buy таким образом, чтобы оно не превышало допустимый остаток в столбце amount. А цену тех книг, которые покупатель не заказывал, снизить на 10%.
	UPDATE book
	SET buy = IF (buy > amount, amount, buy),
		price = IF (buy = 0, (1 - 10/100) * price, price);
_______________________________________________
Для тех книг в таблице book , которые есть в таблице supply, не только увеличить их количество в таблице book ( увеличить их количество на значение столбца amountтаблицы supply), но и пересчитать их цену (для каждой книги найти сумму цен из таблиц book и supply и разделить на 2).
	UPDATE book, supply
	SET book.amount = book.amount + supply.amount,
		book.price = (book.price + supply.price)/2
	WHERE book.title = supply.title;
_______________________________________________
Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10.
	DELETE FROM supply
	WHERE author IN 
		(
		SELECT author 
		FROM book
		GROUP BY author
		HAVING SUM(amount) > 10
		);

	SELECT * FROM supply;
_______________________________________________


_______________________________________________

_______________________________________________

_______________________________________________

_______________________________________________

_______________________________________________

_______________________________________________	 