package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO extends DBContext {

    /**
     * Phương thức helper mới để đảm bảo kết nối luôn sẵn sàng. (Đồng bộ với
     * ProductDAO.java)
     */
    private Connection requireConn() throws SQLException {
        if (this.connection == null || this.connection.isClosed()) {
            // Sử dụng DBContext gốc để tạo lại kết nối
            this.connection = new DBContext().connection;
        }
        return this.connection;
    }

    /**
     * Lấy tất cả danh mục. (Đã cập nhật để dùng requireConn() và sửa lỗi cột)
     */
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();

        // SỬA LỖI: Chỉ chọn 2 cột có trong furnishop.sql
        String sql = "SELECT CategoryID, CategoryName FROM Categories ORDER BY CategoryName ASC";

        try (PreparedStatement st = requireConn().prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Category c = new Category();
                c.setCategoryID(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                // KHÔNG set 'Description' vì cột này không tồn tại
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllCategories: " + e.getMessage());
            e.printStackTrace(); // In lỗi ra console để bạn thấy
        }
        return list;
    }

    public int countCategories() {
        String sql = "SELECT COUNT(*) FROM Categories";
        try (var st = connection.prepareStatement(sql); var rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ignored) {
        }
        return 0;
    }

    public Category getById(int id) {
        String sql = "SELECT CategoryID,CategoryName,Description FROM Categories WHERE CategoryID=?";
        try (var st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (var rs = st.executeQuery()) {
                if (rs.next()) {
                    Category c = new Category();
                    c.setCategoryID(rs.getInt(1));
                    c.setCategoryName(rs.getString(2));
                    c.setDescription(rs.getString(3));
                    return c;
                }
            }
        } catch (Exception ignored) {
        }
        return null;
    }

    public boolean insert(Category c) {
        String sql = "INSERT INTO Categories(CategoryName,Description) VALUES(?,?)";
        try (var st = connection.prepareStatement(sql)) {
            st.setString(1, c.getCategoryName());
            st.setString(2, c.getDescription());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean update(Category c) {
        String sql = "UPDATE Categories SET CategoryName=?, Description=? WHERE CategoryID=?";
        try (var st = connection.prepareStatement(sql)) {
            st.setString(1, c.getCategoryName());
            st.setString(2, c.getDescription());
            st.setInt(3, c.getCategoryID());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM Categories WHERE CategoryID=?";
        try (var st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            return false;
        }
    }

}
