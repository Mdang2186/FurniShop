package Utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

/**
 * Email qua SMTP. Lấy cấu hình từ biến môi trường nếu có; nếu không thì dùng hằng mặc định.
 * Có lastError để controller báo rõ.
 */
public class EmailService {

    private String lastError = "";
    public String getLastError() { return lastError; }
    private void setError(Exception e) { e.printStackTrace(); lastError = e.getMessage(); }

    // --- Cấu hình mặc định (sửa theo tài khoản của bạn) ---
    private static final String SMTP_HOST_DEF = "smtp.gmail.com";
    private static final int    SMTP_PORT_DEF = 587;
    private static final boolean SMTP_TLS_DEF = true;

    private static final String SMTP_USER_DEF = "your_account@gmail.com";
    private static final String SMTP_PASS_DEF = "your_app_password";
    private static final String FROM_NAME_DEF = "FurniShop";

    private String env(String k, String def) {
        String v = System.getenv(k);
        return (v == null || v.trim().isEmpty()) ? def : v.trim();
    }

    public boolean send(String to, String subject, String html) {
        try {
            String host = env("SMTP_HOST", SMTP_HOST_DEF);
            int port = parseInt(env("SMTP_PORT", ""), SMTP_PORT_DEF);
            boolean startTLS = !"false".equalsIgnoreCase(env("SMTP_STARTTLS", "true"));

            final String user = env("SMTP_USER", SMTP_USER_DEF);
            final String pass = env("SMTP_PASS", SMTP_PASS_DEF);
            final String fromName = env("SMTP_FROM_NAME", FROM_NAME_DEF);

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", String.valueOf(startTLS));
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", String.valueOf(port));

            Session session = Session.getInstance(props, new Authenticator() {
                @Override protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, pass);
                }
            });

            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(user, fromName, StandardCharsets.UTF_8.name()));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject(subject, StandardCharsets.UTF_8.name());
            msg.setContent(html, "text/html; charset=UTF-8");

            Transport.send(msg);
            return true;
        } catch (Exception e) {
            setError(e);
            return false;
        }
    }

    /** Gửi OTP với template HTML ngắn gọn */
    public boolean sendOtp(String to, String otp) {
        String subject = "Mã OTP xác thực";
        String body = new StringBuilder()
                .append("<div style='font-family:Inter,Segoe UI,Arial,sans-serif;font-size:14px'>")
                .append("<p>Xin chào,</p>")
                .append("<p>Mã OTP của bạn là: <b style='font-size:18px'>").append(otp).append("</b></p>")
                .append("<p>Mã có hiệu lực trong 10 phút.</p>")
                .append("<hr style='border:none;border-top:1px solid #eee;margin:16px 0'>")
                .append("<p style='color:#888'>Email được gửi tự động từ hệ thống FurniShop.</p>")
                .append("</div>")
                .toString();
        return send(to, subject, body);
    }

    private static int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}
