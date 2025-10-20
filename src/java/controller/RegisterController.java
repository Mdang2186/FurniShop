package controller;

import Utils.EmailService;
import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.util.Date;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        UserDAO udao = new UserDAO();

        // --- XỬ LÝ KHI NGƯỜI DÙNG NHẤN "ĐĂNG KÝ" ---
        if ("register".equals(action)) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String re_password = request.getParameter("re_password");

            // Giữ lại các bước kiểm tra cũ của bạn
            if (!password.equals(re_password)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (udao.checkEmailExists(email)) {
                request.setAttribute("error", "Email này đã được sử dụng!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            // --- THAY ĐỔI LOGIC TỪ ĐÂY ---
            // Thay vì lưu vào DB, chúng ta sẽ lưu tạm vào session và gửi email
            
            User newUser = new User(0, fullName, email, password, null, null, "user", new Date());
            String code = String.format("%06d", new Random().nextInt(999999));
            
            session.setAttribute("newUser", newUser);
            session.setAttribute("regCode", code);

            EmailService emailService = new EmailService();
            String subject = "Welcome to FurniShop! Please verify your email";
            String body = "<h1>Thank you for registering!</h1><p>Your verification code is: <b>" + code + "</b></p>";
            
            // Gửi email
            boolean emailSent = emailService.sendVerificationCode(email, subject, body);
            
            if(emailSent) {
                // Nếu gửi mail thành công, chuyển sang trang xác thực
                response.sendRedirect("verify-registration.jsp");
            } else {
                // Nếu có lỗi gửi mail, báo lỗi lại trang đăng ký
                request.setAttribute("error", "Không thể gửi email xác thực. Vui lòng thử lại.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        // --- XỬ LÝ KHI NGƯỜI DÙNG NHẬP MÃ XÁC THỰC ---
        } else if ("verify".equals(action)) {
            String userCode = request.getParameter("code");
            String regCode = (String) session.getAttribute("regCode");

            if (regCode != null && regCode.equals(userCode)) {
                // Mã đúng -> lấy user từ session và lưu vào DB
                User newUser = (User) session.getAttribute("newUser");
                udao.registerUser(newUser); // Dùng lại phương thức DAO của bạn
                
                session.removeAttribute("newUser");
                session.removeAttribute("regCode");
                
                request.setAttribute("success", "Xác thực tài khoản thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Mã xác thực không đúng.");
                request.getRequestDispatcher("verify-registration.jsp").forward(request, response);
            }
        }
    }
}