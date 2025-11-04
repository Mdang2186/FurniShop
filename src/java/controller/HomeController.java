package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

@WebServlet(name = "HomeController", urlPatterns = {"/home", ""}) // Ánh xạ cả /home và trang gốc
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Đảm bảo ký tự tiếng Việt hiển thị chính xác
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            ProductDAO pdao = new ProductDAO();
            
            // TỐI ƯU: Chỉ lấy 8 sản phẩm mới nhất cho trang chủ
            // Sử dụng phương thức searchAndFilterProducts đã cập nhật với phân trang
            int offset = 0; // Bắt đầu từ sản phẩm đầu tiên
            int itemsPerPage = 8; // Chỉ lấy 8 sản phẩm
            
            List<Product> products = pdao.searchAndFilterProducts(
                    null,            // keyword (không có)
                    new ArrayList<>(), // categoryIds (không có)
                    0,               // minPrice
                    0,               // maxPrice
                    "newest",        // sortBy (mới nhất)
                    offset,          // offset (bắt đầu từ 0)
                    itemsPerPage     // itemsPerPage (giới hạn 8)
            );
            
            // Gửi danh sách sản phẩm (chỉ 8 sản phẩm) sang home.jsp
            request.setAttribute("products", products);
            request.getRequestDispatcher("home.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Ghi lại lỗi để dễ dàng gỡ rối
            System.out.println("HomeController doGet Error: " + e.getMessage());
            // Có thể chuyển hướng đến một trang lỗi chung
            response.sendRedirect("error.jsp"); 
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thông thường trang chủ không xử lý POST, nhưng để an toàn,
        // bạn có thể cho nó gọi doGet
        doGet(request, response);
    }
}