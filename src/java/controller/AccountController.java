package controller;

import dal.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

@WebServlet(name = "AccountController", urlPatterns = {"/account"})
public class AccountController extends HttpServlet {

    // ========== GET ==========
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user == null) {
            // quay lại account sau khi login xong
            session.setAttribute("returnTo", request.getContextPath() + "/account");
            response.sendRedirect("login");
            return;
        }

        // CSRF token cho form POST (profile + password)
        String csrf = (String) session.getAttribute("csrf");
        if (csrf == null) {
            csrf = genCsrf();
            session.setAttribute("csrf", csrf);
        }
        request.setAttribute("csrf", csrf);

        // tab đang mở (profile | password)
        String tab = n(request.getParameter("tab"));
        if (tab.isEmpty()) tab = "profile";
        request.setAttribute("tab", tab);

        request.getRequestDispatcher("account.jsp").forward(request, response);
    }

    // ========== POST ==========
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User current = (User) session.getAttribute("account");
        if (current == null) {
            session.setAttribute("returnTo", request.getContextPath() + "/account");
            response.sendRedirect("login");
            return;
        }

        // Chống CSRF
        String tokenForm = n(request.getParameter("_csrf"));
        String tokenSess = (String) session.getAttribute("csrf");
        if (tokenForm.isEmpty() || tokenSess == null || !tokenForm.equals(tokenSess)) {
            request.setAttribute("error", "Phiên làm việc không hợp lệ. Vui lòng thử lại.");
            request.setAttribute("tab", "profile");
            request.setAttribute("csrf", tokenSess);
            request.getRequestDispatcher("account.jsp").forward(request, response);
            return;
        }

        String action = n(request.getParameter("action"));
        UserDAO userDAO = new UserDAO();

        try {
            switch (action) {
                case "update-profile": {
                    String fullName = n(request.getParameter("fullName"));
                    String phone    = n(request.getParameter("phone"));
                    String address  = n(request.getParameter("address"));

                    // Validate nhẹ nhàng
                    if (fullName.isEmpty()) {
                        request.setAttribute("error", "Họ tên không được để trống.");
                    } else if (!phone.isEmpty() && !phone.matches("^(0|\\+?84)\\d{8,10}$")) {
                        request.setAttribute("error", "Số điện thoại không hợp lệ.");
                    }

                    if (request.getAttribute("error") == null) {
                        current.setFullName(fullName);
                        current.setPhone(phone);
                        current.setAddress(address);

                        boolean ok = userDAO.updateUserProfile(current);
                        if (ok) {
                            // đồng bộ lại session
                            session.setAttribute("account", current);
                            request.setAttribute("success", "Cập nhật thông tin thành công.");
                        } else {
                            request.setAttribute("error", "Không thể cập nhật lúc này. Thử lại sau.");
                        }
                    }

                    request.setAttribute("tab", "profile");
                    break;
                }

                case "change-password": {
                    String oldPwd = n(request.getParameter("oldPassword"));
                    String newPwd = n(request.getParameter("newPassword"));
                    String rePwd  = n(request.getParameter("re_newPassword"));

                    if (oldPwd.isEmpty() || newPwd.isEmpty() || rePwd.isEmpty()) {
                        request.setAttribute("error", "Vui lòng nhập đủ các trường.");
                    } else if (newPwd.length() < 6) {
                        request.setAttribute("error", "Mật khẩu mới tối thiểu 6 ký tự.");
                    } else if (!newPwd.equals(rePwd)) {
                        request.setAttribute("error", "Xác nhận mật khẩu không khớp.");
                    } else {
                        // Lấy user hiện tại từ DB để có PasswordHash
                        User fresh = userDAO.getUserByEmail(current.getEmail());
                        if (fresh == null) {
                            request.setAttribute("error", "Không tìm thấy tài khoản.");
                        } else {
                            String hash = n(fresh.getPasswordHash());

                            boolean oldOk;
                            if (!hash.isEmpty() && hash.startsWith("$2")) {
                                // DB đã dùng BCrypt
                                oldOk = BCrypt.checkpw(oldPwd, hash);
                            } else {
                                // Fallback dự án cũ từng lưu plain
                                oldOk = oldPwd.equals(hash) || oldPwd.equals(n(current.getPasswordHash()));
                            }

                            if (!oldOk) {
                                request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
                            } else {
                                String newHash = BCrypt.hashpw(newPwd, BCrypt.gensalt(10));
                                boolean ok = userDAO.updatePasswordByID(current.getUserID(), newHash);
                                if (ok) {
                                    // không cần ghi hash vào session (không dùng đến), nhưng có thể set để đồng bộ
                                    current.setPasswordHash(newHash);
                                    session.setAttribute("account", current);
                                    request.setAttribute("success", "Đổi mật khẩu thành công.");
                                } else {
                                    request.setAttribute("error", "Không thể đổi mật khẩu lúc này.");
                                }
                            }
                        }
                    }

                    request.setAttribute("tab", "password");
                    break;
                }

                default: {
                    request.setAttribute("error", "Hành động không hợp lệ.");
                    request.setAttribute("tab", "profile");
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Hệ thống bận. Vui lòng thử lại.");
            request.setAttribute("tab", "profile");
        }

        // Giữ CSRF cho lần submit sau
        request.setAttribute("csrf", session.getAttribute("csrf"));
        request.getRequestDispatcher("account.jsp").forward(request, response);
    }

    // ===== utils =====
    private static String n(String s) { return s == null ? "" : s.trim(); }

    private static String genCsrf() {
        byte[] b = new byte[24];
        new SecureRandom().nextBytes(b);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(b);
    }
}
