package controller;

import dal.OrderDAO;
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
import model.Order;
import model.OrderItem;
import model.User;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        String note = request.getParameter("note");
        
        Order order = new Order();
        order.setUserID(user.getUserID());
        order.setTotalAmount((Double) session.getAttribute("totalAmount"));
        order.setShippingAddress(address);
        order.setPaymentMethod(paymentMethod);
        order.setNote(note);
        
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cItem : cart) {
            OrderItem oItem = new OrderItem();
            oItem.setProductID(cItem.getProduct().getProductID());
            oItem.setQuantity(cItem.getQuantity());
            oItem.setUnitPrice(cItem.getProduct().getPrice());
            orderItems.add(oItem);
        }
        order.setItems(orderItems);
        
        OrderDAO orderDAO = new OrderDAO();
        boolean success = orderDAO.createOrder(order);
        
        if(success) {
            session.removeAttribute("cart");
            session.removeAttribute("cartSize");
            session.removeAttribute("totalAmount");
            
            request.setAttribute("message", "Đặt hàng thành công! Cảm ơn bạn đã mua sắm.");
            request.getRequestDispatcher("orders").forward(request, response);
        } else {
            request.setAttribute("error", "Đã có lỗi xảy ra khi xử lý đơn hàng. Vui lòng thử lại.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}