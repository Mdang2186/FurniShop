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

@WebServlet(name = "HomeController", urlPatterns = {"/home", ""})
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đảm bảo ký tự tiếng Việt hiển thị chính xác
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            ProductDAO pdao = new ProductDAO();
            // Lấy 8 sản phẩm mới nhất để hiển thị trên trang chủ
            List<Product> products = pdao.searchAndFilterProducts(null, new ArrayList<>(), 0, 0, "newest");
            
            request.setAttribute("products", products);
            request.getRequestDispatcher("home.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Ghi lại lỗi để dễ dàng gỡ rối
            System.out.println("HomeController doGet Error: " + e.getMessage());
            // Có thể chuyển hướng đến một trang lỗi chung
            response.sendRedirect("error.jsp"); 
        }
    }
}