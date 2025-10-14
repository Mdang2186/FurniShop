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

    // Hiển thị form đăng ký
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    // Xử lý dữ liệu từ form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Hỗ trợ tiếng Việt
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re_password");

        if (!password.equals(re_password)) {
            // Nếu mật khẩu không khớp
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            UserDAO udao = new UserDAO();
            if (udao.checkEmailExists(email)) {
                // Nếu email đã tồn tại
                request.setAttribute("error", "Email đã được sử dụng!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                // Mọi thứ hợp lệ, tiến hành đăng ký
                // LƯU Ý: Trong thực tế, bạn phải mã hóa mật khẩu ở đây
                // Ví dụ: String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                // Ở đây ta tạm dùng mật khẩu thô để demo
                udao.registerUser(fullName, email, password);
                
                // Gửi thông báo thành công và chuyển hướng về trang đăng nhập
                request.setAttribute("success", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
}