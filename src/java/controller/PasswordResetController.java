package controller;

import Utils.EmailService;
import dal.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

/**
 * Khớp form:
 *  - forgot-password.jsp  (POST email)
 *  - verify-code.jsp      (POST code, newPassword)
 */
@WebServlet(urlPatterns = {"/password-reset"})
public class PasswordResetController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private final EmailService mailer = new EmailService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(true);

        // BƯỚC 2: XÁC MINH OTP & ĐỔI MẬT KHẨU
        String code = t(req.getParameter("code"));
        String newPassword = t(req.getParameter("newPassword"));
        if (!code.isEmpty()) {
            String expect = (String) session.getAttribute("resetCode");
            Long   exp    = (Long)   session.getAttribute("resetExp");
            String email  = (String) session.getAttribute("emailToReset");

            if (expect == null || exp == null || email == null) {
                req.setAttribute("error", "Phiên xác minh đã hết hạn. Vui lòng yêu cầu mã mới.");
                req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
                return;
            }
            if (System.currentTimeMillis() > exp) {
                req.setAttribute("error", "Mã OTP đã hết hạn. Vui lòng yêu cầu mã mới.");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/verify-code.jsp").forward(req, resp);
                return;
            }
            if (!expect.equals(code)) {
                req.setAttribute("error", "Mã OTP không đúng.");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/verify-code.jsp").forward(req, resp);
                return;
            }
            if (newPassword.length() < 8) {
                req.setAttribute("error", "Mật khẩu mới phải từ 8 ký tự.");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/verify-code.jsp").forward(req, resp);
                return;
            }

            boolean ok = userDAO.updatePasswordByEmail(email, newPassword);
            if (!ok) {
                req.setAttribute("error", "Đổi mật khẩu thất bại. Thử lại sau.");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/verify-code.jsp").forward(req, resp);
                return;
            }

            // clear flags
            session.removeAttribute("resetCode");
            session.removeAttribute("resetExp");
            session.removeAttribute("emailToReset");

            req.setAttribute("success", "Đổi mật khẩu thành công. Mời đăng nhập.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // BƯỚC 1: NHẬN EMAIL & GỬI OTP
        String email = t(req.getParameter("email")).toLowerCase();
        if (email.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập email.");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
            return;
        }

        boolean exists;
        try { exists = userDAO.checkEmailExists(email); }
        catch (Throwable t) { exists = userDAO.getUserByEmail(email) != null; }

        if (!exists) {
            req.setAttribute("error", "Email không tồn tại.");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
            return;
        }

        String otp = genOtp();
        // Lưu OTP + hạn 10 phút
        session.setAttribute("resetCode", otp);
        session.setAttribute("resetExp", System.currentTimeMillis() + 10 * 60_000);
        session.setAttribute("emailToReset", email);

        boolean sent = mailer.sendOtp(email, otp);
        if (!sent) {
            req.setAttribute("error", "Không gửi được email OTP. Kiểm tra cấu hình SMTP.");
            req.getRequestDispatcher("/forgot-password.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("email", email);
        req.setAttribute("info", "Đã gửi mã OTP vào email. Vui lòng kiểm tra hộp thư (cả Spam/Promotions).");
        req.getRequestDispatcher("/verify-code.jsp").forward(req, resp);
    }

    private static String genOtp() {
        return String.format("%06d", new Random().nextInt(1_000_000));
    }
    private static String t(String s){ return s == null ? "" : s.trim(); }
}
