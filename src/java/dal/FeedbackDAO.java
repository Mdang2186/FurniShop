package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * DAO cho bảng ContactMessages.
 * Bảng gợi ý (MySQL):
 *
 * CREATE TABLE IF NOT EXISTS ContactMessages(
 *   Id INT AUTO_INCREMENT PRIMARY KEY,
 *   UserID INT NOT NULL,
 *   FullName VARCHAR(120) NOT NULL,
 *   Email VARCHAR(120) NOT NULL,
 *   Phone VARCHAR(20),
 *   Subject VARCHAR(200) NOT NULL,
 *   Message TEXT NOT NULL,
 *   CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
 * );
 */
public class FeedbackDAO extends DBContext {

    /** DTO nhẹ để trả dữ liệu ra View/Admin mà không cần tạo model riêng. */
    public static class ContactRecord {
        public int id;
        public int userId;
        public String fullName;
        public String email;
        public String phone;
        public String subject;
        public String message;
        public Date createdAt;
    }

    /** Lưu liên hệ mới. Trả true nếu thành công. */
    public boolean insert(int userId, String fullName, String email, String phone,
                          String subject, String message) throws SQLException {
        final String sql =
            "INSERT INTO ContactMessages(UserID, FullName, Email, Phone, Subject, Message, CreatedAt) " +
            "VALUES(?,?,?,?,?,?, NOW())";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, subject);
            ps.setString(6, message);
            return ps.executeUpdate() > 0;
        }
    }

    /** Lấy 1 bản ghi theo Id. */
    public ContactRecord findById(int id) throws SQLException {
        final String sql = "SELECT * FROM ContactMessages WHERE Id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    /** Lấy danh sách liên hệ của một user (mới nhất trước). */
    public List<ContactRecord> findByUser(int userId) throws SQLException {
        final String sql = "SELECT * FROM ContactMessages WHERE UserID=? ORDER BY CreatedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                List<ContactRecord> list = new ArrayList<>();
                while (rs.next()) list.add(map(rs));
                return list;
            }
        }
    }

    /**
     * Danh sách liên hệ cho Admin có phân trang + tìm kiếm (keyword tìm trong FullName/Email/Subject/Message).
     * @param page      trang hiện tại (>=1)
     * @param pageSize  số bản ghi mỗi trang (>=1)
     * @param keyword   từ khoá tìm kiếm, null/blank nếu không lọc
     */
    public List<ContactRecord> findAll(int page, int pageSize, String keyword) throws SQLException {
        int offset = Math.max(0, (Math.max(1, page) - 1) * Math.max(1, pageSize));
        boolean hasKw = keyword != null && !keyword.trim().isEmpty();
        String kw = hasKw ? "%" + keyword.trim() + "%" : null;

        final String base =
            "FROM ContactMessages " +
            (hasKw ? "WHERE (FullName LIKE ? OR Email LIKE ? OR Subject LIKE ? OR Message LIKE ?) " : "") +
            "ORDER BY CreatedAt DESC " +
            "LIMIT ?, ?"; // MySQL: LIMIT offset, row_count (dùng 2 tham số)

        final String sql = "SELECT * " + base;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int i = 1;
            if (hasKw) {
                ps.setString(i++, kw);
                ps.setString(i++, kw);
                ps.setString(i++, kw);
                ps.setString(i++, kw);
            }
            ps.setInt(i++, offset);
            ps.setInt(i, Math.max(1, pageSize));

            try (ResultSet rs = ps.executeQuery()) {
                List<ContactRecord> list = new ArrayList<>();
                while (rs.next()) list.add(map(rs));
                return list;
            }
        }
    }

    /** Đếm tổng số bản ghi (phục vụ phân trang admin) – có hỗ trợ keyword. */
    public int countAll(String keyword) throws SQLException {
        boolean hasKw = keyword != null && !keyword.trim().isEmpty();
        String kw = hasKw ? "%" + keyword.trim() + "%" : null;

        final String sql = "SELECT COUNT(*) FROM ContactMessages " +
                (hasKw ? "WHERE (FullName LIKE ? OR Email LIKE ? OR Subject LIKE ? OR Message LIKE ?)" : "");

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int i = 1;
            if (hasKw) {
                ps.setString(i++, kw);
                ps.setString(i++, kw);
                ps.setString(i++, kw);
                ps.setString(i, kw);
            }
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    /** Xoá 1 bản ghi theo Id. */
    public boolean deleteById(int id) throws SQLException {
        final String sql = "DELETE FROM ContactMessages WHERE Id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /** Map 1 hàng ResultSet -> ContactRecord. */
    private ContactRecord map(ResultSet rs) throws SQLException {
        ContactRecord r = new ContactRecord();
        r.id        = rs.getInt("Id");
        r.userId    = rs.getInt("UserID");
        r.fullName  = rs.getString("FullName");
        r.email     = rs.getString("Email");
        r.phone     = rs.getString("Phone");
        r.subject   = rs.getString("Subject");
        r.message   = rs.getString("Message");
        Timestamp ts= rs.getTimestamp("CreatedAt");
        r.createdAt = (ts == null ? null : new Date(ts.getTime()));
        return r;
    }
}
