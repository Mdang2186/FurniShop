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
            try { connection.rollback(); } catch (SQLException ex) { System.out.println("Error on rollback: " + ex.getMessage()); }
            return false;
        } finally {
            try { connection.setAutoCommit(true); } catch (SQLException ex) { System.out.println("Error setting auto-commit true: " + ex.getMessage()); }
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
}