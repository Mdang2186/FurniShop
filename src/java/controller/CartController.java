package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.Product;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    private int i(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> ensureCart(HttpSession session){
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);  // luôn nhét lại để lần view không bị null
        }
        return cart;
    }

    private void writeJson(HttpServletResponse resp, String json) throws IOException {
        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().write(json);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        process(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        process(req, resp);
    }

    private void process(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        List<CartItem> cart = ensureCart(session);

        String action = request.getParameter("action");
        if (action == null) action = "view";

        String ctx = request.getContextPath();
        boolean ajax = "1".equals(request.getParameter("ajax"));

        try {
            switch (action) {
                case "add": {
                    int pid = i(request.getParameter("pid"), -1);
                    int qty = i(request.getParameter("quantity"), 1);

                    if (pid <= 0) {
                        if (ajax) { writeJson(response, "{\"ok\":false,\"msg\":\"pid invalid\"}"); return; }
                        response.sendRedirect(ctx + "/shop");
                        return;
                    }

                    // tìm trong giỏ
                    for (CartItem it : cart) {
                        if (it.getProduct().getProductID() == pid) {
                            it.setQuantity(it.getQuantity() + Math.max(qty,1));
                            updateTotals(session, cart);
                            if (ajax) { writeJson(response,
                                    "{\"ok\":true,\"cartSize\":"+ session.getAttribute("cartSize") +"}"); return; }
                            response.sendRedirect(ctx + "/cart");
                            return;
                        }
                    }

                    // chưa có -> nạp từ DB
                    Product p = new ProductDAO().getProductByID(pid);
                    if (p == null) {
                        if (ajax) { writeJson(response, "{\"ok\":false,\"msg\":\"product not found\"}"); return; }
                        session.setAttribute("message", "Sản phẩm không còn tồn tại.");
                        response.sendRedirect(ctx + "/shop");
                        return;
                    }
                    cart.add(new CartItem(p, Math.max(qty,1)));
                    updateTotals(session, cart);

                    if (ajax) {
                        writeJson(response, "{\"ok\":true,\"cartSize\":"+ session.getAttribute("cartSize") +"}");
                        return;
                    }
                    response.sendRedirect(ctx + "/cart");
                    return;
                }

                case "update": {
                    int pid = i(request.getParameter("pid"), -1);
                    int qty = i(request.getParameter("quantity"), 1);

                    if (qty <= 0) cart.removeIf(it -> it.getProduct().getProductID() == pid);
                    else {
                        for (CartItem it : cart)
                            if (it.getProduct().getProductID() == pid) { it.setQuantity(qty); break; }
                    }
                    updateTotals(session, cart);

                    if (ajax) {
                        double lineTotal = 0;
                        for (CartItem it : cart)
                            if (it.getProduct().getProductID() == pid) { lineTotal = it.getTotalPrice(); break; }
                        writeJson(response,
                                "{\"ok\":true,\"lineTotal\":"+lineTotal+",\"cartSize\":"+session.getAttribute("cartSize")+"}");
                        return;
                    }
                    response.sendRedirect(ctx + "/cart");
                    return;
                }

                case "remove": {
                    int pid = i(request.getParameter("pid"), -1);
                    cart.removeIf(it -> it.getProduct().getProductID() == pid);
                    updateTotals(session, cart);

                    if (ajax) {
                        writeJson(response, "{\"ok\":true,\"cartSize\":"+ session.getAttribute("cartSize") +"}");
                        return;
                    }
                    response.sendRedirect(ctx + "/cart");
                    return;
                }

                default: { // view
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect(ctx + "/shop");
        }
    }

    private void updateTotals(HttpSession session, List<CartItem> cart) {
        double totalAmount = 0; int totalItems = 0;
        for (CartItem it : cart) { totalAmount += it.getTotalPrice(); totalItems += it.getQuantity(); }
        session.setAttribute("totalAmount", totalAmount);
        session.setAttribute("cartSize", totalItems);
        session.setAttribute("cart", cart);
    }
}
