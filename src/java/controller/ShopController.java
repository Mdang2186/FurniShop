package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Product;

@WebServlet(name = "ShopController", urlPatterns = {"/shop"})
public class ShopController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO pdao = new ProductDAO();
        CategoryDAO cdao = new CategoryDAO();

        // Lấy các tham số từ URL
        String keyword = request.getParameter("keyword");
        String categoryId_raw = request.getParameter("cid");
        String sortBy = request.getParameter("sort");

        // Chuẩn bị danh sách category ID để lọc
        List<Integer> categoryIds = new ArrayList<>();
        if (categoryId_raw != null && !categoryId_raw.isEmpty()) {
            try {
                categoryIds.add(Integer.parseInt(categoryId_raw));
            } catch (NumberFormatException e) {
                // Bỏ qua nếu cid không phải là số
                System.out.println("Invalid category ID format: " + categoryId_raw);
            }
        }
        
        // Đặt giá trị mặc định cho sắp xếp nếu không có
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "newest"; 
        }

        // Gọi phương thức lọc và tìm kiếm duy nhất
        List<Product> productList = pdao.searchAndFilterProducts(keyword, categoryIds, 0, 0, sortBy);
        
        // Lấy tất cả danh mục để hiển thị trên sidebar
        List<Category> categoryList = cdao.getAllCategories();
        
        // Đặt các thuộc tính vào request để JSP có thể truy cập
        request.setAttribute("products", productList);
        request.setAttribute("categories", categoryList);
        
        // Giữ lại giá trị lọc để hiển thị lại trên form
        request.setAttribute("selectedCid", categoryId_raw);
        request.setAttribute("keyword", keyword);
        request.setAttribute("sortBy", sortBy);
        
        // Chuyển tiếp đến trang JSP
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }
}