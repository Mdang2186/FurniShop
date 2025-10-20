package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.User;

@WebServlet(name = "OrderHistoryController", urlPatterns = {"/orders"})
public class OrderHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        // Yêu cầu đăng nhập
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orderList = orderDAO.getOrdersByUserIdWithDetails(user.getUserID());
            request.setAttribute("orderList", orderList);
            request.getRequestDispatcher("orders.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("OrderHistoryController doGet Error: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }
    
    // doPost có thể được dùng để xử lý các hành động như hủy đơn hàng trong tương lai
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}