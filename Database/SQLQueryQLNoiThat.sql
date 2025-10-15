
IF DB_ID(N'QLNoiThat') IS NOT NULL
BEGIN
    ALTER DATABASE QLNoiThat SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE QLNoiThat;
END
GO

CREATE DATABASE QLNoiThat;
GO

USE QLNoiThat;
GO

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) NULL,
    Address NVARCHAR(255) NULL,
    Role NVARCHAR(20) DEFAULT 'Customer',
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NULL
);
GO

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT NOT NULL,
    ProductName NVARCHAR(200) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    Description NVARCHAR(1000) NULL,
    Material NVARCHAR(100) NULL,
    Features NVARCHAR(500) NULL,
    ImageURL NVARCHAR(255) NULL,
    Brand NVARCHAR(100) NULL,
    Stock INT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2) NULL,
    Status NVARCHAR(30) DEFAULT 'Pending',
    PaymentMethod NVARCHAR(50) NULL,
    ShippingAddress NVARCHAR(255) NULL,
    Note NVARCHAR(500) NULL,
    CONSTRAINT FK_Orders_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderItems_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT NOT NULL,
    Comment NVARCHAR(500) NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Reviews_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT FK_Reviews_Users FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT UQ_Reviews_Product_User UNIQUE (ProductID, UserID)  -- 1 user chỉ đánh giá 1 lần 1 sản phẩm
);
GO

CREATE TABLE Contacts (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NULL,
    Phone NVARCHAR(20) NULL,
    Message NVARCHAR(1000) NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Contacts_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

INSERT INTO Categories (CategoryName, Description) VALUES
(N'Sofa', N'Ghế sofa phòng khách cao cấp'),
(N'Bàn', N'Bàn ăn, bàn trà, bàn làm việc'),
(N'Ghế', N'Các loại ghế văn phòng, ghế gỗ'),
(N'Tủ', N'Tủ quần áo, tủ giày, tủ trang trí'),
(N'Giường', N'Giường ngủ gỗ, sắt, da hiện đại');
GO

INSERT INTO Users (FullName, Email, PasswordHash, Phone, Address, Role)
VALUES
(N'Nguyễn Văn A', N'vana@example.com', N'customer', N'0909123456', N'12 Lý Thường Kiệt, Hà Nội', N'Customer'),
(N'Lê Thị B', N'lethib@example.com', N'customer', N'0909456123', N'45 Trần Phú, Đà Nẵng', N'Customer'),
(N'Admin', N'admin@noithat.vn', N'admin', N'0909000000', N'22 Pasteur, TP.HCM', N'Admin');
GO

-- Note: CategoryIDs correspond to inserted Categories above (Sofa=1, Bàn=2, Ghế=3, Tủ=4, Giường=5)
INSERT INTO Products (CategoryID, ProductName, Price, Description, Material, Features, ImageURL, Brand, Stock)
VALUES
(1, N'Sofa góc L da cao cấp', 12500000, N'Sofa góc bọc da, thiết kế hiện đại.', N'Da PU', N'Góc L, Chống trầy, Dễ vệ sinh', N'images/sofa1.jpg', N'LuxeHome', 10),
(2, N'Bàn ăn gỗ sồi 6 ghế', 8900000, N'Bàn ăn gỗ sồi tự nhiên, bền đẹp.', N'Gỗ sồi', N'6 ghế, Chống ẩm, Mặt nhẵn', N'images/ban1.jpg', N'LuxeHome', 15),
(3, N'Ghế xoay văn phòng', 1200000, N'Ghế xoay lưng lưới, điều chỉnh độ cao.', N'Nhựa + Lưới', N'Xoay 360°, Thoáng khí', N'images/ghe1.jpg', N'OfficeMate', 30),
(4, N'Tủ quần áo 3 cánh trượt', 7800000, N'Tủ gỗ MDF phủ melamine.', N'Gỗ MDF', N'Cánh trượt, Chống ẩm', N'images/tu1.jpg', N'MocGia', 5),
(5, N'Giường ngủ bọc nệm hiện đại', 9500000, N'Giường nệm khung gỗ chắc chắn.', N'Gỗ + Vải nệm', N'Dễ tháo lắp, Êm ái', N'images/giuong1.jpg', N'SweetDream', 8);
GO

-- Note: UserID 1 => Nguyễn Văn A, UserID 2 => Lê Thị B
INSERT INTO Orders (UserID, TotalAmount, Status, PaymentMethod, ShippingAddress, Note)
VALUES
(1, 21400000, N'Pending', N'COD', N'12 Lý Thường Kiệt, Hà Nội', N'Giao buổi sáng'),
(2, 1200000, N'Done', N'BankTransfer', N'45 Trần Phú, Đà Nẵng', N'Đã thanh toán online');
GO

INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 12500000),
(1, 2, 1, 8900000),
(2, 3, 1, 1200000);
GO

INSERT INTO Reviews (ProductID, UserID, Rating, Comment)
VALUES
(1, 1, 5, N'Sofa rất đẹp và êm.'),
(3, 2, 4, N'Ghế dùng ổn, hơi cứng.'),
(2, 1, 5, N'Bàn gỗ chắc chắn, màu đẹp.');
GO

INSERT INTO Contacts (UserID, FullName, Email, Phone, Message)
VALUES
(NULL, N'Phạm Minh C', N'minhc@example.com', N'0909888777', N'Tôi muốn hỏi thêm về mẫu giường nệm.'),
(1, N'Nguyễn Văn A', N'vana@example.com', N'0909123456', N'Đơn hàng của tôi giao khi nào?');
GO

SELECT TOP 10 * FROM Categories;
SELECT TOP 10 * FROM Users;
SELECT TOP 10 * FROM Products;
SELECT TOP 10 * FROM Orders;
SELECT TOP 10 * FROM OrderItems;
SELECT TOP 10 * FROM Reviews;
SELECT TOP 10 * FROM Contacts;
GO

PRINT 'Seed data created successfully in QLNoiThat database. Remember: passwords stored in plain text for testing only.';
GO
