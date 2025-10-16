-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 16, 2025 lúc 02:30 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `furnishop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`CategoryID`, `CategoryName`, `Description`) VALUES
(1, 'Sofa', 'Ghế sofa phòng khách cao cấp'),
(2, 'Bàn', 'Bàn ăn, bàn trà, bàn làm việc'),
(3, 'Ghế', 'Các loại ghế văn phòng, ghế gỗ'),
(4, 'Tủ', 'Tủ quần áo, tủ giày, tủ trang trí'),
(5, 'Giường', 'Giường ngủ hiện đại, đa dạng kích thước');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contacts`
--

CREATE TABLE `contacts` (
  `ContactID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `FullName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Message` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `contacts`
--

INSERT INTO `contacts` (`ContactID`, `UserID`, `FullName`, `Email`, `Phone`, `Message`, `CreatedAt`) VALUES
(1, NULL, 'Phạm Minh Tuấn', 'tuanpm@gmail.com', '0909888777', 'Mình muốn hỏi về bảo hành sofa.', '2025-10-16 18:41:08'),
(2, NULL, 'Lê Hồng Nhung', 'nhunghl@gmail.com', '0909990000', 'Có thể giảm giá khi mua combo bàn ghế không?', '2025-10-16 18:41:08');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orderitems`
--

CREATE TABLE `orderitems` (
  `OrderItemID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `UnitPrice` decimal(18,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `orderitems`
--

INSERT INTO `orderitems` (`OrderItemID`, `OrderID`, `ProductID`, `Quantity`, `UnitPrice`) VALUES
(1, 1, 1, 1, 18500000.00),
(2, 2, 14, 1, 12500000.00),
(3, 3, 15, 1, 8700000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `OrderDate` datetime DEFAULT current_timestamp(),
  `TotalAmount` decimal(18,2) DEFAULT NULL,
  `Status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Pending',
  `PaymentMethod` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ShippingAddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`OrderID`, `UserID`, `OrderDate`, `TotalAmount`, `Status`, `PaymentMethod`, `ShippingAddress`, `Note`) VALUES
(1, 1, '2025-10-16 18:41:08', 18500000.00, 'Done', 'COD', '25 Hai Bà Trưng, Hà Nội', 'Giao sáng mai'),
(2, 2, '2025-10-16 18:41:08', 12500000.00, 'Pending', 'BankTransfer', '12 Nguyễn Văn Linh, Đà Nẵng', 'Thanh toán qua app'),
(3, 3, '2025-10-16 18:41:08', 8700000.00, 'Done', 'COD', '45 Trần Phú, Nha Trang', 'Giao buổi chiều');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `ProductID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `ProductName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Price` decimal(18,2) NOT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Material` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Features` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ImageURL` varchar(255) DEFAULT NULL,
  `Brand` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Stock` int(11) DEFAULT 0,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`ProductID`, `CategoryID`, `ProductName`, `Price`, `Description`, `Material`, `Features`, `ImageURL`, `Brand`, `Stock`, `CreatedAt`) VALUES
(1, 1, 'Sofa LUX001 - Sofa da bò Ý cao cấp', 18500000.00, 'Sofa góc chữ L, da thật 100%, phong cách châu Âu.', 'Da bò Ý', 'Chống xước, dễ vệ sinh, khung gỗ tự nhiên', 'images/sofa1.jpg', 'LuxeHome', 10, '2025-10-16 18:41:08'),
(2, 1, 'Sofa LUX002 - Sofa nỉ mềm sang trọng', 12500000.00, 'Sofa 3 chỗ ngồi, nệm mút êm ái.', 'Nỉ cao cấp', 'Dễ tháo vỏ giặt, màu trung tính', 'images/sofa2.jpg', 'SoftHouse', 8, '2025-10-16 18:41:08'),
(3, 1, 'Sofa LUX003 - Sofa da công nghiệp hiện đại', 9800000.00, 'Dành cho phòng nhỏ, màu kem nhã nhặn.', 'Da PU', 'Chống thấm nước, khung inox', 'images/sofa3.jpg', 'UrbanStyle', 15, '2025-10-16 18:41:08'),
(4, 2, 'Bàn BAN001 - Bàn ăn gỗ sồi 6 ghế', 8900000.00, 'Bàn ăn kiểu Bắc Âu, mặt gỗ sồi tự nhiên.', 'Gỗ sồi', 'Chống mối mọt, dễ lau chùi', 'images/ban1.jpg', 'WoodArt', 12, '2025-10-16 18:41:08'),
(5, 2, 'Bàn BAN002 - Bàn làm việc chân sắt', 2500000.00, 'Dành cho không gian văn phòng nhỏ.', 'Gỗ MDF + Sắt sơn tĩnh điện', 'Bền, không gỉ', 'images/ban2.jpg', 'OfficePro', 25, '2025-10-16 18:41:08'),
(6, 2, 'Bàn BAN003 - Bàn trà tròn mặt kính', 3200000.00, 'Thiết kế hiện đại, phù hợp phòng khách.', 'Kính + Inox', 'Mặt kính cường lực, sang trọng', 'images/ban3.jpg', 'ModernHome', 20, '2025-10-16 18:41:08'),
(7, 3, 'Ghế GHE001 - Ghế xoay văn phòng lưng lưới', 1300000.00, 'Ghế xoay 360°, điều chỉnh độ cao linh hoạt.', 'Nhựa + Lưới', 'Thoáng khí, có bánh xe', 'images/ghe1.jpg', 'ErgoSeat', 40, '2025-10-16 18:41:08'),
(8, 3, 'Ghế GHE002 - Ghế ăn gỗ tự nhiên', 950000.00, 'Ghế gỗ sồi sơn bóng, bền chắc.', 'Gỗ sồi', 'Thiết kế cổ điển, tiện dụng', 'images/ghe2.jpg', 'WoodArt', 30, '2025-10-16 18:41:08'),
(9, 3, 'Ghế GHE003 - Ghế đôn nệm vải', 700000.00, 'Phù hợp phòng ngủ hoặc phòng khách.', 'Vải + Mút', 'Êm ái, nhỏ gọn', 'images/ghe3.jpg', 'SoftHome', 25, '2025-10-16 18:41:08'),
(10, 4, 'Tủ TU001 - Tủ quần áo 3 cánh trượt', 7500000.00, 'Tủ gỗ MDF phủ melamine chống ẩm.', 'Gỗ MDF', 'Cánh trượt tiện lợi', 'images/tu1.jpg', 'MocGia', 10, '2025-10-16 18:41:08'),
(11, 4, 'Tủ TU002 - Tủ giày 2 tầng nhỏ gọn', 2200000.00, 'Phù hợp chung cư nhỏ.', 'Gỗ công nghiệp', 'Cửa mở nhẹ, dễ lắp ráp', 'images/tu2.jpg', 'HomeFit', 30, '2025-10-16 18:41:08'),
(12, 4, 'Tủ TU003 - Tủ trang trí kính cường lực', 5400000.00, 'Tủ trưng bày sang trọng.', 'Gỗ + Kính', 'Kính an toàn, đèn LED bên trong', 'images/tu3.jpg', 'BrightHome', 8, '2025-10-16 18:41:08'),
(13, 5, 'Giường GIU001 - Giường nệm hiện đại', 9500000.00, 'Khung gỗ chắc chắn, bọc nệm êm ái.', 'Gỗ + Vải nệm', 'Dễ tháo lắp, bền bỉ', 'images/giuong1.jpg', 'SweetDream', 10, '2025-10-16 18:41:08'),
(14, 5, 'Giường GIU002 - Giường tầng trẻ em', 12500000.00, 'Thiết kế an toàn, có cầu thang.', 'Gỗ thông', 'Tiết kiệm diện tích, nhiều màu sắc', 'images/giuong2.jpg', 'KidHome', 6, '2025-10-16 18:41:08'),
(15, 5, 'Giường GIU003 - Giường gấp thông minh', 8700000.00, 'Phù hợp căn hộ nhỏ.', 'Gỗ + Thép', 'Gấp gọn tiện lợi', 'images/giuong3.jpg', 'SmartSleep', 9, '2025-10-16 18:41:08'),
(16, 1, 'Sofa LUX004 - Sofa đơn mini', 4500000.00, 'Phù hợp phòng nhỏ, màu be.', 'Nỉ cao cấp', 'Dễ di chuyển', 'images/sofa4.jpg', 'SoftHome', 14, '2025-10-16 18:41:08'),
(17, 2, 'Bàn BAN004 - Bàn ăn kính cường lực 4 ghế', 6900000.00, 'Mặt kính sang trọng, khung thép.', 'Kính + Thép', 'Dễ lau, bền màu', 'images/ban4.jpg', 'ModernHome', 10, '2025-10-16 18:41:08'),
(18, 3, 'Ghế GHE004 - Ghế thư giãn ngả lưng', 2100000.00, 'Có thể ngả 45°, chân inox.', 'Vải nỉ', 'Êm, chống trượt', 'images/ghe4.jpg', 'ComfortZone', 7, '2025-10-16 18:41:08'),
(19, 4, 'Tủ TU004 - Tủ quần áo cánh mở', 6900000.00, 'Tủ gỗ công nghiệp chống ẩm.', 'Gỗ MDF lõi xanh', 'Cửa mở dễ thao tác', 'images/tu4.jpg', 'MocGia', 9, '2025-10-16 18:41:08'),
(20, 5, 'Giường GIU004 - Giường gỗ tự nhiên', 10500000.00, 'Giường đôi, bền và chắc chắn.', 'Gỗ sồi', 'Thân thiện môi trường', 'images/giuong4.jpg', 'WoodArt', 11, '2025-10-16 18:41:08'),
(21, 3, 'Ghế GHE005 - Ghế bar chân cao', 1150000.00, 'Dành cho quầy bếp, quán cà phê.', 'Inox + Da PU', 'Điều chỉnh chiều cao', 'images/ghe5.jpg', 'UrbanStyle', 12, '2025-10-16 18:41:08'),
(22, 2, 'Bàn BAN005 - Bàn góc làm việc L-Shape', 4200000.00, 'Phù hợp phòng làm việc rộng.', 'Gỗ công nghiệp', 'Rộng rãi, tiện lợi', 'images/ban5.jpg', 'OfficePro', 6, '2025-10-16 18:41:08'),
(23, 1, 'Sofa LUX005 - Sofa vải cotton trẻ trung', 7200000.00, 'Màu pastel phù hợp phòng nhỏ.', 'Vải cotton', 'Mềm mại, thoáng mát', 'images/sofa5.jpg', 'SoftHome', 16, '2025-10-16 18:41:08'),
(24, 4, 'Tủ TU005 - Tủ sách gỗ óc chó', 6200000.00, 'Tủ sách 5 tầng thiết kế tối giản, vân gỗ óc chó sang trọng.', 'Gỗ óc chó', 'Chống cong vênh, chịu lực tốt', 'images/tu5.jpg', 'WoodArt', 18, '2025-10-16 19:22:00'),
(25, 5, 'Giường GIU005 - Giường tròn độc đáo', 15500000.00, 'Giường ngủ hình tròn bọc da cao cấp, tạo điểm nhấn cho phòng ngủ.', 'Da microfiber', 'Khung thép chịu lực, độc đáo', 'images/giuong5.jpg', 'SweetDream', 7, '2025-10-16 19:22:00'),
(26, 1, 'Sofa LUX006 - Sofa băng vải nhung', 8900000.00, 'Sofa băng 3 chỗ ngồi, chất liệu vải nhung mềm mại, màu xanh rêu.', 'Vải nhung', 'Chân gỗ sồi, nệm D40 êm ái', 'images/sofa6.jpg', 'SoftHouse', 11, '2025-10-16 19:22:00'),
(27, 2, 'Bàn BAN006 - Bàn trang điểm có đèn', 4800000.00, 'Bàn trang điểm hiện đại tích hợp gương và đèn LED cảm ứng.', 'Gỗ MDF', 'Đèn LED 3 màu, nhiều ngăn kéo', 'images/ban6.jpg', 'BrightHome', 20, '2025-10-16 19:22:00'),
(28, 3, 'Ghế GHE006 - Ghế Papasan thư giãn', 3500000.00, 'Ghế thư giãn hình tròn làm từ mây tự nhiên, kèm nệm dày.', 'Mây tự nhiên', 'Thoáng mát, thư giãn tối đa', 'images/ghe6.jpg', 'ComfortZone', 15, '2025-10-16 19:22:00'),
(29, 4, 'Tủ TU006 - Tủ bếp trên dưới', 11500000.00, 'Bộ tủ bếp gỗ công nghiệp chống ẩm, mặt đá granite.', 'Gỗ MDF lõi xanh', 'Chống ẩm, mặt đá dễ lau chùi', 'images/tu6.jpg', 'HomeFit', 9, '2025-10-16 19:22:00'),
(30, 1, 'Sofa LUX007 - Sofa đơn bọc da', 6800000.00, 'Sofa đơn phong cách tân cổ điển, bọc da PU màu nâu sẫm.', 'Da PU', 'Khung gỗ dầu, chạm khắc tinh xảo', 'images/sofa7.jpg', 'LuxeHome', 13, '2025-10-16 19:22:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reviews`
--

CREATE TABLE `reviews` (
  `ReviewID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Rating` int(11) NOT NULL,
  `Comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `reviews`
--

INSERT INTO `reviews` (`ReviewID`, `ProductID`, `UserID`, `Rating`, `Comment`, `CreatedAt`) VALUES
(1, 1, 1, 5, 'Sofa rất đẹp, ngồi êm ái.', '2025-10-16 18:41:08'),
(2, 2, 2, 4, 'Màu sắc đẹp, nhưng hơi khó vệ sinh.', '2025-10-16 18:41:08'),
(3, 5, 3, 5, 'Bàn ăn chắc chắn, rất ưng ý.', '2025-10-16 18:41:08'),
(4, 15, 4, 5, 'Giường ngủ cực kỳ thoải mái, đáng tiền.', '2025-10-16 18:41:08');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `FullName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PasswordHash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Customer',
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`UserID`, `FullName`, `Email`, `PasswordHash`, `Phone`, `Address`, `Role`, `CreatedAt`) VALUES
(1, 'Nguyễn Văn Nam', 'namnv@gmail.com', 'customer', '0912345678', '25 Hai Bà Trưng, Hà Nội', 'Customer', '2025-10-16 18:41:08'),
(2, 'Lê Thị Hương', 'huonglt@gmail.com', 'customer', '0988123123', '12 Nguyễn Văn Linh, Đà Nẵng', 'Customer', '2025-10-16 18:41:08'),
(3, 'Phạm Quốc Bảo', 'baopq@gmail.com', 'customer', '0905333444', '45 Trần Phú, Nha Trang', 'Customer', '2025-10-16 18:41:08'),
(4, 'Vũ Anh Dũng', 'dungva@gmail.com', 'customer', '0936777888', '89 Nguyễn Huệ, TP.HCM', 'Customer', '2025-10-16 18:41:08'),
(5, 'Ngô Thị Mai', 'maingo@gmail.com', 'customer', '0911666555', '67 Cách Mạng Tháng 8, Cần Thơ', 'Customer', '2025-10-16 18:41:08'),
(6, 'Admin FurniShop', 'admin@furnishop.vn', 'admin', '0909000000', '22 Pasteur, TP.HCM', 'Admin', '2025-10-16 18:41:08');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Chỉ mục cho bảng `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`ContactID`),
  ADD KEY `UserID` (`UserID`);

--
-- Chỉ mục cho bảng `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`OrderItemID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `UserID` (`UserID`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Chỉ mục cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`ReviewID`),
  ADD UNIQUE KEY `ProductID` (`ProductID`,`UserID`),
  ADD KEY `UserID` (`UserID`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `contacts`
--
ALTER TABLE `contacts`
  MODIFY `ContactID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `OrderItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `ProductID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `reviews`
--
ALTER TABLE `reviews`
  MODIFY `ReviewID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Các ràng buộc cho bảng `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  ADD CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`);

--
-- Các ràng buộc cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
