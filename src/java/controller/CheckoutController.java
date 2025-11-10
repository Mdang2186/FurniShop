package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;
import model.CartItem;
import model.Order;
import model.OrderItem;
import model.Product;
import model.User;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {

    // --- GET: hiển thị trang checkout (ép đăng nhập) ---
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession ss = req.getSession(true);
        User user = (User) ss.getAttribute("account");
        String ctx = req.getContextPath();

        // ép login
        if (user == null) {
            String returnUrl = "/checkout";
            String sel = req.getParameter("sel");
            if (sel != null && !sel.isBlank()) {
                returnUrl += "?sel=" + URLEncoder.encode(sel, StandardCharsets.UTF_8);
            }
            ss.setAttribute("returnUrl", returnUrl);
            resp.sendRedirect(ctx + "/login");
            return;
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) ss.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(ctx + "/cart");
            return;
        }

        // lọc item đã chọn (nếu có sel), còn không thì lấy hết
        Set<Integer> chosen = parseSel(req.getParameter("sel"));
        List<CartItem> items = new ArrayList<>();
        for (CartItem it : cart) {
            Product p = it.getProduct();
            if (chosen.isEmpty() || chosen.contains(p.getProductID())) items.add(it);
        }
        if (items.isEmpty()) { // chặn submit trắng
            resp.sendRedirect(ctx + "/cart");
            return;
        }

        double sub = 0;
        for (CartItem it : items) sub += it.getTotalPrice();

        req.setAttribute("sel", req.getParameter("sel")); // preserve để POST
        req.setAttribute("items", items);
        req.setAttribute("subTotal", sub);
        req.setAttribute("grandTotal", sub);
        // gợi ý data user
        req.setAttribute("fullName", user.getFullName());
        req.setAttribute("address", user.getAddress());
        req.setAttribute("phone", user.getPhone());

        req.getRequestDispatcher("checkout.jsp").forward(req, resp);
    }

    // --- POST: tạo đơn hàng ---
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession ss = req.getSession(true);
        User user = (User) ss.getAttribute("account");
        String ctx = req.getContextPath();

        if (user == null) { resp.sendRedirect(ctx + "/login"); return; }

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) ss.getAttribute("cart");
        if (cart == null || cart.isEmpty()) { resp.sendRedirect(ctx + "/cart"); return; }

        Set<Integer> chosen = parseSel(req.getParameter("sel"));
        List<CartItem> items = new ArrayList<>();
        for (CartItem it : cart) {
            if (chosen.isEmpty() || chosen.contains(it.getProduct().getProductID())) items.add(it);
        }
        if (items.isEmpty()) {
            req.setAttribute("error", "Chưa chọn sản phẩm hợp lệ.");
            doGet(req, resp);
            return;
        }

        String fullName = n(req.getParameter("fullName"));
        String phone     = n(req.getParameter("phone"));
        String address   = n(req.getParameter("address"));
        String payment   = n(req.getParameter("paymentMethod"));
        String note      = n(req.getParameter("note"));

        if (fullName.isEmpty() || phone.isEmpty() || address.isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ họ tên, số điện thoại và địa chỉ.");
            doGet(req, resp);
            return;
        }

        double total = 0;
        List<OrderItem> oi = new ArrayList<>();
        for (CartItem it : items) {
            total += it.getTotalPrice();
            OrderItem row = new OrderItem();
            row.setProductID(it.getProduct().getProductID());
            row.setQuantity(it.getQuantity());
            row.setUnitPrice(it.getProduct().getPrice());
            oi.add(row);
        }

        Order order = new Order();
        order.setUserID(user.getUserID());
        order.setTotalAmount(total);
        order.setPaymentMethod(payment.isEmpty() ? "COD" : payment);
        order.setShippingAddress(fullName + " - " + phone + ", " + address);
        order.setNote(note);
        order.setItems(oi);

        boolean ok = new OrderDAO().createOrder(order);
        if (!ok) {
            req.setAttribute("error", "Có lỗi khi tạo đơn hàng. Vui lòng thử lại.");
            doGet(req, resp);
            return;
        }

        // dọn các item đã đặt khỏi giỏ
        if (chosen.isEmpty()) cart.clear();
        else cart.removeIf(it -> chosen.contains(it.getProduct().getProductID()));
        recalcSessionTotals(ss, cart);

        resp.sendRedirect(ctx + "/orders");
    }

    private static Set<Integer> parseSel(String sel) {
        Set<Integer> ids = new HashSet<>();
        if (sel == null || sel.isBlank()) return ids;
        for (String s : sel.split(",")) {
            try { ids.add(Integer.parseInt(s.trim())); } catch (Exception ignore) {}
        }
        return ids;
        }
    private static void recalcSessionTotals(HttpSession ss, List<CartItem> cart) {
        double total = 0; int size = 0;
        for (CartItem it : cart) { total += it.getTotalPrice(); size += it.getQuantity(); }
        ss.setAttribute("totalAmount", total);
        ss.setAttribute("cartSize", size);
        ss.setAttribute("cart", cart);
    }
    private static String n(String s){ return s==null? "": s.trim(); }
}
