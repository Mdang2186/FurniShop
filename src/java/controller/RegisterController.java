package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập mã hóa ký tự cho cả request và response
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re_password");

        // Kiểm tra mật khẩu có khớp không
        if (!password.equals(re_password)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return; // Dừng xử lý
        }
        
        // Kiểm tra email đã tồn tại chưa
        UserDAO udao = new UserDAO();
        if (udao.checkEmailExists(email)) {
            request.setAttribute("error", "Email này đã được sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return; // Dừng xử lý
        }
        
        // Mọi thứ hợp lệ, tiến hành đăng ký
        try {
            // LƯU Ý BẢO MẬT: Trong thực tế, bạn phải mã hóa mật khẩu ở đây trước khi lưu.
            // Ví dụ: String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
            udao.registerUser(fullName, email, password); // Tạm thời dùng mật khẩu thô
            
            // Chuyển hướng về trang đăng nhập với thông báo thành công
            request.setAttribute("success", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("RegisterController doPost Error: " + e.getMessage());
            request.setAttribute("error", "Đã có lỗi xảy ra trong quá trình đăng ký.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}