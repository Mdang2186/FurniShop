package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO extends DBContext {
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT CategoryID, CategoryName, Description FROM Categories";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Category c = new Category();
                c.setCategoryID(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                c.setDescription(rs.getString("Description"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllCategories: " + e.getMessage());
        }
        return list;
    }
}