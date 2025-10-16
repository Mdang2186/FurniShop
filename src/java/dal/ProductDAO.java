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

    /**
     * A powerful method to search, filter, and sort products dynamically.
     * This is the core method for the shop and home pages.
     * @param keyword Search term (can be null).
     * @param categoryIds List of category IDs to filter by (can be null).
     * @param minPrice Minimum price for filtering.
     * @param maxPrice Maximum price for filtering.
     * @param sortBy Sorting criteria ("newest", "price-asc", "price-desc").
     * @return A list of products matching the criteria.
     */
    public List<Product> searchAndFilterProducts(String keyword, List<Integer> categoryIds,
                                                 double minPrice, double maxPrice, String sortBy) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Build WHERE clause
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

        // Build ORDER BY clause
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
     * @param productId The ID of the product.
     * @return A list of image URLs.
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
     * @param rs The ResultSet to map from.
     * @return An initialized Product object.
     * @throws SQLException
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