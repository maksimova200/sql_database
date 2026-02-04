CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP SCHEMA IF EXISTS library CASCADE;
CREATE SCHEMA IF NOT EXISTS library;

CREATE TABLE library.book(
    book_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    publisher VARCHAR(255),
    publishing_year INTEGER,
    cipher VARCHAR(100) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true 
);

CREATE TABLE library.author(
    author_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    "name" VARCHAR(255) NOT NULL
);

CREATE TABLE library.book_author(
    book_id UUID REFERENCES library.book(book_id) NOT NULL,
    author_id UUID REFERENCES library.author(author_id) NOT NULL,
    PRIMARY KEY (book_id, author_id)
);

CREATE TABLE library.hall(
    "number" INTEGER PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    capacity INTEGER NOT NULL
);

CREATE TABLE library."catalog"(
    hall_number INTEGER REFERENCES library.hall("number") NOT NULL,
    book_id UUID REFERENCES library.book(book_id) NOT NULL,
    PRIMARY KEY (hall_number, book_id),
    amount INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE library.reader(
    reader_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    card_number VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    passport_number VARCHAR(6),
    birth_date DATE NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    phone VARCHAR(16),
    education TEXT,
    degree VARCHAR(255),
    hall_number INTEGER REFERENCES library.hall("number"),
    is_active BOOLEAN DEFAULT true
);

CREATE TABLE library.loan(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    book_id UUID REFERENCES library.book(book_id) NOT NULL,
    reader_id UUID REFERENCES library.reader(reader_id) NOT NULL,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    return_date DATE
);


-- INITIAL DATA 

INSERT INTO library.book(
    book_id, title, cipher)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'Евгений Онегин', '84(Р1) П91'),
    ('11111111-1111-1111-1111-111111111112', 'Руслан и Людмила', '84(Р1) П91'),
    ('11111111-1111-1111-1111-111111111113', 'Гарри Поттер и Орден Феникса', '84(А2) Р56'),
    ('11111111-1111-1111-1111-111111111114', 'Гарри Поттер и Тайная Комната', '84(А2) Р56'),
    ('11111111-1111-1111-1111-111111111115', 'Властелин Колец', '84(А2) Т59'),
    ('11111111-1111-1111-1111-111111111116', 'Хоббит', '84(А2) Т59'),
    ('11111111-1111-1111-1111-111111111117', 'Мёртвые души', '84(Р1) Г45'),
    ('11111111-1111-1111-1111-111111111118', 'Вечера на хуторе близ Диканьки', '84(Р1) Г45'),
    ('11111111-1111-1111-1111-111111111119', 'О всех созданиях - больших и малых', '84(А1) Х91'),
    ('11111111-1111-1111-1111-11111111111a', 'Кошачьи истории', '84(А1) Х91')
;

INSERT INTO library.author(
    author_id, "name")
VALUES
    ('22222222-2222-2222-2222-222222222222', 'А. С. Пушкин'),
    ('22222222-2222-2222-2222-222222222223', 'Дж. К. Роалинг'),
    ('22222222-2222-2222-2222-222222222224', 'Дж. Р. Р. Толкин'),
    ('22222222-2222-2222-2222-222222222225', 'Н. В. Гоголь'),
    ('22222222-2222-2222-2222-222222222226', 'Дж. Хэрриот')
;

INSERT INTO library.book_author(
    book_id, author_id)
VALUES
    ('11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222'),
    ('11111111-1111-1111-1111-111111111112', '22222222-2222-2222-2222-222222222222'),
    ('11111111-1111-1111-1111-111111111113', '22222222-2222-2222-2222-222222222223'),
    ('11111111-1111-1111-1111-111111111114', '22222222-2222-2222-2222-222222222223'),
    ('11111111-1111-1111-1111-111111111115', '22222222-2222-2222-2222-222222222224'),
    ('11111111-1111-1111-1111-111111111116', '22222222-2222-2222-2222-222222222224'),
    ('11111111-1111-1111-1111-111111111117', '22222222-2222-2222-2222-222222222225'),
    ('11111111-1111-1111-1111-111111111118', '22222222-2222-2222-2222-222222222225'),
    ('11111111-1111-1111-1111-111111111119', '22222222-2222-2222-2222-222222222226'),
    ('11111111-1111-1111-1111-11111111111a', '22222222-2222-2222-2222-222222222226')
;

INSERT INTO library.hall(
    "number", "name", capacity)
VALUES
    (1, 'Парадный', 12478),
    (6, 'Хеллоуинский', 4731),
    (10, 'Октябрьский', 47123),
    (7, 'Тронный', 11256),
    (4, 'Художественный', 7412)
;

INSERT INTO library."catalog"(
    hall_number, book_id, amount)
VALUES
    (1, '11111111-1111-1111-1111-111111111111', 40),
    (4, '11111111-1111-1111-1111-111111111111', 80),
    (6, '11111111-1111-1111-1111-111111111118', 66),
    (7, '11111111-1111-1111-1111-111111111115', 56),
    (1, '11111111-1111-1111-1111-111111111115', 45),
    (7, '11111111-1111-1111-1111-111111111112', 2),
    (1, '11111111-1111-1111-1111-111111111119', 5),
    (4, '11111111-1111-1111-1111-111111111119', 88),
    (7, '11111111-1111-1111-1111-111111111119', 1),
    (4, '11111111-1111-1111-1111-11111111111a', 1)
;

INSERT INTO library.reader(
    reader_id,
    card_number,
    surname,
    passport_number,
    birth_date,
    "address",
    phone,
    education,
    degree,
    hall_number
)
VALUES
    ('66666666-6666-6666-6666-666666666666', '145-956', 'Васильев', '789623', '1993-10-03', 'пр-кт Успенский, д. 12', '+78005553535', 'Магистратура МГУ', NULL, 1),
    ('66666666-6666-6666-6666-666666666667', '810-254', 'Романов', '896148', '1978-12-24', 'пр-кт Невский, д. 1', '+79995551212', 'Среднее неполное', NULL, 7),
    ('66666666-6666-6666-6666-666666666668', '240-562', 'Таргариен', '135634', '1999-01-23', 'о. Драконий Камень, д. 1', '+76665552233', 'Высшая драконная школа', NULL, 7),
    ('66666666-6666-6666-6666-666666666669', '865-652', 'Белогородцева', '247862', '1978-08-30', 'пер. Литейный д. 22', '+79643247878', 'Аспирантура МГУ', 'Кандидат филологических наук', 4),
    ('66666666-6666-6666-6666-66666666666a', '774-356', 'Сталин', '410369', '1910-01-17', 'ул. Авиаторов, д. 78', '+71234568899', 'Церковно-приходское среднее неполное', NULL, 10),
    ('66666666-6666-6666-6666-66666666666b', '146-498', 'Тано', '023066', '1999-02-05', 'ул. Звёздная, д. 66', '+79638795612', 'Бакалавриат Гарварда', NULL, 4)  
;

INSERT INTO library.loan(
    id, book_id, reader_id)
VALUES
    ('88888888-8888-8888-8888-888888888888', '11111111-1111-1111-1111-111111111112', '66666666-6666-6666-6666-666666666667'),
    ('88888888-8888-8888-8888-888888888881', '11111111-1111-1111-1111-111111111119', '66666666-6666-6666-6666-666666666668'),
    ('88888888-8888-8888-8888-888888888882', '11111111-1111-1111-1111-111111111111', '66666666-6666-6666-6666-666666666669'),
    ('88888888-8888-8888-8888-888888888883', '11111111-1111-1111-1111-11111111111a', '66666666-6666-6666-6666-666666666669'),
    ('88888888-8888-8888-8888-888888888884', '11111111-1111-1111-1111-111111111115', '66666666-6666-6666-6666-666666666666')
;


-- QUERIES

-- Какие книги закреплены за определенным читателем?
SELECT b.book_id, b.title, b.cipher 
FROM library.loan l
JOIN library.book b ON l.book_id = b.book_id
WHERE l.reader_id = '66666666-6666-6666-6666-666666666669'
    AND l.return_date IS NULL;

-- Как называется книга с заданным шифром?
SELECT title
FROM library.book
WHERE cipher = '84(А2) Т59';

-- Какой шифр у книги с заданным названием?
SELECT cipher 
FROM library.book
WHERE title = 'Хоббит';

-- Когда книга была закреплена за читателем?
SELECT loan_date
FROM library.loan
WHERE book_id = '11111111-1111-1111-1111-111111111115' 
    AND reader_id = '66666666-6666-6666-6666-666666666666';

-- Кто из читателей взял книгу более месяца тому назад?
SELECT DISTINCT r.reader_id, r.surname
FROM library.loan l
JOIN library.reader r ON l.reader_id = r.reader_id
WHERE l.loan_date <= CURRENT_DATE - INTERVAL '1 month'
    AND l.return_date IS NULL;

-- За кем из читателей закреплены книги, количество экземпляров которых в библиотеке не превышает 2?
WITH limited_books AS(
    SELECT book_id
    FROM library."catalog"
    GROUP BY book_id
    HAVING SUM(amount) <= 2
)
SELECT DISTINCT r.reader_id, r.surname, b.title
FROM library.loan l
JOIN limited_books lb ON l.book_id = lb.book_id
JOIN library.reader r ON l.reader_id = r.reader_id
JOIN library.book b ON l.book_id = b.book_id
WHERE l.return_date IS NULL;

-- Какое число читателей пользуется библиотекой?
SELECT COUNT(*) AS active_readers
FROM library.reader
WHERE is_active = TRUE;

-- Сколько в библиотеке читателей младше 20 лет?
SELECT COUNT(*) AS reader_under_20
FROM library.reader
WHERE birth_date > CURRENT_DATE - INTERVAL '20 years'
    AND is_active = TRUE;