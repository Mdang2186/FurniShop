package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderItem;
import model.Product;

public class OrderDAO extends DBContext {

    public boolean createOrder(Order order) {
        try {
            connection.setAutoCommit(false);
            String sqlOrder = "INSERT INTO Orders (UserID, TotalAmount, Status, PaymentMethod, ShippingAddress, Note) VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stOrder = connection.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                stOrder.setInt(1, order.getUserID());
                stOrder.setDouble(2, order.getTotalAmount());
                stOrder.setString(3, "Pending");
                stOrder.setString(4, order.getPaymentMethod());
                stOrder.setString(5, order.getShippingAddress());
                stOrder.setString(6, order.getNote());
                stOrder.executeUpdate();

                try (ResultSet generatedKeys = stOrder.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int orderId = generatedKeys.getInt(1);
                        OrderItemDAO orderItemDAO = new OrderItemDAO(connection);
                        for (OrderItem item : order.getItems()) {
                            item.setOrderID(orderId);
                            if (!orderItemDAO.addOrderItem(item)) {
                                connection.rollback();
                                return false;
                            }
                        }
                    } else {
                        throw new SQLException("Creating order failed, no ID obtained.");
                    }
                }
            }
            connection.commit();
            return true;
        } catch (SQLException e) {
            System.out.println("Error in createOrder transaction: " + e.getMessage());
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.out.println("Error on rollback: " + ex.getMessage());
            }
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                System.out.println("Error setting auto-commit true: " + ex.getMessage());
            }
        }
    }

    public List<Order> getOrdersByUserIdWithDetails(int userId) {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE UserID = ? ORDER BY OrderDate DESC";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setUserID(rs.getInt("UserID"));
                    order.setOrderDate(rs.getTimestamp("OrderDate"));
                    order.setTotalAmount(rs.getDouble("TotalAmount"));
                    order.setStatus(rs.getString("Status"));
                    order.setPaymentMethod(rs.getString("PaymentMethod"));
                    order.setShippingAddress(rs.getString("ShippingAddress"));
                    order.setNote(rs.getString("Note"));
                    order.setItems(getOrderItemsByOrderId(order.getOrderID()));
                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getOrdersByUserIdWithDetails: " + e.getMessage());
        }
        return orderList;
    }

    private List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> itemList = new ArrayList<>();
        String sql = "SELECT oi.*, p.ProductName, p.ImageURL FROM OrderItems oi JOIN Products p ON oi.ProductID = p.ProductID WHERE oi.OrderID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, orderId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setOrderItemID(rs.getInt("OrderItemID"));
                    item.setOrderID(rs.getInt("OrderID"));
                    item.setProductID(rs.getInt("ProductID"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setUnitPrice(rs.getDouble("UnitPrice"));

                    Product product = new Product();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setImageURL(rs.getString("ImageURL"));

                    item.setProduct(product);
                    itemList.add(item);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getOrderItemsByOrderId: " + e.getMessage());
        }
        return itemList;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM Orders";
        try (var st = connection.prepareStatement(sql); var rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ignored) {
        }
        return 0;
    }

    public int countByStatus(String status) {
        String sql = (status == null || status.isBlank()) ? "SELECT COUNT(*) FROM Orders" : "SELECT COUNT(*) FROM Orders WHERE Status=?";
        try (var st = connection.prepareStatement(sql)) {
            if (status != null && !status.isBlank()) {
                st.setString(1, status);
            }
            try (var rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception ignored) {
        }
        return 0;
    }

    public List<Order> getAllOrders(String status, int offset, int limit) {
        List<Order> list = new ArrayList<>();
        String base = "SELECT OrderID,UserID,OrderDate,TotalAmount,Status,PaymentMethod,ShippingAddress,Note FROM Orders";
        String sql = base + ((status == null || status.isBlank()) ? "" : " WHERE Status=?") + " ORDER BY OrderDate DESC LIMIT ? OFFSET ?";
        try (var st = connection.prepareStatement(sql)) {
            int idx = 1;
            if (status != null && !status.isBlank()) {
                st.setString(idx++, status);
            }
            st.setInt(idx++, limit);
            st.setInt(idx, offset);
            try (var rs = st.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderID(rs.getInt(1));
                    o.setUserID(rs.getInt(2));
                    o.setOrderDate(rs.getTimestamp(3));
                    o.setTotalAmount(rs.getDouble(4));
                    o.setStatus(rs.getString(5));
                    o.setPaymentMethod(rs.getString(6));
                    o.setShippingAddress(rs.getString(7));
                    o.setNote(rs.getString(8));
                    list.add(o);
                }
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Order getOrderByIdWithItems(int id) {
        Order o = null;
        String sql = "SELECT OrderID,UserID,OrderDate,TotalAmount,Status,PaymentMethod,ShippingAddress,Note FROM Orders WHERE OrderID=?";
        try (var st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (var rs = st.executeQuery()) {
                if (rs.next()) {
                    o = new Order();
                    o.setOrderID(rs.getInt(1));
                    o.setUserID(rs.getInt(2));
                    o.setOrderDate(rs.getTimestamp(3));
                    o.setTotalAmount(rs.getDouble(4));
                    o.setStatus(rs.getString(5));
                    o.setPaymentMethod(rs.getString(6));
                    o.setShippingAddress(rs.getString(7));
                    o.setNote(rs.getString(8));
                }
            }
        } catch (Exception e) {
        }
        if (o != null) {
            o.setItems(getOrderItemsByOrderId(id));
        }
        return o;
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE Orders SET Status=? WHERE OrderID=?";
        try (var st = connection.prepareStatement(sql)) {
            st.setString(1, status);
            st.setInt(2, id);
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            return false;
        }
    }

    public Map<String, Double> revenueLastDays(int days) {
        LinkedHashMap<String, Double> map = new LinkedHashMap<>();
        String sql = "SELECT DATE(OrderDate) d, SUM(TotalAmount) s FROM Orders WHERE OrderDate>=DATE_SUB(CURDATE(), INTERVAL ? DAY) AND Status IN ('Processing','Shipped','Delivered') GROUP BY d ORDER BY d";
        try (var st = connection.prepareStatement(sql)) {
            st.setInt(1, days);
            try (var rs = st.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString(1), rs.getDouble(2));
                }
            }
        } catch (Exception e) {
        }
        return map;
    }

    public List<Map<String, Object>> topSellingProducts(int limit) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) qty FROM OrderItems oi JOIN Products p ON oi.ProductID=p.ProductID "
                + "GROUP BY p.ProductID, p.ProductName ORDER BY qty DESC LIMIT ?";
        try (var st = connection.prepareStatement(sql)) {
            st.setInt(1, limit);
            try (var rs = st.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> m = new HashMap<>();
                    m.put("productID", rs.getInt(1));
                    m.put("productName", rs.getString(2));
                    m.put("quantity", rs.getInt(3));
                    list.add(m);
                }
            }
        } catch (Exception e) {
        }
        return list;
    }

}
