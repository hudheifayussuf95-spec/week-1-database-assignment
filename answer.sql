-- Week 1 Assignment: Library Management Database
DROP DATABASE IF EXISTS library_db;
CREATE DATABASE library_db CHARACTER SET utf8mb4;
USE library_db;

CREATE TABLE authors (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  country VARCHAR(50)
);

CREATE TABLE books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  author_id INT,
  genre VARCHAR(50),
  year_published INT,
  copies_available INT DEFAULT 1,
  FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE TABLE members (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  join_date DATE
);

CREATE TABLE loans (
  loan_id INT AUTO_INCREMENT PRIMARY KEY,
  book_id INT NOT NULL,
  member_id INT NOT NULL,
  loan_date DATE NOT NULL,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (member_id) REFERENCES members(member_id)
);

SHOW TABLES;
DESCRIBE books;

INSERT INTO authors (name, country) VALUES
('Chinua Achebe', 'Nigeria'),
('Ngũgĩ wa Thiong''o', 'Kenya'),
('Chimamanda Ngozi Adichie', 'Nigeria'),
('Nuruddin Farah', 'Somalia');

INSERT INTO books (title, author_id, genre, year_published, copies_available) VALUES
('Things Fall Apart', 1, 'Fiction', 1958, 3),
('Arrow of God', 1, 'Fiction', 1964, 2),
('Petals of Blood', 2, 'Fiction', 1977, 2),
('Decolonising the Mind', 2, 'Non-fiction', 1986, 1),
('Half of a Yellow Sun', 3, 'Historical Fiction', 2006, 4),
('Maps', 4, 'Fiction', 1986, 2);

INSERT INTO members (full_name, email, join_date) VALUES
('Hudeyfa Yussuf', 'hudeyfa@example.com', '2026-01-10'),
('Amina Hassan', 'amina@example.com', '2026-02-15'),
('John Mwangi', 'john@example.com', '2026-03-20');

INSERT INTO loans (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2026-10-01', '2026-10-15'),
(3, 2, '2026-10-05', NULL),
(5, 3, '2026-10-10', NULL),
(2, 1, '2026-11-01', NULL);

SELECT * FROM books;

SELECT b.title, a.name AS author, b.year_published
FROM books b
JOIN authors a ON b.author_id = a.author_id
ORDER BY b.year_published;

SELECT m.full_name, b.title, l.loan_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.return_date IS NULL;

SELECT a.name, COUNT(b.book_id) AS total_books
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id
GROUP BY a.name;

SELECT title, year_published FROM books WHERE year_published > 1980;

UPDATE books SET copies_available = 5 WHERE title = 'Things Fall Apart';
UPDATE loans SET return_date = '2026-11-10' WHERE loan_id = 2;

DELETE FROM loans WHERE loan_id = 4;

SELECT * FROM loans;
SHOW TABLES;

