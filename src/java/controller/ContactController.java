package controller;

import dal.FeedbackDAO; // Giả sử bạn có DAO này
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import java.io.IOException;

@WebServlet(name="ContactController", urlPatterns={"/contact"})
public class ContactController extends HttpServlet {
  
  // Bạn cần tạo FeedbackDAO nếu chưa có
  // private final FeedbackDAO fdao = new FeedbackDAO(); 

  @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    // Chuyển hướng về trang chủ, mục #contact
    resp.sendRedirect("home#contact");
  }

  @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    resp.setContentType("text/html; charset=UTF-8");
    req.setCharacterEncoding("UTF-8");

    // Lấy thông tin từ form của home.jsp
    String fullName = trim(req.getParameter("fullName"));
    String email    = trim(req.getParameter("email"));
    String phone    = trim(req.getParameter("phone"));
    String subject  = trim(req.getParameter("subject")); // (Trường này có trong form)
    String message  = trim(req.getParameter("message"));

    // Lấy UserID nếu đã đăng nhập (không bắt buộc)
    int userId = 0;
    HttpSession session = req.getSession(false);
    if(session != null && session.getAttribute("account") != null){
        User user = (User) session.getAttribute("account");
        userId = user.getUserID();
    }
    
    // Validate cơ bản
    if (fullName.isBlank() || email.isBlank() || phone.isBlank() || subject.isBlank() || message.isBlank()) {
      req.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc (*).");
      req.getRequestDispatcher("home.jsp").forward(req, resp); // Gửi lỗi về home
      return;
    }
    
    try {
      // Tạm thời chỉ mô phỏng việc gửi thành công
      // TODO: Bạn cần tạo FeedbackDAO và phương thức fdao.insert(...)
      // boolean ok = fdao.insert(userId, fullName, email, phone, subject, message);
      
      boolean ok = true; // Giả lập là đã lưu thành công
      
      if(ok) {
           req.setAttribute("success", "Đã gửi ý kiến. Chúng tôi sẽ phản hồi sớm nhất!");
      } else {
           req.setAttribute("error", "Không thể lưu liên hệ. Thử lại sau.");
      }
     
      // Sau khi xử lý, forward về home.jsp để hiển thị thông báo
      // (Bạn cần thêm code hiển thị ${success} và ${error} trong home.jsp, gần form contact)
      req.getRequestDispatcher("home.jsp").forward(req, resp);
      
    } catch (Exception e) {
      e.printStackTrace();
      req.setAttribute("error", "Có lỗi hệ thống. Vui lòng thử lại.");
      req.getRequestDispatcher("home.jsp").forward(req, resp);
    }
  }
  
  private String trim(String s){ return s==null? "" : s.trim(); }
}