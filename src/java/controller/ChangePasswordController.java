package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ChangePasswordController", urlPatterns = {"/change-password"})
public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDAO userDAO = new UserDAO();

        User currentUser = (User) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String re_newPassword = request.getParameter("re_newPassword");

        if (!currentUser.getPasswordHash().equals(oldPassword)) {
            request.setAttribute("error", "Mật khẩu cũ không chính xác!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(re_newPassword)) {
            request.setAttribute("error", "Mật khẩu mới không khớp!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        if (oldPassword.equals(newPassword)) {
            request.setAttribute("error", "Mật khẩu mới không được trùng với mật khẩu cũ!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        boolean success = userDAO.updatePasswordByID(currentUser.getUserID(), newPassword);

        if (success) {
            currentUser.setPasswordHash(newPassword);
            session.setAttribute("account", currentUser);

            request.setAttribute("success", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("error", "Đã có lỗi xảy ra, vui lòng thử lại.");
        }

        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }
}
