// File: controller/HomeController.java
package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "HomeController", urlPatterns = {"/home", ""})
public class HomeController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO pdao = new ProductDAO();
        // Lấy 8 sản phẩm mới nhất để hiển thị
        request.setAttribute("products", pdao.searchAndFilterProducts(null, new ArrayList<>(), 0, 0, "newest"));
        
        // Dòng này phải trỏ đến tệp "home.jsp"
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}