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

    // Đặt số lượng sản phẩm mỗi trang ở đây
    private static final int ITEMS_PER_PAGE = 9;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO pdao = new ProductDAO();
        CategoryDAO cdao = new CategoryDAO();

        // Lấy các tham số lọc, tìm kiếm VÀ trang
        String keyword = request.getParameter("keyword");
        String categoryId_raw = request.getParameter("cid");
        String sortBy = request.getParameter("sort");
        String page_raw = request.getParameter("page"); // <-- Lấy tham số trang

        // Chuẩn bị danh sách category ID để lọc
        List<Integer> categoryIds = new ArrayList<>();
        if (categoryId_raw != null && !categoryId_raw.isEmpty() && !categoryId_raw.equals("all")) {
            try {
                categoryIds.add(Integer.parseInt(categoryId_raw));
            } catch (NumberFormatException e) {
                System.out.println("Invalid category ID format: " + categoryId_raw);
            }
        }
        
        // Đặt giá trị sắp xếp mặc định
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "newest"; 
        }

        // === BẮT ĐẦU LOGIC PHÂN TRANG ===
        
        // 1. Xử lý trang hiện tại
        int currentPage = 1;
        if (page_raw != null) {
            try {
                currentPage = Integer.parseInt(page_raw);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid page format: " + page_raw);
                currentPage = 1;
            }
        }

        // 2. Lấy tổng số sản phẩm (từ phương thức DAO mới)
        int totalItems = pdao.countProducts(keyword, categoryIds, 0, 0);

        // 3. Tính toán tổng số trang
        int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
        
        // Đảm bảo trang hiện tại không vượt quá tổng số trang
        if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }

        // 4. Tính toán offset
        int offset = (currentPage - 1) * ITEMS_PER_PAGE;
        
        // === KẾT THÚC LOGIC PHÂN TRANG ===


        // Gọi phương thức DAO đã sửa đổi (với offset và itemsPerPage)
        List<Product> productList = pdao.searchAndFilterProducts(keyword, categoryIds, 0, 0, sortBy, offset, ITEMS_PER_PAGE);
        
        // Lấy tất cả danh mục để hiển thị trên bộ lọc
        List<Category> categoryList = cdao.getAllCategories();
        
        // Đặt các thuộc tính vào request để JSP có thể truy cập
        request.setAttribute("products", productList);
        request.setAttribute("categories", categoryList);
        
        // Gửi lại các giá trị đã chọn
        request.setAttribute("selectedCid", categoryId_raw);
        request.setAttribute("keywordValue", keyword);
        request.setAttribute("sortByValue", sortBy);
        
        // Gửi thông tin phân trang sang JSP
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        
        // Chuyển tiếp đến trang JSP
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }
}