package Utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

/**
 * Gửi email trực tiếp bằng SMTP (Gmail/SendGrid/Mailgun đều OK).
 *
 * Cấu hình nhanh (chọn 1 trong 2):
 *  A) Chỉnh hằng số SMTP_* bên dưới (đơn giản nhất cho đồ án);
 *  B) Hoặc đặt biến môi trường: SMTP_USER, SMTP_PASS, SMTP_HOST, SMTP_PORT, SMTP_FROM_NAME.
 */
public class EmailService {

    /* ====== Cách A: cấu hình trực tiếp tại đây ====== */
    private static final String SMTP_USER      = "jejangwangminh@gmail.com";    
    private static final String SMTP_PASS_APP  = "ppdo vxpv waik cdsk";      
    private static final String SMTP_HOST_DEF  = "smtp.gmail.com";
    private static final int    SMTP_PORT_DEF  = 587;
    private static final String FROM_NAME_DEF  = "FurniShop";
    /* ================================================= */

    // Nếu bạn muốn dùng biến môi trường, các giá trị dưới sẽ override hằng số phía trên (nếu có)
    private final String host = or(System.getenv("SMTP_HOST"), SMTP_HOST_DEF);
    private final int    port = parseInt(or(System.getenv("SMTP_PORT"), String.valueOf(SMTP_PORT_DEF)), SMTP_PORT_DEF);
    private final String user = or(System.getenv("SMTP_USER"), SMTP_USER);
    private final String pass = or(System.getenv("SMTP_PASS"), SMTP_PASS_APP);
    private final String fromName = or(System.getenv("SMTP_FROM_NAME"), FROM_NAME_DEF);

    public boolean send(String to, String subject, String htmlBody) {
        if (isBlank(user) || isBlank(pass)) {
            System.err.println("SMTP chưa cấu hình. Vui lòng điền SMTP_USER & SMTP_PASS (App Password).");
            return false;
        }
        try {
            Properties p = new Properties();
            p.put("mail.smtp.auth", "true");
            p.put("mail.smtp.starttls.enable", "true");
            p.put("mail.smtp.host", host);
            p.put("mail.smtp.port", String.valueOf(port));

            Session session = Session.getInstance(p, new Authenticator() {
                @Override protected PasswordAuthentication getPasswordAuthentication() {
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
            e.printStackTrace();
            return false;
        }
    }

    /** Gửi OTP HTML đơn giản. */
    public boolean sendOtp(String to, String otp) {
        String subject = "Mã OTP xác thực";
        String body = "<p>Mã OTP của bạn là: <b style='font-size:18px'>" + otp + "</b></p>"
                    + "<p>Mã có hiệu lực 10 phút.</p>"
                    + "<p>Nếu không phải bạn yêu cầu, hãy bỏ qua email này.</p>";
        return send(to, subject, body);
    }

    /* ====== utils ====== */
    private static String or(String a, String b){ return isBlank(a) ? b : a; }
    private static boolean isBlank(String s){ return s == null || s.trim().isEmpty(); }
    private static int parseInt(String s, int def){ try { return Integer.parseInt(s); } catch(Exception e){ return def; } }
}
