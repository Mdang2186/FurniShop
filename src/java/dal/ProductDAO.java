package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 * Handles all database operations related to the Products table.
 */
public class ProductDAO extends DBContext {

    /**
     * Fetches a single product by its ID, including all its associated images.
     * @param id The ID of the product to retrieve.
     * @return A Product object with all details, or null if not found.
     */
    public Product getProductByID(int id) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        Product product = null;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    // Map main product details
                    product = mapResultSetToProduct(rs);
                    // Fetch the list of all associated images (main + detail)
                    product.setImageUrls(getProductImages(id));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getProductByID: " + e.getMessage());
        }
        return product;
    }

    // =========================================================================
    // PHƯƠNG THỨC MỚI: Đếm sản phẩm để phân trang
    // =========================================================================
    /**
     * Đếm tổng số sản phẩm khớp với các tiêu chí lọc.
     * Dùng cho việc phân trang.
     * @param keyword
     * @param categoryIds
     * @param minPrice
     * @param maxPrice
     * @return Tổng số sản phẩm (int).
     */
    public int countProducts(String keyword, List<Integer> categoryIds,
                             double minPrice, double maxPrice) {
        
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Build WHERE clause (PHẢI GIỐNG HỆT searchAndFilterProducts)
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

        // Execute query
        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả về giá trị COUNT(*)
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in countProducts: " + e.getMessage());
        }
        return 0;
    }

    // =========================================================================
    // PHƯƠNG THỨC ĐƯỢC CẬP NHẬT: Thêm offset và itemsPerPage
    // =========================================================================
    /**
     * Sửa đổi để hỗ trợ phân trang (thêm offset và itemsPerPage).
     */
    public List<Product> searchAndFilterProducts(String keyword, List<Integer> categoryIds,
                                                 double minPrice, double maxPrice, String sortBy,
                                                 int offset, int itemsPerPage) { // <-- 2 THAM SỐ MỚI
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Build WHERE clause (Giữ nguyên)
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

        // Build ORDER BY clause (Giữ nguyên)
        if (sortBy != null) {
            switch (sortBy) {
                case "price-asc":
                    sql.append(" ORDER BY Price ASC");
                    break;
                case "price-desc":
                    sql.append(" ORDER BY Price DESC");
                    break;
                default: // "newest"
                    sql.append(" ORDER BY CreatedAt DESC");
                    break;
            }
        } else {
             sql.append(" ORDER BY CreatedAt DESC"); // Default sort
        }
        
        // THÊM Mệnh đề phân trang (cho MySQL/MariaDB)
        sql.append(" LIMIT ?, ?");
        params.add(offset);
        params.add(itemsPerPage);

        // Execute query
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

    /**
     * Helper method to fetch all image URLs for a given product ID.
     */
    private List<String> getProductImages(int productId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT ImageURL FROM product_images WHERE ProductID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                while(rs.next()) {
                    images.add(rs.getString("ImageURL"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getProductImages: " + e.getMessage());
        }
        return images;
    }
    
    /**
     * Helper method to map a row from the ResultSet to a Product object.
     */
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductID(rs.getInt("ProductID"));
        p.setCategoryID(rs.getInt("CategoryID"));
        p.setProductName(rs.getString("ProductName"));
        p.setPrice(rs.getDouble("Price"));
        p.setDescription(rs.getString("Description"));
        p.setMaterial(rs.getString("Material"));
        p.setDimensions(rs.getString("Dimensions"));
        p.setFeatures(rs.getString("Features"));
        p.setImageURL(rs.getString("ImageURL"));
        p.setBrand(rs.getString("Brand"));
        p.setStock(rs.getInt("Stock"));
        p.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return p;
    }
}