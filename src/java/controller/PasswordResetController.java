package controller;

import Utils.EmailService;
import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "PasswordResetController", urlPatterns = {"/password-reset"})
public class PasswordResetController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        UserDAO userDAO = new UserDAO();
        EmailService emailService = new EmailService();

        if ("send-code".equals(action)) {
            String email = request.getParameter("email");
            User user = userDAO.getUserByEmail(email);

            if (user != null) {
                String code = String.format("%06d", new Random().nextInt(999999));
                session.setAttribute("verificationCode", code);
                session.setAttribute("emailToReset", email);

                String subject = "Your Password Reset Code";
                String body = "<h1>Password Reset</h1><p>Your verification code is: <b>" + code + "</b></p>";
                emailService.sendVerificationCode(email, subject, body);

                response.sendRedirect("verify-code.jsp");
            } else {
                request.setAttribute("error", "Email không tồn tại trong hệ thống.");
                request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            }
  
        } else if ("verify-and-reset".equals(action)) {
            String userCode = request.getParameter("code");
            String newPassword = request.getParameter("newPassword");
            
            String sessionCode = (String) session.getAttribute("verificationCode");
            String email = (String) session.getAttribute("emailToReset");

            if (sessionCode != null && sessionCode.equals(userCode)) {
                userDAO.updatePasswordByEmail(email, newPassword);
                session.removeAttribute("verificationCode");
                session.removeAttribute("emailToReset");
                request.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Mã xác thực không đúng.");
                request.getRequestDispatcher("verify-code.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("forgot-password.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}