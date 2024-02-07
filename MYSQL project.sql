-- Create the library database
CREATE DATABASE  library;
USE library;

-- Create the Branch table
CREATE TABLE  Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no INT(15)
);
INSERT INTO BRANCH VALUES
(1,0021,'melatoor',9632587410),
(2,0022,'peruthalmanna',9362581470),
(3,0023,'edapetta',9876232540),
(4,0024,'aganadimukk',9514236871),
(5,0025,'edakkara',9784563251);
SELECT * FROM BRANCH;

-- Create the Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
desc employee;
INSERT INTO EMPLOYEE VALUES
(0030,'ASHLEY','MANAGER ',50000,2),
(0031,'RICHARD','OFFICER',38000,1),
(0032,'LAKSHMI','BUSSINESS ANALYST',28000,3),
(0033,'DIVYA','CHIEF MANAGER',68000,4),
(00344,'RAHUL','MANAGER ',48000,5);
SELECT * FROM EMPLOYEE;

-- Create the Customer table
CREATE TABLE  Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
INSERT INTO CUSTOMERS VALUES
(011,'ANATHU','PARIYARAM','2002-04-12'),
(012,'KANNAN','MARIYIL','2001-10-24'),
(013,'SIVAKUMAR','KOOLIYILL','2005-06-10'),
(014,'PRIMA','PALLATU','2006-03-05'),
(015,'DIJO','KUNNATHU','2007-05-12');
SELECT * FROM CUSTOMERS;
-- Create the Books table
CREATE TABLE  BOOKS (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(50),
    Publisher VARCHAR(50)
);
INSERT INTO BOOKS VALUES 
 (0041,'WISE AND OTHERWISE','AUTOBIOGRAPHY',200,'YES','SUDHAMOOTHRY','PENGUIN BOOKS'),
 (0042,'Adventures of Sherlock Holmes','STORY ',150,'YES','Arthur Conan Doyle','CANVA PUBLISHERS '),
 (0043,'The Moon and Sixpence','NOVEL',550,'NO','Somerset Maughan','MORGAN BOOKS'),
 (0044,'HARRY POTTER','SERIES',600,'YES','J K ROWLING','Bloomsbury'),
 (0045,'Geetanjali','POETRY',700,'YES','Rabindra Nath Tagore','MAHIMA PRINTERS');
 SELECT * FROM BOOKS;

-- Create the IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
INSERT INTO  ISSUESTATUS VALUES
(0051,011,'WISE AND OTHERWISE','2002-04-12',1974),
(0052,012,'Adventures of Sherlock Holmes','2001-10-24',9147), 
(0053,013,'The Moon and Sixpence','2005-06-10',6057),
(0054,014,'HARRY POTTER','2006-03-05',7092),
(0055,015,'Geetanjali','2007-05-12',1108);
SELECT * FROM ISSUESTATUS;

-- Create the ReturnStatus table
CREATE TABLE  ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus VALUES
(3001,'ANATHU','The Moon and Sixpence','2005-11-20',7057),
(3002,'KANNAN','WISE AND OTHERWISE','2002-05-22',1074),
(3003,'SIVAKUMAR','Adventures of Sherlock Holmes','2001-12-30',1147),
(3004,'PRIMA','Geetanjali','2007-08-30',9008),
(3005,'DIJO','HARRY POTTER','2006-06-15',9092);
SELECT * FROM ReturnStatus;


-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS BookCount
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT e.Branch_no, COUNT(*) AS EmployeeCount
FROM Employee e
GROUP BY e.Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;

-- 9. Retrieve book_title from book table containing history.
SELECT Book_title
FROM Books
WHERE Category = 'History';

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT e.Branch_no, COUNT(*) AS EmployeeCount
FROM Employee e
GROUP BY e.Branch_no
HAVING EmployeeCount > 5;
