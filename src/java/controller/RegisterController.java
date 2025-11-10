package controller;

import Utils.EmailService;
import dal.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.Random;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private final EmailService mailer = new EmailService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Nếu đang có phiên đăng ký dở (đã gửi OTP) thì hiển thị trang verify
        if (req.getSession().getAttribute("newUser") != null) {
            req.getRequestDispatcher("/verify-registration.jsp").forward(req, resp);
            return;
        }
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(true);

        // RESEND OTP
        if ("1".equals(req.getParameter("resend"))) {
            String email = (String) session.getAttribute("regEmail");
            User newUser = (User) session.getAttribute("newUser");
            if (newUser == null || email == null) {
                req.setAttribute("error", "Phiên đăng ký đã hết hạn. Vui lòng đăng ký lại.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }
            String otp = genOtp();
            session.setAttribute("regCode", otp);
            session.setAttribute("regExp", System.currentTimeMillis() + 10 * 60_000);
            mailer.sendOtp(email, otp);
            req.setAttribute("email", email);
            req.setAttribute("info", "Đã gửi lại mã xác minh vào email.");
            req.getRequestDispatcher("/verify-registration.jsp").forward(req, resp);
            return;
        }

        // BƯỚC 2: XÁC MINH OTP
        String code = t(req.getParameter("code"));
        if (!code.isEmpty()) {
            if (!code.matches("\\d{6}")) {
                req.setAttribute("error", "Mã OTP phải gồm đúng 6 chữ số.");
                req.getRequestDispatcher("/verify-registration.jsp").forward(req, resp);
                return;
            }
            String regCode = (String) session.getAttribute("regCode");
            Long   regExp  = (Long)   session.getAttribute("regExp");
            User   newUser = (User)   session.getAttribute("newUser");
            if (newUser == null || regCode == null || regExp == null) {
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

            // Lưu DB
            boolean ok = userDAO.registerUser(newUser);
            if (!ok) {
                req.setAttribute("error", "Không thể tạo tài khoản lúc này. Thử lại sau.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            // Clear session tạm
            session.removeAttribute("newUser");
            session.removeAttribute("regCode");
            session.removeAttribute("regExp");
            session.removeAttribute("regEmail");

            // (tuỳ chọn) gửi email chào mừng
            mailer.sendWelcome(newUser.getEmail(), newUser.getFullName());

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
        if (!email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            req.setAttribute("error", "Email không hợp lệ.");
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

        // Hash BCrypt (đồng bộ với LoginController đã fallback BCrypt)
        String hash = BCrypt.hashpw(pass, BCrypt.gensalt(10));

        User u = new User();
        u.setFullName(fullName);
        u.setEmail(email);
        u.setPasswordHash(hash);
        u.setRole("Customer");
        u.setCreatedAt(new Date());

        String otp = genOtp();
        session.setAttribute("newUser", u);
        session.setAttribute("regCode", otp);
        session.setAttribute("regExp", System.currentTimeMillis() + 10 * 60_000);
        session.setAttribute("regEmail", email);

        boolean sent = mailer.sendOtp(email, otp);
        if (!sent) {
            req.setAttribute("error", "Không gửi được email OTP. Kiểm tra cấu hình SMTP (App Password).");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("email", email);
        req.setAttribute("info", "Đã gửi mã xác minh vào email. Vui lòng kiểm tra hộp thư (kể cả Spam).");
        req.getRequestDispatcher("/verify-registration.jsp").forward(req, resp);
    }

    private static String genOtp() {
        return String.format("%06d", new Random().nextInt(1_000_000));
    }
    private static String t(String s){ return s == null ? "" : s.trim(); }
}
