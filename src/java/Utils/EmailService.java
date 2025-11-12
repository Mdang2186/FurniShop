package Utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.nio.charset.StandardCharsets;
import java.util.Properties;

/**
 * EmailService — gửi email SMTP (Gmail App Password / SendGrid / Mailgun đều
 * được). - Không dùng Text Block để tương thích Java 8+. - HTML inline CSS,
 * hiển thị đẹp trên Gmail.
 *
 * LƯU Ý: Với Gmail, bắt buộc dùng App Password (2FA) chứ không phải mật khẩu
 * thường.
 */
public class EmailService {

    /* ==== cấu hình nhanh (điền thẳng, hoặc override bằng biến môi trường) ==== */
    private static final String SMTP_USER_DEF = "jejangwangminh@gmail.com"; // <-- đổi của bạn
    private static final String SMTP_PASS_APP_DEF = "ppdo vxpv waik cdsk";       // <-- App Password
    private static final String SMTP_HOST_DEF = "smtp.gmail.com";
    private static final int SMTP_PORT_DEF = 587; // STARTTLS
    private static final String FROM_NAME_DEF = "LUXE INTERIORS"; // <-- ĐÃ SỬA TÊN
    /* ========================================================================= */

    private final String host = or(System.getenv("SMTP_HOST"), SMTP_HOST_DEF);
    private final int port = parseInt(or(System.getenv("SMTP_PORT"), String.valueOf(SMTP_PORT_DEF)), SMTP_PORT_DEF);
    private final String user = or(System.getenv("SMTP_USER"), SMTP_USER_DEF);
    private final String pass = or(System.getenv("SMTP_PASS"), SMTP_PASS_APP_DEF);
    private final String fromName = or(System.getenv("SMTP_FROM_NAME"), FROM_NAME_DEF);

    /**
     * Gửi thô: subject + HTML body
     */
    public boolean send(String to, String subject, String htmlBody) {
        if (isBlank(user) || isBlank(pass)) {
            System.err.println("[EmailService] Chưa cấu hình SMTP_USER/SMTP_PASS (App Password).");
            return false;
        }
        try {
            Properties p = new Properties();
            p.put("mail.smtp.auth", "true");
            p.put("mail.smtp.starttls.enable", "true");
            p.put("mail.smtp.host", host);
            p.put("mail.smtp.port", String.valueOf(port));

            Session session = Session.getInstance(p, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, pass);
                }
            });

            MimeMessage m = new MimeMessage(session);
            m.setFrom(new InternetAddress(user, fromName, StandardCharsets.UTF_8.name()));
            m.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            m.setSubject(subject, StandardCharsets.UTF_8.name());
            m.setContent(htmlBody, "text/html; charset=UTF-8");

            Transport.send(m);
            return true;
        } catch (Exception e) {
            System.err.println("[EmailService] Send error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /* ================== Template thương hiệu dùng lại ================== */
    private String wrapBrandMail(String subject, String preheader, String innerHtml) {
        // Tất cả inline để tương thích Gmail
        StringBuilder sb = new StringBuilder();

        sb.append("<!doctype html><html lang=\"vi\"><head>")
                .append("<meta charset=\"UTF-8\">")
                .append("<meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">")
                // preheader
                .append("<span style=\"display:none!important;opacity:0;visibility:hidden;height:0;width:0;\">")
                .append(escape(preheader)).append("</span>")
                .append("</head><body style=\"margin:0;background:#faf7f2;font-family:Inter,Segoe UI,Roboto,Arial,sans-serif;\">")
                .append("<table role=\"presentation\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"background:#faf7f2;padding:24px 0;\">")
                .append("<tr><td align=\"center\">")
                .append("<table role=\"presentation\" width=\"640\" cellspacing=\"0\" cellpadding=\"0\" ")
                .append("style=\"max-width:640px;width:100%;background:#ffffff;border-radius:16px;box-shadow:0 10px 30px rgba(0,0,0,.06);overflow:hidden;\">")
                // Header
                .append("<tr><td style=\"padding:24px 28px;background:linear-gradient(135deg,#ffeb99,#c79a2d);\">")
                .append("<div style=\"display:flex;align-items:center;gap:12px;color:#2b1e08;\">")
                .append("<div style=\"width:36px;height:36px;border-radius:10px;background:#fff;display:grid;place-items:center;font-size:18px;\">🛋️</div>")
                .append("<div style=\"font-weight:800;font-size:18px;letter-spacing:.3px\">LUXE INTERIORS</div>")
                .append("</div></td></tr>")
                // Title
                .append("<tr><td style=\"padding:26px 28px 0 28px;\">")
                .append("<div style=\"font-weight:700;font-size:20px;color:#1f2937;margin-bottom:6px;\">")
                .append(escape(subject)).append("</div>")
                .append("<div style=\"color:#6b7280;font-size:13px\">Email thông báo từ hệ thống</div>")
                .append("</td></tr>")
                // Body
                .append("<tr><td style=\"padding:12px 28px 6px 28px;\">")
                .append(innerHtml)
                .append("</td></tr>")
                // Footer
                .append("<tr><td style=\"padding:18px 28px 26px 28px;color:#6b7280;font-size:12px;border-top:1px solid #f1eadf;\">")
                .append("Đây là email tự động, vui lòng không trả lời. ")
                .append("Truy cập <a href=\"http://localhost:8080/Nhom2_FurniShop/home\" style=\"color:#a47f1a;text-decoration:none;\">LUXE INTERIORS</a> để biết thêm chi tiết.")
                .append("</td></tr>")
                .append("</table></td></tr></table></body></html>");

        return sb.toString();
    }

    /**
     * Gửi OTP với template thương hiệu
     */
    public boolean sendOtp(String to, String otp) {
        String subject = "Mã xác thực OTP";
        String preheader = "Mã OTP của bạn là " + otp + " (hiệu lực 10 phút).";

        // inner content
        StringBuilder inner = new StringBuilder();
        inner.append("<p style=\"margin:0 0 12px 0\">Xin chào,</p>")
                .append("<p style=\"margin:0 0 16px 0\">Để hoàn tất đăng ký/khôi phục tài khoản, vui lòng dùng mã OTP bên dưới:</p>")
                .append("<div style=\"text-align:center;margin:18px 0 8px 0;\">")
                .append("<span style=\"display:inline-block;font-family:Courier New,monospace;font-weight:700;")
                .append("letter-spacing:6px;font-size:28px;color:#2b1e08;background:#fff7e6;border:1px solid #f1d48a;border-radius:10px;")
                .append("padding:14px 18px;\">")
                .append(escape(otp)).append("</span></div>")
                .append("<ul style=\"margin:16px 0 0 16px;color:#374151;padding-left:18px;\">")
                .append("<li>Mã có hiệu lực <b>10 phút</b>.</li>")
                .append("<li>Không chia sẻ mã cho bất cứ ai.</li>")
                .append("<li>Nếu không phải bạn yêu cầu, hãy bỏ qua email này.</li>")
                .append("</ul>")
                .append("<p style=\"margin:16px 0 0 0;color:#6b7280;font-size:13px\">Trân trọng,<br/>Đội ngũ LUXE INTERIORS</p>");

        String html = wrapBrandMail(subject, preheader, inner.toString());
        return send(to, subject, html);
    }

    /**
     * Gửi email chào mừng sau khi đăng ký thành công.
     */
    public boolean sendWelcome(String to, String fullName) {
        String subject = "Chào mừng đến LUXE INTERIORS";
        String preheader = "Tài khoản của " + escape(fullName) + " đã được tạo thành công.";

        String inner = ""
                + "<p style=\"margin:0 0 12px 0\">Xin chào <b>" + escape(fullName) + "</b>,</p>"
                + "<p style=\"margin:0 0 16px 0\">Bạn đã đăng ký thành công tài khoản tại "
                + "<b>LUXE INTERIORS</b>. Bắt đầu khám phá các bộ sưu tập nội thất sang trọng ngay hôm nay!</p>"
                + "<div style=\"text-align:center;margin:18px 0;\">"
                + "  <a href=\"http://localhost:8080/Nhom2_FurniShop/home\" "
                + "     style=\"display:inline-block;padding:12px 20px;border-radius:999px;"
                + "            background:linear-gradient(135deg,#ffde59,#b7860b);"
                + "            color:#2b1e08;font-weight:700;text-decoration:none;\">"
                + "     Khám phá sản phẩm"
                + "  </a>"
                + "</div>"
                + "<p style=\"margin:16px 0 0 0;color:#6b7280;font-size:13px\">"
                + "Chúc bạn mua sắm vui vẻ!<br/>Đội ngũ LUXE INTERIORS"
                + "</p>";

        String html = wrapBrandMail(subject, preheader, inner);
        return send(to, subject, html);
    }

    /**
     * Gửi thông báo có liên hệ MỚI đến Admin
     */
    public boolean sendContactNotification(String adminEmail, String name, String email, String phone, String subject, String message) {
        String mailSubject = "Liên hệ MỚI từ: " + escape(name);
        String preheader = "Chủ đề: " + escape(subject);

        String inner = ""
                + "<p style=\"margin:0 0 16px 0\">Bạn vừa nhận được một yêu cầu liên hệ mới qua website:</p>"
                + "<table role=\"presentation\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-size:14px;color:#374151;border-collapse:collapse;\">"
                + "<tr><td style=\"padding:8px;background:#f9fafb;border:1px solid #e5e7eb;width:100px;\"><b>Họ tên</b></td>"
                + "<td style=\"padding:8px;border:1px solid #e5e7eb;\">" + escape(name) + "</td></tr>"
                
                + "<tr><td style=\"padding:8px;background:#f9fafb;border:1px solid #e5e7eb;\"><b>Email</b></td>"
                + "<td style=\"padding:8px;border:1m solid #e5e7eb;\">" + escape(email) + "</td></tr>"
                
                + "<tr><td style=\"padding:8px;background:#f9fafb;border:1px solid #e5e7eb;\"><b>Điện thoại</b></td>"
                + "<td style=\"padding:8px;border:1px solid #e5e7eb;\">" + escape(phone) + "</td></tr>"
                
                + "<tr><td style=\"padding:8px;background:#f9fafb;border:1px solid #e5e7eb;\"><b>Chủ đề</b></td>"
                + "<td style=\"padding:8px;border:1px solid #e5e7eb;\">" + escape(subject) + "</td></tr>"
                
                + "<tr><td style=\"padding:8px;background:#f9fafb;border:1px solid #e5e7eb;vertical-align:top;\"><b>Nội dung</b></td>"
                + "<td style=\"padding:8px;border:1px solid #e5e7eb;line-height:1.6;\">" + escape(message).replace("\n", "<br/>") + "</td></tr>"
                + "</table>"
                + "<p style=\"margin:16px 0 0 0;color:#6b7280;font-size:13px\">"
                + "Vui lòng phản hồi sớm.<br/>Đội ngũ LUXE INTERIORS"
                + "</p>";

        String html = wrapBrandMail(mailSubject, preheader, inner);
        return send(adminEmail, mailSubject, html);
    }

    /**
     * Gửi email xác nhận đã nhận liên hệ cho Người dùng
     */
    public boolean sendContactConfirmation(String toEmail, String name) {
        String subject = "Đã nhận yêu cầu liên hệ của bạn";
        String preheader = "Cảm ơn " + escape(name) + ", chúng tôi sẽ phản hồi sớm nhất!";

        String inner = ""
                + "<p style=\"margin:0 0 12px 0\">Xin chào <b>" + escape(name) + "</b>,</p>"
                + "<p style=\"margin:0 0 16px 0\">"
                + "Chúng tôi đã nhận được yêu cầu tư vấn của bạn. Đội ngũ LUXE INTERIORS sẽ xem xét và phản hồi qua email hoặc SĐT của bạn trong thời gian sớm nhất."
                + "</p>"
                + "<div style=\"text-align:center;margin:18px 0;\">"
                + "  <a href=\"http://localhost:8080/Nhom2_FurniShop/shop\" " // Sửa link về trang Shop
                + "     style=\"display:inline-block;padding:12px 20px;border-radius:999px;"
                + "            background:linear-gradient(135deg,#ffde59,#b7860b);"
                + "            color:#2b1e08;font-weight:700;text-decoration:none;\">"
                + "     Tiếp tục mua sắm"
                + "  </a>"
                + "</div>"
                + "<p style=\"margin:16px 0 0 0;color:#6b7280;font-size:13px\">"
                + "Cảm ơn bạn đã tin tưởng LUXE INTERIORS!"
                + "</p>";

        String html = wrapBrandMail(subject, preheader, inner);
        return send(toEmail, subject, html);
    }
    
    /**
     * Gửi thông báo có người ĐĂNG KÝ NHẬN TIN mới đến Admin
     */
    public boolean sendSubscriptionNotification(String adminEmail, String newSubscriberEmail) {
        String mailSubject = "Đăng ký nhận tin MỚI";
        String preheader = "Email: " + escape(newSubscriberEmail);

        String inner = ""
                + "<p style=\"margin:0 0 16px 0\">Bạn vừa nhận được một lượt đăng ký nhận tin mới qua website:</p>"
                + "<table role=\"presentation\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-size:14px;color:#374151;border-collapse:collapse;\">"
                + "<tr><td style=\"padding:8px;background:#f9fafb;border:1px solid #e5e7eb;width:100px;\"><b>Email</b></td>"
                + "<td style=\"padding:8px;border:1px solid #e5e7eb;\"><b>" + escape(newSubscriberEmail) + "</b></td></tr>"
                + "</table>"
                + "<p style=\"margin:16px 0 0 0;color:#6b7280;font-size:13px\">"
                + "Đã tự động lưu vào CSDL (bảng subscribers).<br/>Đội ngũ LUXE INTERIORS"
                + "</p>";

        String html = wrapBrandMail(mailSubject, preheader, inner);
        return send(adminEmail, mailSubject, html);
    }

    /**
     * Gửi email xác nhận đã ĐĂNG KÝ NHẬN TIN cho Người dùng
     */
    public boolean sendSubscriptionConfirmation(String toEmail) {
        String subject = "Xác nhận đăng ký nhận ưu đãi";
        String preheader = "Cảm ơn bạn đã đăng ký nhận tin từ LUXE INTERIORS!";

        String inner = ""
                + "<p style=\"margin:0 0 12px 0\">Xin chào,</p>"
                + "<p style=\"margin:0 0 16px 0\">"
                + "Cảm ơn bạn đã đăng ký nhận thông tin ưu đãi, bộ sưu tập mới và các cảm hứng décor từ <b>LUXE INTERIORS</b>."
                + "</p>"
                + "<p style=\"margin:0 0 16px 0\">"
                + "Chúng tôi sẽ gửi email cho bạn sớm nhất khi có chương trình khuyến mãi hấp dẫn!"
                + "</p>"
                + "<div style=\"text-align:center;margin:18px 0;\">"
                + "  <a href=\"http://localhost:8080/Nhom2_FurniShop/shop\" " // Sửa link về trang Shop
                + "     style=\"display:inline-block;padding:12px 20px;border-radius:999px;"
                + "            background:linear-gradient(135deg,#ffde59,#b7860b);"
                + "            color:#2b1e08;font-weight:700;text-decoration:none;\">"
                + "     Khám phá sản phẩm"
                + "  </a>"
                + "</div>"
                + "<p style=\"margin:16px 0 0 0;color:#6b7280;font-size:13px\">"
                + "Trân trọng,<br/>Đội ngũ LUXE INTERIORS"
                + "</p>";

        String html = wrapBrandMail(subject, preheader, inner);
        return send(toEmail, subject, html);
    }


    /* ================== helpers ================== */
    private static String escape(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;");
    }

    private static String or(String a, String b) {
        return isBlank(a) ? b : a;
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private static int parseInt(String s, int def) {
        try {
            return Integer.parseInt(s);
        } catch (Exception e) {
            return def;
        }
    }
}