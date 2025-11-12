package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import model.Order;
import model.User;

@WebServlet(name = "OrderHistoryController", urlPatterns = {"/orders"})
public class OrderHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("account");
        String ctx = request.getContextPath();

        // ÉP ĐĂNG NHẬP + LƯU RETURN URL
        if (user == null) {
            session.setAttribute("returnUrl", "/orders");
            response.sendRedirect(ctx + "/login");
            return;
        }

        try {
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orderList = orderDAO.getOrdersByUserIdWithDetails(user.getUserID());
            request.setAttribute("orderList", orderList);
            request.getRequestDispatcher("orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không tải được lịch sử đơn hàng. Vui lòng thử lại sau.");
            request.setAttribute("orderList", Collections.emptyList());
            request.getRequestDispatcher("orders.jsp").forward(request, response);
        }
    }

    // Sau này có hủy đơn… vẫn dùng GET để hiển thị lại
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
