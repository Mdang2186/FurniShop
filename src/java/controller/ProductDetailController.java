package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Product;

@WebServlet(name = "ProductDetailController", urlPatterns = {"/product-detail"})
public class ProductDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            int productId = Integer.parseInt(request.getParameter("pid"));
            ProductDAO pdao = new ProductDAO();
            Product product = pdao.getProductByID(productId);
            
            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("product-detail.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy sản phẩm, thông báo lỗi và chuyển hướng
                request.setAttribute("error", "Sản phẩm không tồn tại.");
                request.getRequestDispatcher("shop").forward(request, response);
            }
        } catch (NumberFormatException e) {
            // Nếu pid không phải là số, chuyển hướng về cửa hàng
            response.sendRedirect("shop");
        } catch (Exception e) {
            System.out.println("ProductDetailController doGet Error: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }
}