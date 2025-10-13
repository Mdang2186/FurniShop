# FurniShop
Dự Án Website Bán Đồ Nội Thất - FurniShop (Nhóm 2)Đây là kho chứa mã nguồn cho dự án website bán hàng trực tuyến "FurniShop", được xây dựng trong khuôn khổ bài tập lớn môn Thiết kế Web. Dự án bao gồm đầy đủ các chức năng cơ bản của một trang thương mại điện tử, với giao diện dành cho người dùng và trang quản trị dành cho admin.👥 Thành Viên & Vai TròSTTHọ và TênNgày SinhVai Trò Chính1Đỗ Công Minh29/10/2004Team Leader, Frontend Dev, UI/UX Designer2Đặng Đình Thế Hiếu17/10/2004Fullstack Dev (Frontend & Backend)3Lý Ngọc Long14/02/2003Backend Dev, Database Manager4Nguyễn Hữu Lương28/03/2004Backend Dev, Tester🚀 Công Nghệ Sử DụngNgôn ngữ: Java (Servlet)Giao diện: JSP (JavaServer Pages), JSTLFrontend: HTML5, CSS3, JavaScript (ES6), Bootstrap 5Backend: Apache Tomcat 9.0Cơ sở dữ liệu: Microsoft SQL ServerCông cụ Build: Apache Ant (Quản lý thư viện thủ công)IDE: Apache NetBeans🛠️ Hướng Dẫn Cài Đặt và Chạy Dự ÁnPhần này giữ nguyên, dành cho thành viên mới hoặc khi cần cài đặt lại môi trường.Clone Repository:git clone [https://github.com/Mdang2186/FurniShop.git](https://github.com/Mdang2186/FurniShop.git)
Mở Dự Án trong NetBeans:Vào File -> Open Project... và trỏ đến thư mục FurniShop bạn vừa clone về.Cấu Hình Cơ Sở Dữ Liệu:Mở SQL Server Management Studio (SSMS).Thực thi file database_schema.sql để tạo database và dữ liệu mẫu.Mở file src/main/java/com/furniture/util/DBContext.java và cập nhật chuỗi kết nối cho đúng với cấu hình SQL Server của bạn.Thêm Thư Viện (JAR Files):Chuột phải vào thư mục Libraries -> Add JAR/Folder....Thêm các file JAR cần thiết (JDBC Driver, JSTL API & IMPL).Build và Chạy:Chuột phải vào dự án -> Clean and Build, sau đó Run.📖 Hướng Dẫn Làm Việc & Đóng Góp Của NhómĐây là phần quan trọng nhất, tất cả thành viên cần đọc kỹ và tuân thủ để đảm bảo quy trình làm việc hiệu quả.1. Cấu Trúc Nhánh (Branching Strategy) - CẬP NHẬTChúng ta sẽ sử dụng 3 cấp độ nhánh:main: Nhánh ổn định nhất, chỉ chứa code đã hoàn thiện và sẵn sàng để "phát hành".develop: Nhánh phát triển chính. Đây là nơi tích hợp code của cả nhóm sau khi đã được test.Nhánh cá nhân (dev-<tên>): Mỗi thành viên sẽ có một nhánh riêng để làm việc. Đây là "khu vực" của bạn, mọi chức năng mới sẽ được code tại đây trước khi yêu cầu gộp vào develop.dev-minhdev-hieudev-longdev-luong2. Hướng Dẫn Thiết Lập Ban Đầu (Dành cho Team Leader)Bạn Minh (Leader) sẽ thực hiện các lệnh sau một lần duy nhất để tạo môi trường làm việc cho cả nhóm.Tạo và đẩy nhánh develop:git checkout main
git pull origin main
git checkout -b develop
git push origin develop
Tạo và đẩy các nhánh cá nhân từ develop:# Tạo nhánh cho Minh
git checkout -b dev-minh
git push origin dev-minh

# Tạo nhánh cho Hiếu
git checkout -b dev-hieu
git push origin dev-hieu

# Tạo nhánh cho Long
git checkout -b dev-long
git push origin dev-long

# Tạo nhánh cho Lương
git checkout -b dev-luong
git push origin dev-luong

# Quay trở lại nhánh develop để kết thúc
git checkout develop
3. Luồng Công Việc Hàng Ngày (Dành cho tất cả thành viên)Đây là quy trình chuẩn khi bạn bắt đầu làm một nhiệm vụ mới.Ví dụ: Minh được giao nhiệm vụ làm giao diện trang chủ.Chuyển sang nhánh cá nhân của bạn:git checkout dev-minh
Cập nhật nhánh của bạn với code mới nhất từ develop:Đây là bước CỰC KỲ QUAN TRỌNG để tránh xung đột code.git pull origin develop
Bắt đầu lập trình:Bây giờ, nhánh dev-minh của bạn đã có đầy đủ code mới nhất. Hãy bắt đầu code chức năng được giao.Commit các thay đổi thường xuyên:Sau khi hoàn thành một phần nhỏ, hãy commit lại.git add .
git commit -m "Style: Hoan thien phan header trang chu"
Đẩy code lên nhánh cá nhân của bạn:Khi bạn đã làm xong hoặc cuối ngày làm việc, hãy đẩy code lên GitHub để lưu trữ.git push origin dev-minh
