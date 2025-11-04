package controller;

import Utils.EmailService;
import dal.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;
import org.mindrot.jbcrypt.BCrypt; // <-- THÊM IMPORT NÀY

/**
 * Khớp form:
 * - register.jsp              (POST fullName, email, password, re_password)
 * - verify-registration.jsp   (POST code)
 */
@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private final EmailService mailer = new EmailService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(true);

        // BƯỚC 2: XÁC MINH OTP
        String code = t(req.getParameter("code"));
        if (!code.isEmpty()) {
            String regCode = (String) session.getAttribute("regCode");
            Long   regExp  = (Long)   session.getAttribute("regExp");
            User newUser   = (User)   session.getAttribute("newUser");

            if (regCode == null || regExp == null || newUser == null) {
                req.setAttribute("error", "Phiên đăng ký đã hết hạn. Vui lòng đăng ký lại.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }
            if (System.currentTimeMillis() > regExp) {
                req.setAttribute("error", "Mã OTP đã hết hạn. Vui lòng đăng ký lại.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }
            if (!regCode.equals(code)) {
                req.setAttribute("error", "Mã xác minh không đúng.");
                req.getRequestDispatcher("/verify-registration.jsp").forward(req, resp);
                return;
            }

            // Dòng này sẽ chạy thành công vì newUser đã đầy đủ thông tin
            boolean ok = userDAO.registerUser(newUser); 
            if (!ok) {
                req.setAttribute("error", "Tạo tài khoản thất bại. Thử lại sau.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            session.removeAttribute("regCode");
            session.removeAttribute("regExp");
            session.removeAttribute("newUser");

            req.setAttribute("success", "Đăng ký thành công. Mời đăng nhập.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // BƯỚC 1: NHẬN FORM & GỬI OTP
        String fullName = t(req.getParameter("fullName"));
        String email    = t(req.getParameter("email")).toLowerCase();
        String pass     = t(req.getParameter("password"));
        String rePass   = t(req.getParameter("re_password"));

        if (fullName.isEmpty() || email.isEmpty() || pass.isEmpty() || rePass.isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }
        if (!pass.equals(rePass)) {
            req.setAttribute("error", "Xác nhận mật khẩu không khớp.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }
        if (userDAO.checkEmailExists(email)) {
            req.setAttribute("error", "Email đã được sử dụng.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        // === SỬA LỖI VÀ BẢO MẬT TẠI ĐÂY ===
        
        // 1. Mã hóa mật khẩu (Fix bảo mật)
        String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());

        // 2. Tạo user tạm (ghi DB sau khi verify OTP)
        User u = new User();
        u.setFullName(fullName);
        u.setEmail(email);
        u.setPasswordHash(hashedPassword); // <-- Dùng mật khẩu đã mã hóa

        // 3. Sửa lỗi NullPointerException (Fix bug)
        u.setRole("Customer");              // <-- Gán Role mặc định
        u.setCreatedAt(new java.util.Date()); // <-- Gán ngày tạo
        
        // ===================================

        String otp = genOtp();
        session.setAttribute("regCode", otp);
        session.setAttribute("regExp", System.currentTimeMillis() + 10 * 60_000); // 10 phút
        session.setAttribute("newUser", u);

        boolean sent = mailer.sendOtp(email, otp);
        if (!sent) {
            req.setAttribute("error", "Không gửi được email OTP. Kiểm tra cấu hình SMTP.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("email", email);
        req.setAttribute("info", "Đã gửi mã xác minh vào email. Vui lòng kiểm tra hộp thư.");
        req.getRequestDispatcher("/verify-registration.jsp").forward(req, resp);
    }

    private static String genOtp() {
        return String.format("%06d", new Random().nextInt(1_000_000));
    }
    private static String t(String s){ return s == null ? "" : s.trim(); }

    /** Gọi setter bằng reflection để không phụ thuộc tên trường cụ thể trong model.User */
    private static boolean safeSet(Object target, String setter, String val) {
        try { target.getClass().getMethod(setter, String.class).invoke(target, val); return true; }
        catch (Exception e) { return false; }
    }
}