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
import org.mindrot.jbcrypt.BCrypt; // <-- THÊM IMPORT NÀY

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // Mật khẩu người dùng gõ vào

        UserDAO userDAO = new UserDAO();
        
        // Lấy user từ CSDL bằng email
        User user = userDAO.getUserByEmail(email);

        // === THAY ĐỔI CÁCH KIỂM TRA MẬT KHẨU ===
        
        // 1. Kiểm tra xem user có tồn tại không
        // 2. Dùng BCrypt.checkpw để so sánh mật khẩu gõ vào với mật khẩu đã mã hóa trong DB
        if (user != null && BCrypt.checkpw(password, user.getPasswordHash())) {
            
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("account", user);
            response.sendRedirect("home"); // Chuyển về trang chủ
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Email hoặc mật khẩu không đúng.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        // ======================================
    }
}