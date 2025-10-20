-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 16, 2025 lúc 07:31 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

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
  `CategoryName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`CategoryID`, `CategoryName`) VALUES
(1, 'Sofa & Ghế bành'),
(2, 'Bàn các loại'),
(3, 'Giường & Phòng ngủ'),
(4, 'Tủ & Kệ lưu trữ'),
(5, 'Ghế'),
(6, 'Đồ trang trí'),
(7, 'Nội thất trẻ em'),
(8, 'Nội thất ngoài trời');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contacts`
--

CREATE TABLE `contacts` (
  `ContactID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `FullName` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Message` text NOT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `contacts`
--

INSERT INTO `contacts` (`ContactID`, `UserID`, `FullName`, `Email`, `Phone`, `Message`, `CreatedAt`) VALUES
(1, 2, 'Lý Ngọc Long', 'long.ly@example.com', '0922222222', 'Tôi muốn hỏi về chính sách bảo hành cho sản phẩm sofa da.', '2025-10-17 00:03:19'),
(2, NULL, 'Trần Anh Khoa', 'khoa.tran@guest.com', '0905111222', 'Vui lòng tư vấn cho tôi một bộ bàn ăn cho 8 người.', '2025-10-17 00:03:19'),
(3, 4, 'Đặng Đình Thế Hiếu', 'hieu.dang@example.com', '0944444444', 'Đơn hàng #1003 của tôi khi nào sẽ được giao?', '2025-10-17 00:03:19'),
(4, NULL, 'Lê Thị Thu Thảo', 'thao.le@guest.com', '0918222333', 'Cửa hàng có dịch vụ thiết kế nội thất trọn gói không?', '2025-10-17 00:03:19'),
(5, 3, 'Nguyễn Hữu Lương', 'luong.nguyen@example.com', '0933333333', 'Tôi muốn thay đổi địa chỉ giao hàng cho đơn hàng sắp tới.', '2025-10-17 00:03:19'),
(6, NULL, 'Phạm Gia Hân', 'han.pham@guest.com', '0945666777', 'Sản phẩm giường ngủ có những kích thước nào?', '2025-10-17 00:03:19'),
(7, 1, 'Đỗ Công Minh', 'minh.do@furnishop.vn', '0911111111', 'Yêu cầu xuất hóa đơn VAT cho công ty ABC.', '2025-10-17 00:03:19'),
(8, NULL, 'Võ Minh Anh', 'anh.vo@guest.com', '0978999888', 'Thời gian giao hàng đến Đà Nẵng là bao lâu?', '2025-10-17 00:03:19'),
(9, 2, 'Lý Ngọc Long', 'long.ly@example.com', '0922222222', 'Tôi có thể xem sản phẩm trực tiếp ở đâu tại TP.HCM?', '2025-10-17 00:03:19'),
(10, NULL, 'Hoàng Kim Ngân', 'ngan.hoang@guest.com', '0903444555', 'Chất liệu gỗ của bàn ăn có chống nước tốt không?', '2025-10-17 00:03:19'),
(11, 4, 'Đặng Đình Thế Hiếu', 'hieu.dang@example.com', '0944444444', 'Tôi cần hỗ trợ lắp đặt sản phẩm tại nhà ở Cần Thơ.', '2025-10-17 00:03:19'),
(12, NULL, 'Bùi Thanh Tùng', 'tung.bui@guest.com', '0912888999', 'Cửa hàng có chính sách trả góp qua thẻ tín dụng không?', '2025-10-17 00:03:19'),
(13, 3, 'Nguyễn Hữu Lương', 'luong.nguyen@example.com', '0933333333', 'Sản phẩm tôi nhận được bị một vết xước nhỏ, cần hỗ trợ.', '2025-10-17 00:03:19'),
(14, NULL, 'Đỗ Mỹ Linh', 'linh.do@guest.com', '0988777666', 'Tôi muốn đặt hàng với số lượng lớn cho dự án khách sạn.', '2025-10-17 00:03:19'),
(15, 1, 'Đỗ Công Minh', 'minh.do@furnishop.vn', '0911111111', 'Kiểm tra giúp tôi tình trạng còn hàng của sản phẩm Kệ TV #5.', '2025-10-17 00:03:19'),
(16, NULL, 'Ngô Bảo Châu', 'chau.ngo@guest.com', '0902333444', 'Sofa Andes có phiên bản màu xám không?', '2025-10-17 00:03:19'),
(17, NULL, 'Mai Phương Thúy', 'thuy.mai@guest.com', '0913555888', 'Tôi muốn hủy đơn hàng #1014 vừa đặt do nhầm lẫn.', '2025-10-17 00:03:19'),
(18, 2, 'Lý Ngọc Long', 'long.ly@example.com', '0922222222', 'Cảm ơn đội ngũ đã hỗ trợ tôi rất nhiệt tình trong lần mua trước.', '2025-10-17 00:03:19'),
(19, NULL, 'Trịnh Công Sơn', 'son.trinh@guest.com', '0944111222', 'Hỏi về vật liệu chính xác của ghế Eames.', '2025-10-17 00:03:19'),
(20, 3, 'Nguyễn Hữu Lương', 'luong.nguyen@example.com', '0933333333', 'Tôi đã nhận được hàng, sản phẩm rất đẹp. Cảm ơn shop.', '2025-10-17 00:03:19'),
(21, NULL, 'Vũ Cát Tường', 'tuong.vu@guest.com', '0908333444', 'Cửa hàng có làm việc vào ngày lễ không?', '2025-10-17 00:03:19'),
(22, 4, 'Đặng Đình Thế Hiếu', 'hieu.dang@example.com', '0944444444', 'Yêu cầu gửi catalogue sản phẩm mới nhất qua email.', '2025-10-17 00:03:19'),
(23, NULL, 'Hồ Ngọc Hà', 'ha.ho@guest.com', '0903888999', 'Tôi muốn biết thêm chi tiết về giường ngủ hoàng gia.', '2025-10-17 00:03:19'),
(24, 1, 'Đỗ Công Minh', 'minh.do@furnishop.vn', '0911111111', 'Tư vấn giúp tôi bộ sofa cho căn hộ 70m2.', '2025-10-17 00:03:19'),
(25, NULL, 'Đàm Vĩnh Hưng', 'hung.dam@guest.com', '0909111222', 'Chất liệu da của sofa Chesterfield có phải da thật 100% không?', '2025-10-17 00:03:19'),
(26, 2, 'Lý Ngọc Long', 'long.ly@example.com', '0922222222', 'Thời gian bảo hành của tủ bếp là bao lâu?', '2025-10-17 00:03:19'),
(27, NULL, 'Mỹ Tâm', 'tam.my@guest.com', '0903222333', 'Tôi có thể đặt kích thước riêng cho bàn ăn gỗ sồi không?', '2025-10-17 00:03:19'),
(28, 3, 'Nguyễn Hữu Lương', 'luong.nguyen@example.com', '0933333333', 'Gửi tôi báo giá cho 10 chiếc ghế công thái học #21.', '2025-10-17 00:03:19'),
(29, NULL, 'Sơn Tùng M-TP', 'tung.son@guest.com', '0918555666', 'Sản phẩm có giao hàng đến Phú Quốc không và chi phí thế nào?', '2025-10-17 00:03:19'),
(30, 4, 'Đặng Đình Thế Hiếu', 'hieu.dang@example.com', '0944444444', 'Tôi cần tìm một chiếc ghế thư giãn đọc sách, vui lòng tư vấn.', '2025-10-17 00:03:19');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orderitems`
--

CREATE TABLE `orderitems` (
  `OrderItemID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `UnitPrice` decimal(18,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `orderitems`
--

INSERT INTO `orderitems` (`OrderItemID`, `OrderID`, `ProductID`, `Quantity`, `UnitPrice`) VALUES
(1, 1, 1, 1, 28500000),
(2, 2, 3, 1, 25500000),
(3, 3, 5, 1, 15500000),
(4, 4, 2, 1, 35000000),
(5, 5, 20, 1, 5600000),
(6, 6, 4, 1, 45000000),
(7, 7, 8, 1, 18900000),
(8, 8, 6, 1, 26500000),
(9, 9, 9, 2, 950000),
(10, 10, 12, 1, 12000000),
(11, 11, 1, 1, 28500000),
(12, 11, 7, 1, 2800000),
(13, 12, 15, 1, 16000000),
(14, 13, 18, 1, 4500000),
(15, 14, 10, 1, 22000000),
(16, 15, 11, 1, 22500000),
(17, 16, 14, 1, 13500000),
(18, 17, 16, 1, 9800000),
(19, 18, 19, 1, 7800000),
(20, 19, 22, 1, 12300000),
(21, 20, 21, 1, 9800000),
(22, 21, 2, 1, 35000000),
(23, 22, 25, 1, 6200000),
(24, 23, 27, 1, 5200000),
(25, 24, 28, 1, 3500000),
(26, 25, 24, 1, 11500000),
(27, 26, 3, 1, 25500000),
(28, 27, 26, 1, 4800000),
(29, 28, 9, 4, 950000),
(30, 29, 29, 1, 16200000),
(31, 30, 1, 2, 28500000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `OrderDate` datetime DEFAULT current_timestamp(),
  `TotalAmount` decimal(18,0) NOT NULL,
  `Status` varchar(30) NOT NULL DEFAULT 'Pending',
  `PaymentMethod` varchar(50) DEFAULT NULL,
  `ShippingAddress` varchar(255) NOT NULL,
  `Note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`OrderID`, `UserID`, `OrderDate`, `TotalAmount`, `Status`, `PaymentMethod`, `ShippingAddress`, `Note`) VALUES
(1, 2, '2025-10-10 10:00:00', 28500000, 'Done', 'COD', '20 Hai Bà Trưng, Quận 1, TP.HCM', NULL),
(2, 3, '2025-10-11 11:30:00', 25500000, 'Shipping', 'BankTransfer', '30 Trần Phú, Hải Châu, Đà Nẵng', NULL),
(3, 4, '2025-10-12 14:00:00', 15500000, 'Done', 'COD', '40 Hùng Vương, Ninh Kiều, Cần Thơ', NULL),
(4, 5, '2025-10-12 15:10:00', 35000000, 'Pending', 'COD', '50 Nguyễn Văn Cừ, Long Biên, Hà Nội', NULL),
(5, 6, '2025-10-13 09:05:00', 5600000, 'Done', 'BankTransfer', '60 Võ Văn Tần, Quận 3, TP.HCM', NULL),
(6, 7, '2025-10-13 16:45:00', 45000000, 'Cancelled', 'COD', '70 Lê Duẩn, Thanh Khê, Đà Nẵng', NULL),
(7, 8, '2025-10-14 08:20:00', 18900000, 'Shipping', 'BankTransfer', '80 Hòa Bình, Ninh Kiều, Cần Thơ', NULL),
(8, 9, '2025-10-14 11:00:00', 26500000, 'Pending', 'COD', '90 Láng Hạ, Đống Đa, Hà Nội', NULL),
(9, 10, '2025-10-15 13:15:00', 1900000, 'Done', 'COD', '100 Nam Kỳ Khởi Nghĩa, Quận 1, TP.HCM', NULL),
(10, 11, '2025-10-15 17:00:00', 12000000, 'Shipping', 'BankTransfer', '110 Cầu Giấy, Cầu Giấy, Hà Nội', NULL),
(11, 2, '2025-10-16 09:30:00', 31300000, 'Pending', 'COD', '20 Hai Bà Trưng, Quận 1, TP.HCM', NULL),
(12, 12, '2025-10-16 10:00:00', 16000000, 'Done', 'BankTransfer', '120 Nguyễn Chí Thanh, Quận 5, TP.HCM', NULL),
(13, 13, '2025-10-17 14:20:00', 4500000, 'Shipping', 'COD', '130 Điện Biên Phủ, Bình Thạnh, TP.HCM', NULL),
(14, 14, '2025-10-17 18:00:00', 22000000, 'Pending', 'BankTransfer', '140 Xô Viết Nghệ Tĩnh, Bình Thạnh, TP.HCM', NULL),
(15, 15, '2025-10-18 11:11:00', 22500000, 'Done', 'COD', '150 Phan Xích Long, Phú Nhuận, TP.HCM', NULL),
(16, 16, '2025-10-18 12:00:00', 13500000, 'Shipping', 'COD', '160 Lý Chính Thắng, Quận 3, TP.HCM', NULL),
(17, 17, '2025-10-19 09:00:00', 9800000, 'Pending', 'BankTransfer', '170 Võ Thị Sáu, Quận 3, TP.HCM', NULL),
(18, 18, '2025-10-19 14:30:00', 7800000, 'Done', 'COD', '180 Pasteur, Quận 1, TP.HCM', NULL),
(19, 19, '2025-10-20 10:45:00', 12300000, 'Shipping', 'BankTransfer', '190 Lê Thánh Tôn, Quận 1, TP.HCM', NULL),
(20, 20, '2025-10-20 16:00:00', 9800000, 'Pending', 'COD', '200 Đồng Khởi, Quận 1, TP.HCM', NULL),
(21, 21, '2025-10-21 08:00:00', 35000000, 'Done', 'COD', '210 Nguyễn Thị Minh Khai, Quận 1, TP.HCM', NULL),
(22, 22, '2025-10-21 11:30:00', 6200000, 'Shipping', 'BankTransfer', '220 Trương Định, Quận 3, TP.HCM', NULL),
(23, 23, '2025-10-22 13:00:00', 5200000, 'Pending', 'COD', '230 Bà Huyện Thanh Quan, Quận 3, TP.HCM', NULL),
(24, 24, '2025-10-22 15:00:00', 3500000, 'Done', 'BankTransfer', '240 Sư Vạn Hạnh, Quận 10, TP.HCM', NULL),
(25, 25, '2025-10-23 10:10:00', 11500000, 'Shipping', 'COD', '250 Thành Thái, Quận 10, TP.HCM', NULL),
(26, 26, '2025-10-23 14:00:00', 25500000, 'Pending', 'COD', '260 Tô Hiến Thành, Quận 10, TP.HCM', NULL),
(27, 27, '2025-10-24 09:45:00', 4800000, 'Done', 'BankTransfer', '270 3 Tháng 2, Quận 10, TP.HCM', NULL),
(28, 28, '2025-10-24 16:30:00', 3800000, 'Shipping', 'COD', '280 Lý Thường Kiệt, Quận 11, TP.HCM', NULL),
(29, 29, '2025-10-25 11:00:00', 16200000, 'Pending', 'BankTransfer', '290 Lạc Long Quân, Quận 11, TP.HCM', NULL),
(30, 30, '2025-10-25 17:00:00', 57000000, 'Done', 'COD', '300 Âu Cơ, Tân Bình, TP.HCM', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `ProductID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `ProductName` varchar(200) NOT NULL,
  `Price` decimal(18,0) NOT NULL,
  `Description` text DEFAULT NULL,
  `Material` varchar(100) DEFAULT NULL,
  `Dimensions` varchar(100) DEFAULT NULL,
  `Features` varchar(500) DEFAULT NULL,
  `ImageURL` varchar(255) DEFAULT NULL,
  `Brand` varchar(100) DEFAULT NULL,
  `Stock` int(11) NOT NULL DEFAULT 0,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`ProductID`, `CategoryID`, `ProductName`, `Price`, `Description`, `Material`, `Dimensions`, `Features`, `ImageURL`, `Brand`, `Stock`, `CreatedAt`) VALUES
(1, 1, 'Sofa Băng Vải Lông Cừu Andes', 28500000, 'Thiết kế tối giản, chất liệu vải lông cừu mang lại cảm giác ấm cúng, sang trọng.', 'Vải lông cừu, Khung gỗ sồi', '240cm x 95cm x 75cm', 'Nệm mút D40; Chân gỗ tự nhiên; Vải nhập khẩu', 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=800', 'Andes', 10, '2025-10-17 00:00:30'),
(2, 1, 'Ghế Bành Da Bò Thật Eames', 35000000, 'Biểu tượng của sự thư giãn và đẳng cấp. Làm từ da bò thật và gỗ óc chó.', 'Da bò thật, Gỗ óc chó', '84cm x 85cm x 89cm', 'Góc ngả lưng thư giãn; Kèm đôn gác chân; Chân hợp kim xoay', 'https://images.unsplash.com/photo-1592078615290-033ee584e267?q=80&w=800', 'Eames', 5, '2025-10-17 00:00:30'),
(3, 2, 'Bộ Bàn Ăn 6 Ghế Gỗ Sồi Oval', 25500000, 'Thiết kế bàn oval độc đáo, tạo sự gần gũi. Ghế bọc da PU.', 'Gỗ sồi, Da PU', 'Bàn: 180cm x 90cm x 75cm', 'Mặt bàn chống trầy; Ghế công thái học; Chống mối mọt', 'https://images.unsplash.com/photo-1604578762246-41134e37f9cc?q=80&w=800', 'Oval', 12, '2025-10-17 00:00:30'),
(4, 3, 'Giường Ngủ Gỗ Óc Chó Hoàng Gia', 45000000, 'Gỗ óc chó tự nhiên, đầu giường bọc da cao cấp, mang lại vẻ đẹp quyền quý.', 'Gỗ óc chó, Da cao cấp', '180cm x 200cm', 'Thiết kế sang trọng; Độ bền cao; Vân gỗ tự nhiên', 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?q=80&w=800', 'Royal', 8, '2025-10-17 00:00:30'),
(5, 4, 'Kệ Tivi Gỗ Óc Chó Hiện Đại', 15500000, 'Đường nét tinh xảo, màu gỗ óc chó sang trọng, nâng tầm không gian phòng khách.', 'Gỗ óc chó', '200cm x 40cm x 50cm', 'Nhiều ngăn chứa đồ; Bề mặt sơn lacker; Ray trượt giảm chấn', 'https://images.unsplash.com/photo-1615965511434-3111302157d7?q=80&w=800', 'Modern', 20, '2025-10-17 00:00:30'),
(6, 4, 'Tủ Quần Áo Cánh Kính 4 Buồng', 26500000, 'Thiết kế hiện đại với cánh kính và hệ thống đèn LED bên trong.', 'Gỗ MDF lõi xanh, Kính cường lực', '220cm x 60cm x 240cm', 'Cánh kính sang trọng; Đèn LED cảm ứng; Chống ẩm', 'https://images.unsplash.com/photo-1618220179428-22790b461013?q=80&w=800', 'Glassy', 15, '2025-10-17 00:00:30'),
(7, 1, 'Ghế Lười Hạt Xốp Canvas', 2800000, 'Mang lại sự thoải mái và linh hoạt tối đa cho không gian giải trí.', 'Vải Canvas, Hạt xốp EPS', '90cm x 110cm', 'Vỏ có thể tháo rời; Dễ dàng vệ sinh; Trọng lượng nhẹ', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=800', 'Canvas', 30, '2025-10-17 00:00:30'),
(8, 2, 'Bàn Ăn Tròn Mặt Đá 4 Ghế', 18900000, 'Mặt đá ceramic chống xước, chống ố, chân bàn cách điệu tạo điểm nhấn.', 'Đá ceramic, Chân thép', 'Bàn: D120cm x H75cm', 'Chống trầy xước; Chân bàn nghệ thuật; Ghế bọc nỉ', 'https://images.unsplash.com/photo-1519643381401-22c77e60520e?q=80&w=800', 'Ceramic', 18, '2025-10-17 00:00:30'),
(9, 5, 'Ghế Ăn Gỗ Tần Bì Bọc Da', 950000, 'Ghế ăn đơn giản, thanh lịch, làm từ gỗ tần bì và mặt ngồi bọc da PU.', 'Gỗ tần bì, Da PU', '45cm x 50cm x 85cm', 'Thiết kế công thái học; Dễ dàng vệ sinh; Gỗ tự nhiên', 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc?q=80&w=800', 'Scandinavian', 40, '2025-10-17 00:00:30'),
(10, 6, 'Đèn Chùm Pha Lê Nghệ Thuật', 22000000, 'Đèn chùm với hàng trăm viên pha lê K9 lấp lánh, điểm nhấn đắt giá cho phòng khách.', 'Pha lê K9, Hợp kim', 'D80cm x H60cm', 'Ánh sáng vàng ấm; Tiết kiệm điện; Thiết kế nghệ thuật', 'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?q=80&w=800', 'Classic', 10, '2025-10-17 00:00:30'),
(11, 2, 'Bàn Ăn Mở Rộng Thông Minh', 22500000, 'Linh hoạt thay đổi kích thước từ 1.4m đến 1.8m, phù hợp cho tiệc tùng.', 'Gỗ sồi, Mặt đá ceramic', '140-180cm x 80cm x 75cm', 'Mở rộng dễ dàng; Mặt đá chống xước; Khung gỗ chắc chắn', 'https://images.unsplash.com/photo-1617806118233-5cf3b4681a8a?q=80&w=800', 'SmartDesign', 14, '2025-10-17 00:00:30'),
(12, 4, 'Tủ Buffet Bếp Đa Năng', 12000000, 'Không gian lưu trữ lớn cho đồ dùng nhà bếp, mặt tủ có thể dùng làm đảo bếp mini.', 'Gỗ MDF lõi xanh', '160cm x 45cm x 90cm', 'Nhiều ngăn chứa; Chống ẩm; Tay nắm kim loại', 'https://images.unsplash.com/photo-1600122425538-f86a5a4155a6?q=80&w=800', 'KitchenPro', 16, '2025-10-17 00:00:30'),
(13, 7, 'Giường Tầng Gỗ Thông', 9800000, 'Giường tầng trẻ em, làm từ gỗ thông New Zealand, an toàn và tiết kiệm diện tích.', 'Gỗ thông', '120cm x 200cm', 'Sơn gốc nước an toàn; Kết cấu chắc chắn; Tiết kiệm diện tích', 'https://images.unsplash.com/photo-1615875605825-5eb9bb5fea38?q=80&w=800', 'KidHome', 22, '2025-10-17 00:00:30'),
(14, 2, 'Bàn Làm Việc Nâng Hạ Điện', 13500000, 'Thay đổi chiều cao linh hoạt, bảo vệ sức khỏe cột sống và tăng hiệu quả làm việc.', 'Gỗ MDF, Khung thép', '140cm x 70cm', 'Động cơ điện êm ái; Ghi nhớ 4 vị trí; Mặt bàn chống trầy', 'https://images.unsplash.com/photo-1517400508447-f8a614948a25?q=80&w=800', 'ErgoDesk', 18, '2025-10-17 00:00:30'),
(15, 3, 'Giường Ngủ Tối Giản Kiểu Nhật', 16000000, 'Thiết kế sát sàn, chất liệu gỗ thông tự nhiên, mang lại cảm giác an yên.', 'Gỗ thông', '160cm x 200cm', 'Phong cách tối giản; Gỗ tự nhiên; Dễ lắp ráp', 'https://images.unsplash.com/photo-1595526114035-0d45ed16433d?q=80&w=800', 'ZenStyle', 25, '2025-10-17 00:00:30'),
(16, 3, 'Bàn Trang Điểm Gỗ Sồi Có Gương LED', 9800000, 'Gương cảm ứng với 3 chế độ ánh sáng, nhiều ngăn chứa đồ tiện lợi.', 'Gỗ sồi', '100cm x 40cm x 135cm', 'Đèn LED 3 màu; Kèm ghế đôn; Ngăn kéo tiện lợi', 'https://images.unsplash.com/photo-1598556138615-99f8487b412e?q=80&w=800', 'BeautySpace', 30, '2025-10-17 00:00:30'),
(17, 1, 'Sofa Da Bò Ý Chesterfield', 75000000, 'Vẻ đẹp cổ điển với các chi tiết nút bấm đặc trưng và chất liệu da bò cao cấp.', 'Da bò thật', '280cm x 100cm x 80cm', 'Da bò Ý nhập khẩu; Làm thủ công; Khung gỗ sồi', 'https://images.unsplash.com/photo-1594026112274-b3522f16143b?q=80&w=800', 'Chesterfield', 4, '2025-10-17 00:00:30'),
(18, 3, 'Tủ Đầu Giường Thông Minh', 4500000, 'Tích hợp sạc không dây, loa bluetooth và đèn ngủ cảm ứng.', 'Gỗ MDF, Kính cường lực', '50cm x 40cm x 55cm', 'Sạc không dây Qi; Loa Bluetooth; Đèn LED cảm ứng', 'https://images.unsplash.com/photo-1633519946483-336a99b45a0b?q=80&w=800', 'TechNap', 28, '2025-10-17 00:00:30'),
(19, 4, 'Kệ Sách Gỗ Tự Nhiên 5 Tầng', 7800000, 'Kệ sách chắc chắn với 5 tầng lưu trữ rộng rãi, phù hợp cho sách và đồ trang trí.', 'Gỗ sồi', '120cm x 30cm x 180cm', 'Chịu lực tốt; Chống cong vênh; Gỗ tự nhiên', 'https://images.unsplash.com/photo-1558153403-398588a91345?q=80&w=800', 'BookWorm', 24, '2025-10-17 00:00:30'),
(20, 4, 'Tủ Giày Thông Minh Cửa Lật', 5600000, 'Thiết kế mỏng gọn, sức chứa lớn, giúp không gian lối vào ngăn nắp.', 'Gỗ MDF lõi xanh', '80cm x 24cm x 120cm', 'Cửa lật 2 lớp; Chứa được 24 đôi giày; Chống ẩm', 'https://images.unsplash.com/photo-1618221617593-8439b1a03a74?q=80&w=800', 'ShoeSmart', 35, '2025-10-17 00:00:30'),
(21, 5, 'Ghế Công Thái Học Ergonomic', 9800000, 'Hỗ trợ toàn diện cho lưng, cổ và tay, giảm mệt mỏi khi ngồi làm việc lâu.', 'Lưới, Hợp kim nhôm', '65cm x 65cm x 115-125cm', 'Ngả lưng 135 độ; Tựa đầu 3D; Kê tay 4D', 'https://images.unsplash.com/photo-1580489240954-5135aa32c589?q=80&w=800', 'ErgoChair', 20, '2025-10-17 00:00:30'),
(22, 4, 'Tủ Buffet Bếp Đa Năng', 12300000, 'Không gian lưu trữ lớn cho đồ dùng nhà bếp, có thể dùng làm đảo bếp mini.', 'Gỗ MDF, Mặt đá', '150cm x 40cm x 85cm', 'Nhiều ngăn kéo; Cánh tủ giảm chấn; Chống ẩm', 'https://images.unsplash.com/photo-1600122425538-f86a5a4155a6?q=80&w=800', 'KitchenPro', 17, '2025-10-17 00:00:30'),
(23, 5, 'Ghế Papasan thư giãn', 3500000, 'Ghế thư giãn hình tròn làm từ mây tự nhiên, kèm nệm dày.', 'Mây tự nhiên, Vải bố', 'D110cm', 'Thoáng mát; Thư giãn tối đa; Nệm dày êm ái', 'https://images.unsplash.com/photo-1631679701835-2698c4421633?q=80&w=800', 'ComfortZone', 26, '2025-10-17 00:00:30'),
(24, 6, 'Thảm Lông Cừu Thổ Nhĩ Kỳ', 11500000, 'Họa tiết tinh xảo, chất liệu len tự nhiên, mang lại sự sang trọng và ấm áp.', 'Len tự nhiên', '200cm x 300cm', 'Dệt thủ công; Mềm mại, êm ái; Họa tiết độc đáo', 'https://images.unsplash.com/photo-1575429199926-f78e02d90a61?q=80&w=800', 'RugArt', 19, '2025-10-17 00:00:30'),
(25, 4, 'Tủ Hồ Sơ Gỗ 3 Ngăn', 6200000, 'Lưu trữ tài liệu an toàn và ngăn nắp với khóa an toàn.', 'Gỗ MDF', '40cm x 50cm x 100cm', 'Khóa an toàn; Ray trượt êm; Chống ẩm', 'https://images.unsplash.com/photo-1634712282210-57a4f33d3423?q=80&w=800', 'OfficeSafe', 32, '2025-10-17 00:00:30'),
(26, 6, 'Gương Treo Tường Toàn Thân Viền Gỗ', 4800000, 'Gương phôi Bỉ cho hình ảnh trong và sắc nét, viền gỗ tự nhiên.', 'Gỗ sồi, Phôi Bỉ', '70cm x 170cm', 'Chống ố mốc; Hình ảnh sắc nét; Viền gỗ tự nhiên', 'https://images.unsplash.com/photo-1616627561958-856161ca1203?q=80&w=800', 'MirrorArt', 40, '2025-10-17 00:00:30'),
(27, 6, 'Đèn Sàn Cong Hiện Đại', 5200000, 'Đèn sàn hình vòng cung tạo điểm nhấn nghệ thuật cho góc đọc sách.', 'Thép sơn tĩnh điện', 'H200cm', 'Ánh sáng vàng ấm; Điều chỉnh độ sáng; Thiết kế hiện đại', 'https://images.unsplash.com/photo-1619432694356-f86a5a4155a6?q=80&w=800', 'LightArc', 23, '2025-10-17 00:00:30'),
(28, 6, 'Bộ Tranh Canvas Trừu Tượng', 3500000, 'Bộ 3 tranh canvas với gam màu hiện đại, thổi hồn nghệ thuật vào không gian.', 'Vải canvas, Khung composite', '50cm x 70cm (x3)', 'Màu sắc bền đẹp; Dễ treo lắp; Chống thấm nước', 'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?q=80&w=800', 'ArtHome', 50, '2025-10-17 00:00:30'),
(29, 3, 'Giường Ngủ Có Ngăn Kéo', 16200000, 'Tối ưu không gian lưu trữ với các ngăn kéo lớn bên dưới giường.', 'Gỗ MDF lõi xanh', '180cm x 200cm', 'Tiết kiệm không gian; Chống ẩm; Ray trượt giảm chấn', 'https://images.unsplash.com/photo-1595526114035-0d45ed16433d?q=80&w=800', 'StorageBed', 18, '2025-10-17 00:00:30'),
(30, 1, 'Sofa Đơn Vải Bố Bắc Âu', 6500000, 'Thiết kế đơn giản, màu sắc trung tính, phù hợp để đọc sách hoặc thư giãn.', 'Vải bố, Gỗ sồi', '80cm x 85cm x 90cm', 'Thoáng mát; Nệm ngồi êm ái; Phong cách Scandinavian', 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?q=80&w=800', 'NordicStyle', 22, '2025-10-17 00:00:30');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_images`
--

CREATE TABLE `product_images` (
  `ImageID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `ImageURL` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `product_images`
--

INSERT INTO `product_images` (`ImageID`, `ProductID`, `ImageURL`) VALUES
(1, 1, 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=800'),
(2, 1, 'https://images.unsplash.com/photo-1540574163024-58ea3f3b1b58?q=80&w=800'),
(3, 1, 'https://images.unsplash.com/photo-1493663284031-b7e3aefca38f?q=80&w=800'),
(4, 2, 'https://images.unsplash.com/photo-1592078615290-033ee584e267?q=80&w=800'),
(5, 2, 'https://images.unsplash.com/photo-1631679701835-2698c4421633?q=80&w=800'),
(6, 2, 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?q=80&w=800'),
(7, 3, 'https://images.unsplash.com/photo-1604578762246-41134e37f9cc?q=80&w=800'),
(8, 3, 'https://images.unsplash.com/photo-1519643381401-22c77e60520e?q=80&w=800'),
(9, 4, 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?q=80&w=800'),
(10, 4, 'https://images.unsplash.com/photo-1595526114035-0d45ed16433d?q=80&w=800'),
(11, 5, 'https://images.unsplash.com/photo-1615965511434-3111302157d7?q=80&w=800'),
(12, 6, 'https://images.unsplash.com/photo-1618220179428-22790b461013?q=80&w=800'),
(13, 7, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=800'),
(14, 8, 'https://images.unsplash.com/photo-1519643381401-22c77e60520e?q=80&w=800'),
(15, 9, 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc?q=80&w=800'),
(16, 10, 'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?q=80&w=800'),
(17, 11, 'https://images.unsplash.com/photo-1617806118233-5cf3b4681a8a?q=80&w=800'),
(18, 12, 'https://images.unsplash.com/photo-1600122425538-f86a5a4155a6?q=80&w=800'),
(19, 13, 'https://images.unsplash.com/photo-1615875605825-5eb9bb5fea38?q=80&w=800'),
(20, 14, 'https://images.unsplash.com/photo-1517400508447-f8a614948a25?q=80&w=800'),
(21, 15, 'https://images.unsplash.com/photo-1595526114035-0d45ed16433d?q=80&w=800'),
(22, 16, 'https://images.unsplash.com/photo-1598556138615-99f8487b412e?q=80&w=800'),
(23, 17, 'https://images.unsplash.com/photo-1594026112274-b3522f16143b?q=80&w=800'),
(24, 18, 'https://images.unsplash.com/photo-1633519946483-336a99b45a0b?q=80&w=800'),
(25, 19, 'https://images.unsplash.com/photo-1558153403-398588a91345?q=80&w=800'),
(26, 20, 'https://images.unsplash.com/photo-1618221617593-8439b1a03a74?q=80&w=800'),
(27, 21, 'https://images.unsplash.com/photo-1580489240954-5135aa32c589?q=80&w=800'),
(28, 22, 'https://images.unsplash.com/photo-1600122425538-f86a5a4155a6?q=80&w=800'),
(29, 23, 'https://images.unsplash.com/photo-1631679701835-2698c4421633?q=80&w=800'),
(30, 24, 'https://images.unsplash.com/photo-1575429199926-f78e02d90a61?q=80&w=800');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reviews`
--

CREATE TABLE `reviews` (
  `ReviewID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Rating` int(11) NOT NULL,
  `Comment` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `reviews`
--

INSERT INTO `reviews` (`ReviewID`, `ProductID`, `UserID`, `Rating`, `Comment`, `CreatedAt`) VALUES
(1, 1, 2, 5, 'Sofa rất đẹp, ngồi êm ái và sang trọng. Rất hài lòng!', '2025-10-17 00:03:19'),
(2, 3, 3, 5, 'Bộ bàn ăn chắc chắn, màu gỗ tự nhiên rất đẹp. Sẽ ủng hộ shop lần nữa.', '2025-10-17 00:03:19'),
(3, 2, 4, 4, 'Ghế ngồi thoải mái, tuy nhiên da hơi có mùi lúc mới mua.', '2025-10-17 00:03:19'),
(4, 4, 5, 5, 'Giường ngủ tuyệt vời, lắp đặt chuyên nghiệp. Cho shop 5 sao.', '2025-10-17 00:03:19'),
(5, 5, 6, 4, 'Kệ tivi đẹp, nhưng có một vết xước nhỏ ở góc. Shop đã hỗ trợ xử lý nhanh.', '2025-10-17 00:03:19'),
(6, 7, 7, 5, 'Ghế lười cực kỳ thoải mái, con tôi rất thích.', '2025-10-17 00:03:19'),
(7, 8, 8, 4, 'Bàn ăn đẹp, mặt đá dễ lau chùi. Giao hàng hơi trễ.', '2025-10-17 00:03:19'),
(8, 6, 9, 5, 'Tủ quần áo rộng rãi, thiết kế thông minh. Rất đáng tiền.', '2025-10-17 00:03:19'),
(9, 10, 10, 5, 'Đèn chùm lộng lẫy, phòng khách trở nên sang trọng hẳn.', '2025-10-17 00:03:19'),
(10, 9, 11, 4, 'Ghế ăn ngồi chắc chắn, nhưng màu sắc hơi đậm hơn so với ảnh.', '2025-10-17 00:03:19'),
(11, 12, 12, 5, 'Tủ bếp đa năng, tiện lợi, giúp bếp gọn gàng hơn nhiều.', '2025-10-17 00:03:19'),
(12, 11, 13, 5, 'Bàn ăn mở rộng rất tiện khi nhà có khách. Chất lượng tốt.', '2025-10-17 00:03:19'),
(13, 14, 14, 4, 'Bàn làm việc nâng hạ hoạt động mượt mà. Mặt bàn hơi dễ xước.', '2025-10-17 00:03:19'),
(14, 13, 15, 5, 'Giường tầng chắc chắn, bé nhà mình rất thích. Lắp ráp hơi khó.', '2025-10-17 00:03:19'),
(15, 16, 16, 5, 'Bàn trang điểm đẹp, gương LED sáng rõ. Rất hài lòng.', '2025-10-17 00:03:19'),
(16, 15, 17, 4, 'Giường kiểu Nhật đẹp, nhưng hơi thấp so với thói quen của tôi.', '2025-10-17 00:03:19'),
(17, 18, 18, 5, 'Tủ đầu giường rất thông minh, sạc không dây nhạy.', '2025-10-17 00:03:19'),
(18, 17, 19, 5, 'Sofa Chesterfield đúng là đẳng cấp, da thật rất đẹp.', '2025-10-17 00:03:19'),
(19, 20, 20, 4, 'Tủ giày gọn, nhưng chỉ để được giày dép size nhỏ.', '2025-10-17 00:03:19'),
(20, 19, 21, 5, 'Kệ sách đẹp, gỗ tự nhiên nên rất nặng và chắc chắn.', '2025-10-17 00:03:19'),
(21, 22, 22, 5, 'Tủ buffet rộng, chứa được rất nhiều đồ. Rất hữu ích.', '2025-10-17 00:03:19'),
(22, 21, 23, 5, 'Ghế công thái học ngồi rất thoải mái, không bị đau lưng nữa.', '2025-10-17 00:03:19'),
(23, 24, 24, 4, 'Thảm đẹp, mềm mại. Hơi khó vệ sinh.', '2025-10-17 00:03:19'),
(24, 23, 25, 5, 'Ghế Papasan ngồi thư giãn đọc sách rất tuyệt.', '2025-10-17 00:03:19'),
(25, 26, 26, 5, 'Gương soi rất nét, không bị ảo. Viền gỗ đẹp.', '2025-10-17 00:03:19'),
(26, 25, 27, 4, 'Tủ hồ sơ ổn, nhưng khóa kéo hơi rít.', '2025-10-17 00:03:19'),
(27, 28, 28, 5, 'Bộ tranh đẹp, làm sáng bừng cả căn phòng.', '2025-10-17 00:03:19'),
(28, 27, 29, 5, 'Đèn sàn đẹp, ánh sáng dịu mắt. Rất thích hợp để đọc sách.', '2025-10-17 00:03:19'),
(29, 30, 30, 4, 'Sofa đơn đẹp, nhưng nệm ngồi hơi cứng.', '2025-10-17 00:03:19'),
(30, 29, 1, 5, 'Giường có ngăn kéo rất tiện, giúp phòng ngủ gọn gàng hơn.', '2025-10-17 00:03:19');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Role` varchar(20) NOT NULL DEFAULT 'Customer',
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`UserID`, `FullName`, `Email`, `PasswordHash`, `Phone`, `Address`, `Role`, `CreatedAt`) VALUES
(1, 'Đỗ Công Minh', 'minh.do@furnishop.vn', 'admin123', '0911111111', '10 Lý Thường Kiệt, Hoàn Kiếm, Hà Nội', 'Admin', '2025-10-17 00:00:30'),
(2, 'Lý Ngọc Long', 'long.ly@example.com', 'user123', '0922222222', '20 Hai Bà Trưng, Quận 1, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(3, 'Nguyễn Hữu Lương', 'luong.nguyen@example.com', 'user123', '0933333333', '30 Trần Phú, Hải Châu, Đà Nẵng', 'Customer', '2025-10-17 00:00:30'),
(4, 'Đặng Đình Thế Hiếu', 'hieu.dang@example.com', 'user123', '0944444444', '40 Hùng Vương, Ninh Kiều, Cần Thơ', 'Customer', '2025-10-17 00:00:30'),
(5, 'Trần Văn An', 'an.tran@example.com', 'user123', '0955555555', '50 Nguyễn Văn Cừ, Long Biên, Hà Nội', 'Customer', '2025-10-17 00:00:30'),
(6, 'Lê Thị Bình', 'binh.le@example.com', 'user123', '0966666666', '60 Võ Văn Tần, Quận 3, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(7, 'Phạm Minh Cường', 'cuong.pham@example.com', 'user123', '0977777777', '70 Lê Duẩn, Thanh Khê, Đà Nẵng', 'Customer', '2025-10-17 00:00:30'),
(8, 'Võ Ngọc Dung', 'dung.vo@example.com', 'user123', '0988888888', '80 Hòa Bình, Ninh Kiều, Cần Thơ', 'Customer', '2025-10-17 00:00:30'),
(9, 'Hoàng Văn Giang', 'giang.hoang@example.com', 'user123', '0999999999', '90 Láng Hạ, Đống Đa, Hà Nội', 'Customer', '2025-10-17 00:00:30'),
(10, 'Ngô Thị Hạnh', 'hanh.ngo@example.com', 'user123', '0912121212', '100 Nam Kỳ Khởi Nghĩa, Quận 1, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(11, 'Đinh Quang Huy', 'huy.dinh@example.com', 'user123', '0913131313', '110 Cầu Giấy, Cầu Giấy, Hà Nội', 'Customer', '2025-10-17 00:00:30'),
(12, 'Bùi Khánh Linh', 'linh.bui@example.com', 'user123', '0914141414', '120 Nguyễn Chí Thanh, Quận 5, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(13, 'Mai Thế Nhân', 'nhan.mai@example.com', 'user123', '0915151515', '130 Điện Biên Phủ, Bình Thạnh, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(14, 'Dương Quốc Oai', 'oai.duong@example.com', 'user123', '0916161616', '140 Xô Viết Nghệ Tĩnh, Bình Thạnh, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(15, 'Trịnh Thị Quỳnh', 'quynh.trinh@example.com', 'user123', '0917171717', '150 Phan Xích Long, Phú Nhuận, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(16, 'Hà Văn Sơn', 'son.ha@example.com', 'user123', '0918181818', '160 Lý Chính Thắng, Quận 3, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(17, 'Lưu Thúy Vy', 'vy.luu@example.com', 'user123', '0919191919', '170 Võ Thị Sáu, Quận 3, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(18, 'Nguyễn Anh Tuấn', 'tuan.nguyen@example.com', 'user123', '0920202020', '180 Pasteur, Quận 1, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(19, 'Phan Thị Thảo', 'thao.phan@example.com', 'user123', '0921212121', '190 Lê Thánh Tôn, Quận 1, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(20, 'Vũ Đức Thắng', 'thang.vu@example.com', 'user123', '0922222222', '200 Đồng Khởi, Quận 1, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(21, 'Đào Minh Tâm', 'tam.dao@example.com', 'user123', '0923232323', '210 Nguyễn Thị Minh Khai, Quận 1, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(22, 'Lại Văn Sâm', 'sam.lai@example.com', 'user123', '0924242424', '220 Trương Định, Quận 3, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(23, 'Tạ Bích Loan', 'loan.ta@example.com', 'user123', '0925252525', '230 Bà Huyện Thanh Quan, Quận 3, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(24, 'Diệp Chi', 'chi.diep@example.com', 'user123', '0926262626', '240 Sư Vạn Hạnh, Quận 10, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(25, 'Khánh Vy', 'vy.khanh@example.com', 'user123', '0927272727', '250 Thành Thái, Quận 10, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(26, 'Trấn Thành', 'thanh.tran@example.com', 'user123', '0928282828', '260 Tô Hiến Thành, Quận 10, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(27, 'Trường Giang', 'giang.truong@example.com', 'user123', '0929292929', '270 3 Tháng 2, Quận 10, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(28, 'Hari Won', 'won.hari@example.com', 'user123', '0930303030', '280 Lý Thường Kiệt, Quận 11, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(29, 'Thu Trang', 'trang.thu@example.com', 'user123', '0931313131', '290 Lạc Long Quân, Quận 11, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(30, 'Tiến Luật', 'luat.tien@example.com', 'user123', '0932323232', '300 Âu Cơ, Tân Bình, TP.HCM', 'Customer', '2025-10-17 00:00:30'),
(31, 'Đỗ Công Minh', 'mdang2186@gmail.com', 'minh', NULL, NULL, 'Customer', '2025-10-17 00:29:32');

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
  ADD KEY `FK_Contacts_Users` (`UserID`);

--
-- Chỉ mục cho bảng `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`OrderItemID`),
  ADD KEY `FK_OrderItems_Orders` (`OrderID`),
  ADD KEY `FK_OrderItems_Products` (`ProductID`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `FK_Orders_Users` (`UserID`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `FK_Products_Categories` (`CategoryID`);

--
-- Chỉ mục cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`ImageID`),
  ADD KEY `FK_Images_Products` (`ProductID`);

--
-- Chỉ mục cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`ReviewID`),
  ADD UNIQUE KEY `UQ_Review_Product_User` (`ProductID`,`UserID`),
  ADD KEY `FK_Reviews_Users` (`UserID`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `contacts`
--
ALTER TABLE `contacts`
  MODIFY `ContactID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `OrderItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `ProductID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `product_images`
--
ALTER TABLE `product_images`
  MODIFY `ImageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `reviews`
--
ALTER TABLE `reviews`
  MODIFY `ReviewID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `FK_Contacts_Users` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Các ràng buộc cho bảng `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `FK_OrderItems_Orders` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  ADD CONSTRAINT `FK_OrderItems_Products` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_Orders_Users` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FK_Products_Categories` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`);

--
-- Các ràng buộc cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `FK_Images_Products` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `FK_Reviews_Products` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
  ADD CONSTRAINT `FK_Reviews_Users` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
