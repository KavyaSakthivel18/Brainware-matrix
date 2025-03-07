-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255),
    DateOfBirth DATE,
    JoinDate DATE NOT NULL
);

-- Movies Table
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Genre VARCHAR(50),
    ReleaseYear INT,
    Director VARCHAR(100),
    Rating VARCHAR(10),
    Duration INT, -- Duration in minutes
    Price DECIMAL(10, 2) NOT NULL
);

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50) UNIQUE NOT NULL
);

-- MovieCategories Table
CREATE TABLE MovieCategories (
    MovieID INT,
    CategoryID INT,
    PRIMARY KEY (MovieID, CategoryID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Rentals Table
CREATE TABLE Rentals (
    RentalID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    MovieID INT,
    RentalDate DATE NOT NULL,
    ReturnDate DATE,
    DueDate DATE NOT NULL,
    RentalStatus VARCHAR(20) CHECK (RentalStatus IN ('rented', 'returned', 'overdue')),
    RentalFee DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    RentalID INT,
    PaymentAmount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(50), -- e.g., Credit Card, Cash
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID)
);

-- Staff Table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    JobTitle VARCHAR(50),
    HireDate DATE NOT NULL
);

-- MovieReviews Table
CREATE TABLE MovieReviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    MovieID INT,
    CustomerID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- LateFees Table
CREATE TABLE LateFees (
    LateFeeID INT PRIMARY KEY AUTO_INCREMENT,
    RentalID INT,
    LateFeeAmount DECIMAL(10, 2) NOT NULL,
    DateIssued DATE NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('paid', 'unpaid')),
    FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID)
);

-- MovieStock Table
CREATE TABLE MovieStock (
    StockID INT PRIMARY KEY AUTO_INCREMENT,
    MovieID INT,
    Quantity INT NOT NULL,
    AvailableQuantity INT NOT NULL,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);
