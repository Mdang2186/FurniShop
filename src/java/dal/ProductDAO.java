package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductDAO extends DBContext {

    public Product getProductByID(int id) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getProductByID: " + e.getMessage());
        }
        return null;
    }

    public List<Product> searchAndFilterProducts(String keyword, List<Integer> categoryIds,
                                                 double minPrice, double maxPrice, String sortBy) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND ProductName LIKE ?");
            params.add("%" + keyword + "%");
        }

        if (categoryIds != null && !categoryIds.isEmpty()) {
            sql.append(" AND CategoryID IN (");
            for (int i = 0; i < categoryIds.size(); i++) {
                sql.append("?");
                if (i < categoryIds.size() - 1) sql.append(",");
                params.add(categoryIds.get(i));
            }
            sql.append(")");
        }

        if (maxPrice > 0 && maxPrice > minPrice) {
            sql.append(" AND Price BETWEEN ? AND ?");
            params.add(minPrice);
            params.add(maxPrice);
        }

        if (sortBy != null) {
            switch (sortBy) {
                case "price-asc":
                    sql.append(" ORDER BY Price ASC");
                    break;
                case "price-desc":
                    sql.append(" ORDER BY Price DESC");
                    break;
                default:
                    sql.append(" ORDER BY CreatedAt DESC");
                    break;
            }
        } else {
             sql.append(" ORDER BY CreatedAt DESC");
        }

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in searchAndFilterProducts: " + e.getMessage());
        }
        return list;
    }
    
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductID(rs.getInt("ProductID"));
        p.setCategoryID(rs.getInt("CategoryID"));
        p.setProductName(rs.getString("ProductName"));
        p.setPrice(rs.getDouble("Price"));
        p.setDescription(rs.getString("Description"));
        p.setMaterial(rs.getString("Material"));
        p.setFeatures(rs.getString("Features"));
        p.setImageURL(rs.getString("ImageURL"));
        p.setBrand(rs.getString("Brand"));
        p.setStock(rs.getInt("Stock"));
        p.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return p;
    }
}