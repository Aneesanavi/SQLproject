CREATE DATABASE LIBRARY;

USE LIBRARY;

CREATE TABLE BRANCH (
Branch_no  INT NOT NULL PRIMARY KEY ,
Manager_Id  INT ,
Branch_address VARCHAR(30) ,
Contact_no INT);

INSERT INTO BRANCH ( Branch_no,Manager_Id,Branch_address,Contact_no) VALUES 
(1, 101, '101 STREET',10101),
(2, 102, '102 STREET',10202),
(3, 103, '103 STREET',10303),
(4, 104, '104 STREET',10404),
(5, 105, '105 STREET',10505),
(6, 106, '106 STREET',10606),
(7, 107, '107 STREET',10707),
(8, 108, '108 STREET',10808),
(9, 109, '109 STREET',10909),
(10,110, '110 STREET',10509);

SELECT* FROM BRANCH;



CREATE TABLE EMPLOYEE(
Emp_Id INT NOT NULL PRIMARY KEY ,
Emp_name VARCHAR (30),
Position VARCHAR(30),
Salary DECIMAL(10,2) );

INSERT INTO EMPLOYEE (Emp_Id ,Emp_name ,Position ,Salary ) VALUES
(101,'ADAM', 'MANAGER', 500000),
(102,'ARAM', 'CLERK', 400000),
(103,'AWAM', 'SUPERVISOR', 30000),
(104,'AJAM', 'MANAGER', 20000),
(105,'ANAM', 'ACCOUNTANT', 100000),
(106,'ALAM', 'DIRECTOR', 300000),
(107,'AVAM', 'MANAGER', 650000),
(108,'ASAM', 'CLERK', 40000),
(109,'ABAM', 'MANAGER', 34000),
(110,'AQAM', 'ENGINEER', 100000),
(111,'AFAM', 'MANAGER', 100000),
(112,'AOKM', 'MANAGER', 500000);


CREATE TABLE CUSTOMER (
Customer_Id INT NOT NULL PRIMARY KEY ,
Customer_name VARCHAR (30),
Customer_address VARCHAR(30),
Reg_date DATE);

INSERT INTO CUSTOMER (Customer_Id  ,Customer_name ,Customer_address,Reg_date)VALUES
(111,'Olivia Davis','AA BB ST','2021-05-10'),
(222,'Liam Anderson','CC BB ST','2022-05-10'),
(333,'Sophia Garcia','DD BB ST','2021-07-10'),
(444,'Noah Martinez','EE BB ST','2021-08-10'),
(555,'Ava Johnson','FF BB ST','2022-05-10'),
(666,'William Thompson','GG BB ST','2021-02-10');

select * from customer;



CREATE TABLE IssueStatus (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(100),
  Issue_date DATE,
  Isbn_book VARCHAR(100),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);


INSERT INTO ISSUESTATUS (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 111, "The Great Gatsby", '2023-06-05', 'ISBN001'),
(2, 222, "To Kill a Mockingbird", '2023-05-10', 'ISBN002'),
(3, 333, "1984", '2023-06-12', 'ISBN003'),
(4, 444, "Pride and Prejudice", '2023-04-15', 'ISBN004'),
(5, 555, "The Catcher in the Rye", '2023-09-05', 'ISBN005');
select * from issuestatus;




CREATE TABLE RETURNSTATUS(
Return_Id INT PRIMARY KEY,
Return_cust INT,
Return_book_name VARCHAR(250),
Return_date DATE,
Isbn_book2 VARCHAR(250),
FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1, 111, "The Great Gatsby", '2023-06-18', 'ISBN001'),
(2, 222, "To Kill a Mockingbird", '2023-06-20', 'ISBN002'),
(3, 333, "1984", '2023-06-21', 'ISBN003'),
(4, 444, "Pride and Prejudice", '2023-06-18', 'ISBN004'),
(5, 555, "The Catcher in the Rye", '2023-06-20', 'ISBN005'),
(6, 666, "Harry Potter", '2023-06-21', 'ISBN006');
select* from returnstatus;




CREATE TABLE BOOKS(
  ISBN VARCHAR(25) PRIMARY KEY,
  Book_title VARCHAR(25),
  Category VARCHAR(20),
  Rental_Price DECIMAL(10, 2),
  Status VARCHAR(3),
  Author VARCHAR(20),
  Publisher VARCHAR(20)
);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('ISBN001', 'Book A', 'Fiction', 9.99, 'yes', 'AUTHOR X', 'PUBLISHER A'),
('ISBN002', 'Book B', 'Mystery', 8.99, 'yes', 'AUTHOR Y', 'PUBLISHER B'),
('ISBN003', 'Book C', 'History', 12.99, 'no', 'AUTHOR Z', 'PUBLISHER C'),
('ISBN004', 'Book D', 'Fiction', 9.99, 'yes', 'AUTHOR R', 'PUBLISHER D'),
('ISBN005', 'Book E', 'Science Fiction', 11.89, 'yes', 'AUTHOR T', 'PUBLISHER E'),
('ISBN006', 'Book F', 'Romance', 9.50, 'yes', 'AUTHOR U', 'PUBLISHER F'),
('ISBN007', 'Book G', 'Biography', 10.20, 'no', 'AUTHOR E', 'PUBLISHER G'),
('ISBN008', 'Book H', 'Fiction', 8.89, 'yes', 'AUTHOR Q', 'PUBLISHER H');
 select * from books;
 
 
 #QUERIES
 
 
#Retrieve the book title, category, and rental price of all available books.

SELECT book_title, category, rental_price FROM books WHERE status = 'yes'; 


#List the employee names and their respective salaries in descending order of salary.

SELECT EMP_NAME,SALARY FROM EMPLOYEE ORDER BY SALARY DESC;


#Retrieve the book titles and the corresponding customers who have issued those books.

SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus, Books, Customer
WHERE IssueStatus.Isbn_book = Books.ISBN
AND IssueStatus.Issued_cust = Customer.Customer_Id;



SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
INNER JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
INNER JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;


# Display the total count of books in each category. 

SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;



# Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT EMP_NAME, POSITION FROM EMPLOYEE WHERE SALARY > 50000;



#List the customer names who registered before 2022-01-01 and have not issued any books yet. 

SELECT Customer.Customer_name
FROM Customer
LEFT JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE Customer.Reg_date < '2022-01-01'
AND IssueStatus.Issue_Id IS NULL;



#Display the branch numbers and the total count of employees in each branch.

SELECT Branch_no, COUNT(Emp_Id) FROM Branch LEFT JOIN Employee ON Branch.Manager_Id = 
Employee.Emp_Id GROUP BY Branch_no;




# Display the names of customers who have issued books in the month of June 2023.

SELECT Customer_name
FROM Customer
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE IssueStatus.Issue_date >= '2023-06-01' AND IssueStatus.Issue_date < '2023-07-01';




#Retrieve book_title from book table containing history.

SELECT Book_title
FROM Books
WHERE Category = 'history';



#Retrieve the branch numbers along with the count of employees for branches having more than 5 employees

SELECT Branch_no, count(Emp_id) FROM Branch INNER JOIN Employee ON Manager_Id = Emp_Id GROUP BY Branch_no HAVING count(Emp_Id)>5 ;
 

