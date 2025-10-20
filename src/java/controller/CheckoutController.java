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

    /**
     * Hiển thị trang thanh toán.
     * Kiểm tra các điều kiện: người dùng phải đăng nhập và giỏ hàng không được rỗng.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // Bắt buộc đăng nhập để đặt hàng
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Không cho phép vào trang thanh toán nếu giỏ hàng trống
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        // Mọi thứ hợp lệ, hiển thị trang checkout
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    /**
     * Xử lý việc xác nhận đơn hàng.
     * Lấy thông tin từ form, tạo đối tượng Order và lưu vào cơ sở dữ liệu.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        
        User user = (User) session.getAttribute("account");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        // Kiểm tra lại các điều kiện an toàn
        if (user == null || cart == null || cart.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        try {
            // Lấy thông tin từ form
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String paymentMethod = request.getParameter("paymentMethod");
            String note = request.getParameter("note");
            
            // Tạo đối tượng Order từ thông tin thu thập được
            Order order = new Order();
            order.setUserID(user.getUserID());
            order.setTotalAmount((Double) session.getAttribute("totalAmount"));
            // Kết hợp thông tin người nhận vào địa chỉ để lưu trữ
            String shippingInfo = String.format("%s - %s, %s", fullName, phone, address);
            order.setShippingAddress(shippingInfo);
            order.setPaymentMethod(paymentMethod);
            order.setNote(note);

            // Chuyển đổi các CartItem trong giỏ hàng thành OrderItem
            List<OrderItem> orderItems = new ArrayList<>();
            for (CartItem cItem : cart) {
                OrderItem oItem = new OrderItem();
                oItem.setProductID(cItem.getProduct().getProductID());
                oItem.setQuantity(cItem.getQuantity());
                oItem.setUnitPrice(cItem.getProduct().getPrice());
                orderItems.add(oItem);
            }
            order.setItems(orderItems);
            
            // Gọi DAO để thực hiện lưu đơn hàng vào CSDL
            OrderDAO orderDAO = new OrderDAO();
            boolean success = orderDAO.createOrder(order);
            
            if(success) {
                // Xóa giỏ hàng khỏi session sau khi đặt hàng thành công
                session.removeAttribute("cart");
                session.removeAttribute("cartSize");
                session.removeAttribute("totalAmount");
                
                // Gửi thông báo và chuyển hướng đến trang lịch sử đơn hàng
                request.setAttribute("message", "Đặt hàng thành công! Cảm ơn bạn đã mua sắm tại Furni Shop.");
                request.getRequestDispatcher("orders").forward(request, response);
            } else {
                // Nếu có lỗi, hiển thị lại trang checkout với thông báo lỗi
                request.setAttribute("error", "Đã có lỗi xảy ra khi xử lý đơn hàng. Vui lòng thử lại.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("CheckoutController doPost Error: " + e.getMessage());
            request.setAttribute("error", "Hệ thống đã gặp lỗi. Xin lỗi vì sự bất tiện này.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}