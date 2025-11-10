package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URI;
import java.util.regex.Pattern;

@WebServlet(name = "SubscribeController", urlPatterns = {"/subscribe"})
public class SubscribeController extends HttpServlet {
    private static final Pattern EMAIL_RX =
            Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private String safeReferer(String referer) {
        try {
            URI uri = new URI(referer);
            // chỉ cho phép quay lại cùng host/context
            return referer;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String referer = req.getHeader("Referer");

        if (email == null || !EMAIL_RX.matcher(email).matches()) {
            req.getSession().setAttribute("error", "Email không hợp lệ.");
        } else {
            // TODO: lưu DB bảng Subscribers(email, createdAt) nếu muốn
            // new SubscriberDAO().insert(email);

            req.getSession().setAttribute("success", "Đã đăng ký nhận ưu đãi qua email.");
        }

        String back = safeReferer(referer);
        if (back != null) {
            resp.sendRedirect(back);
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
