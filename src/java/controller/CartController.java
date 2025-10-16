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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "view"; // Mặc định là xem giỏ hàng
        }

        try {
            switch (action) {
                case "add":
                    addToCart(request, cart);
                    response.sendRedirect("cart");
                    break;
                case "update":
                    updateCart(request, cart);
                    response.sendRedirect("cart");
                    break;
                case "remove":
                    removeFromCart(request, cart);
                    response.sendRedirect("cart");
                    break;
                default: // "view"
                    calculateCartTotals(session, cart);
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            response.sendRedirect("shop");
        }
        
        // Lưu lại giỏ hàng vào session sau mỗi hành động
        session.setAttribute("cart", cart);
        calculateCartTotals(session, cart); // Cập nhật lại tổng tiền và số lượng
    }

    private void addToCart(HttpServletRequest request, List<CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("pid"));
        int quantity = request.getParameter("quantity") != null ? Integer.parseInt(request.getParameter("quantity")) : 1;

        for (CartItem item : cart) {
            if (item.getProduct().getProductID() == productId) {
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        
        Product product = new ProductDAO().getProductByID(productId);
        if (product != null) {
            cart.add(new CartItem(product, quantity));
        }
    }

    private void updateCart(HttpServletRequest request, List<CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("pid"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

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

    private void removeFromCart(HttpServletRequest request, List<CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("pid"));
        cart.removeIf(item -> item.getProduct().getProductID() == productId);
    }

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