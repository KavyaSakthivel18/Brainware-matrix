-- Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    DateOfDeath DATE
);

-- Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    Genre VARCHAR(50),
    PublicationYear INT,
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Patrons Table
CREATE TABLE Patrons (
    PatronID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255)
);

-- Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    PatronID INT,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    DueDate DATE NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('borrowed', 'returned', 'overdue')),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (PatronID) REFERENCES Patrons(PatronID)
);

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50) UNIQUE NOT NULL
);

-- BookCategories Table
CREATE TABLE BookCategories (
    BookID INT,
    CategoryID INT,
    PRIMARY KEY (BookID, CategoryID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Publishers Table
CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY AUTO_INCREMENT,
    PublisherName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

-- BookPublishers Table
CREATE TABLE BookPublishers (
    BookID INT,
    PublisherID INT,
    PRIMARY KEY (BookID, PublisherID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

-- LibraryBranches Table
CREATE TABLE LibraryBranches (
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100) NOT NULL,
    Address VARCHAR(255)
);

-- BookCopies Table
CREATE TABLE BookCopies (
    CopyID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    BranchID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BranchID) REFERENCES LibraryBranches(BranchID)
);

-- OverdueFines Table
CREATE TABLE OverdueFines (
    FineID INT PRIMARY KEY AUTO_INCREMENT,
    TransactionID INT,
    FineAmount DECIMAL(10, 2) NOT NULL,
    DateIssued DATE NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('paid', 'unpaid')),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);

-- Reservations Table
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    PatronID INT,
    ReservationDate DATE NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('active', 'completed', 'cancelled')),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (PatronID) REFERENCES Patrons(PatronID)
);

-- Reviews Table
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    PatronID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (PatronID) REFERENCES Patrons(PatronID)
);
