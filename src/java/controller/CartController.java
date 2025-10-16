package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.Product;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    /**
     * Xử lý tất cả các yêu cầu GET và POST đến /cart.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // Lấy giỏ hàng từ session, nếu chưa có thì tạo mới
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Xác định hành động người dùng muốn thực hiện (thêm, xóa, xem...)
        String action = request.getParameter("action");
        if (action == null) {
            action = "view"; // Mặc định là hiển thị giỏ hàng
        }

        try {
            switch (action) {
                case "add":
                    addToCart(request, cart);
                    // Chuyển hướng để tránh người dùng nhấn F5 và thêm lại sản phẩm
                    response.sendRedirect("cart");
                    return; // Dừng xử lý tại đây
                case "update":
                    updateCart(request, cart);
                    response.sendRedirect("cart");
                    return;
                case "remove":
                    removeFromCart(request, cart);
                    response.sendRedirect("cart");
                    return;
                case "view":
                default:
                    // Hiển thị trang giỏ hàng
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            System.out.println("CartController Error: " + e.getMessage());
            response.sendRedirect("shop"); // Nếu có lỗi, chuyển về trang cửa hàng
        } finally {
            // Sau mỗi hành động, cập nhật lại giỏ hàng và tính toán tổng số tiền
            session.setAttribute("cart", cart);
            calculateCartTotals(session, cart);
        }
    }

    /**
     * Thêm một sản phẩm vào giỏ hàng.
     */
    private void addToCart(HttpServletRequest request, List<CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("pid"));
        int quantity = request.getParameter("quantity") != null ? Integer.parseInt(request.getParameter("quantity")) : 1;

        // Nếu sản phẩm đã có, chỉ tăng số lượng
        for (CartItem item : cart) {
            if (item.getProduct().getProductID() == productId) {
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        
        // Nếu sản phẩm chưa có, tạo mới và thêm vào giỏ
        Product product = new ProductDAO().getProductByID(productId);
        if (product != null) {
            cart.add(new CartItem(product, quantity));
        }
    }

    /**
     * Cập nhật số lượng của một sản phẩm trong giỏ hàng.
     */
    private void updateCart(HttpServletRequest request, List<CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("pid"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Nếu số lượng <= 0, xóa sản phẩm khỏi giỏ
        if (quantity <= 0) {
            cart.removeIf(item -> item.getProduct().getProductID() == productId);
        } else {
            for (CartItem item : cart) {
                if (item.getProduct().getProductID() == productId) {
                    item.setQuantity(quantity);
                    break;
                }
            }
        }
    }

    /**
     * Xóa một sản phẩm khỏi giỏ hàng.
     */
    private void removeFromCart(HttpServletRequest request, List<CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("pid"));
        cart.removeIf(item -> item.getProduct().getProductID() == productId);
    }

    /**
     * Tính toán tổng số lượng và tổng giá trị của giỏ hàng, sau đó lưu vào session.
     */
    private void calculateCartTotals(HttpSession session, List<CartItem> cart) {
        double totalAmount = 0;
        int totalItems = 0;
        for (CartItem item : cart) {
            totalAmount += item.getTotalPrice();
            totalItems += item.getQuantity();
        }
        session.setAttribute("totalAmount", totalAmount);
        session.setAttribute("cartSize", totalItems);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}