package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserDAO extends DBContext {

    public User checkLogin(String email, String rawPassword) {
        // LƯU Ý BẢO MẬT: Trong thực tế, bạn phải mã hóa mật khẩu.
        // Logic đúng: Lấy hash từ DB, sau đó so sánh bằng thư viện jBcrypt.
        String sql = "SELECT * FROM Users WHERE Email = ? AND PasswordHash = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            st.setString(2, rawPassword);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserID(rs.getInt("UserID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPhone(rs.getString("Phone"));
                    user.setAddress(rs.getString("Address"));
                    user.setRole(rs.getString("Role"));
                    user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    return user;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in checkLogin: " + e.getMessage());
        }
        return null;
    }

    public boolean checkEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in checkEmailExists: " + e.getMessage());
        }
        return false;
    }

    public void registerUser(String fullName, String email, String passwordHash) {
        String sql = "INSERT INTO Users (FullName, Email, PasswordHash, Role) VALUES (?, ?, ?, 'Customer')";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, fullName);
            st.setString(2, email);
            st.setString(3, passwordHash);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in registerUser: " + e.getMessage());
        }
    }

    public boolean updateUserProfile(User user) {
        String sql = "UPDATE Users SET FullName = ?, Phone = ?, Address = ? WHERE UserID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, user.getFullName());
            st.setString(2, user.getPhone());
            st.setString(3, user.getAddress());
            st.setInt(4, user.getUserID());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in updateUserProfile: " + e.getMessage());
            return false;
        }
    }

    // 2. Thêm người dùng mới
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (PasswordHash, Email, FullName, Role, CreatedAt) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            // Sửa: Bỏ tham số cho Username
            ps.setString(1, user.getPasswordHash());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getRole());
            ps.setDate(5, new java.sql.Date(user.getCreatedAt().getTime()));

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE Email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("UserID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("PasswordHash"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getString("Role"),
                        rs.getDate("CreatedAt")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePasswordByEmail(String email, String newPasswordHash) {
        String query = "UPDATE users SET PasswordHash = ? WHERE Email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, newPasswordHash);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePasswordByID(int userID, String newPassword) {
        // Lưu ý: newPassword nên được mã hóa trước khi gọi hàm này
        String query = "UPDATE users SET PasswordHash = ? WHERE UserID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setInt(2, userID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
