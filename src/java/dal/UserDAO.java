package dal;

import java.sql.*;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO extends DBContext {

    // Giữ 1 tên bảng duy nhất
    private static final String TBL = "`Users`";

    /* ---------------- LOGIN ---------------- */
    /**
     * Đăng nhập: lấy hash từ DB và check BCrypt
     */
    public User checkLogin(String email, String rawPassword) {
        String sql = "SELECT UserID, FullName, Email, PasswordHash, Phone, Address, Role, CreatedAt "
                + "FROM " + TBL + " WHERE Email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    String hash = rs.getString("PasswordHash");
                    if (hash != null && BCrypt.checkpw(rawPassword, hash)) {
                        return mapUser(rs);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("checkLogin error: " + e.getMessage());
        }
        return null;
    }

    /* ---------------- REGISTER ---------------- */
    public boolean checkEmailExists(String email) {
        String sql = "SELECT 1 FROM " + TBL + " WHERE Email = ? LIMIT 1";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.out.println("checkEmailExists error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Đăng ký với tham số rời rạc (hash đã có sẵn).
     */
    public boolean registerUser(String fullName, String email, String bcryptHash) {
        String sql = "INSERT INTO " + TBL + " (FullName, Email, PasswordHash, Role, CreatedAt) "
                + "VALUES (?, ?, ?, 'Customer', NOW())";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, fullName);
            st.setString(2, email);
            st.setString(3, bcryptHash);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("registerUser(String,...) error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Đăng ký với User (tự đảm bảo có hash & role).
     */
    public boolean registerUser(User user) {
        if (user == null) {
            return false;
        }
        String hash = user.getPasswordHash();
        if (!isBcrypt(hash)) { // nếu lỡ truyền raw → hash tại đây
            hash = BCrypt.hashpw(hash == null ? "" : hash, BCrypt.gensalt(12));
        }
        String role = user.getRole() == null || user.getRole().isBlank() ? "Customer" : user.getRole();

        String sql = "INSERT INTO " + TBL + " (FullName, Email, PasswordHash, Role, CreatedAt) "
                + "VALUES (?, ?, ?, ?, NOW())";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, nz(user.getFullName()));
            st.setString(2, nz(user.getEmail()));
            st.setString(3, hash);
            st.setString(4, role);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("registerUser(User) error: " + e.getMessage());
            return false;
        }
    }

    /* ---------------- PROFILE / LOOKUP ---------------- */
    public boolean updateUserProfile(User user) {
        String sql = "UPDATE " + TBL + " SET FullName = ?, Phone = ?, Address = ? WHERE UserID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, user.getFullName());
            st.setString(2, user.getPhone());
            st.setString(3, user.getAddress());
            st.setInt(4, user.getUserID());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("updateUserProfile error: " + e.getMessage());
            return false;
        }
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT UserID, FullName, Email, PasswordHash, Phone, Address, Role, CreatedAt "
                + "FROM " + TBL + " WHERE Email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("getUserByEmail error: " + e.getMessage());
        }
        return null;
    }

    /* ---------------- PASSWORD ---------------- */
    /**
     * Cập nhật mật khẩu bằng email – chấp nhận raw hoặc bcrypt, luôn lưu dạng
     * bcrypt.
     */
    public boolean updatePasswordByEmail(String email, String rawOrHash) {
        String hash = ensureBcrypt(rawOrHash);
        String sql = "UPDATE " + TBL + " SET PasswordHash = ? WHERE Email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, hash);
            st.setString(2, email);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("updatePasswordByEmail error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Cập nhật mật khẩu bằng UserID – chấp nhận raw hoặc bcrypt, luôn lưu dạng
     * bcrypt.
     */
    public boolean updatePasswordByID(int userID, String rawOrHash) {
        String hash = ensureBcrypt(rawOrHash);
        String sql = "UPDATE " + TBL + " SET PasswordHash = ? WHERE UserID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, hash);
            st.setInt(2, userID);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("updatePasswordByID error: " + e.getMessage());
            return false;
        }
    }

    /* ---------------- Helpers ---------------- */
    private static String nz(String s) {
        return s == null ? "" : s;
    }

    private static boolean isBcrypt(String s) {
        return s != null && s.startsWith("$2");
    }

    private static String ensureBcrypt(String rawOrHash) {
        if (isBcrypt(rawOrHash)) {
            return rawOrHash;
        }
        String raw = rawOrHash == null ? "" : rawOrHash;
        return BCrypt.hashpw(raw, BCrypt.gensalt(12));
    }

    private static User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserID(rs.getInt("UserID"));
        u.setFullName(rs.getString("FullName"));
        u.setEmail(rs.getString("Email"));
        u.setPasswordHash(rs.getString("PasswordHash"));
        u.setPhone(rs.getString("Phone"));
        u.setAddress(rs.getString("Address"));
        u.setRole(rs.getString("Role"));
        u.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return u;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (var st = connection.prepareStatement(sql); var rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ignored) {
        }
        return 0;
    }

    public List<model.User> searchUsers(String q) {
        List<model.User> list = new ArrayList<>();
        String sql = "SELECT UserID,FullName,Email,Phone,Address,Role,CreatedAt FROM Users "
                + (q == null || q.isBlank() ? "" : "WHERE FullName LIKE ? OR Email LIKE ? ")
                + "ORDER BY CreatedAt DESC LIMIT 100";
        try (var st = connection.prepareStatement(sql)) {
            if (q != null && !q.isBlank()) {
                String like = "%" + q + "%";
                st.setString(1, like);
                st.setString(2, like);
            }
            try (var rs = st.executeQuery()) {
                while (rs.next()) {
                    model.User u = new model.User();
                    u.setUserID(rs.getInt(1));
                    u.setFullName(rs.getString(2));
                    u.setEmail(rs.getString(3));
                    u.setPhone(rs.getString(4));
                    u.setAddress(rs.getString(5));
                    u.setRole(rs.getString(6));
                    u.setCreatedAt(rs.getTimestamp(7));
                    list.add(u);
                }
            }
        } catch (Exception e) {
        }
        return list;
    }

    public boolean updateRole(int userId, String role) {
        String sql = "UPDATE Users SET Role=? WHERE UserID=?";
        try (var st = connection.prepareStatement(sql)) {
            st.setString(1, role);
            st.setInt(2, userId);
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            return false;
        }
    }

}
