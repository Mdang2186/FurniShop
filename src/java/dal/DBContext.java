package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.*;

public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
            String host = "localhost";
            String db   = "furnishop";
            String port = "3306";
            String user = "root";
            String pass = ""; // XAMPP mặc định rỗng

            // UTF-8 + TZ + fix PublicKey
            String url = "jdbc:mysql://" + host + ":" + port + "/" + db
                    + "?useUnicode=true"
                    + "&characterEncoding=UTF-8"
                    + "&serverTimezone=Asia/Ho_Chi_Minh"
                    + "&useSSL=false"
                    + "&allowPublicKeyRetrieval=true";

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, pass);

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName())
                  .log(Level.SEVERE, "Database connection failed", ex);
        }
    }

    /** Tuỳ lúc có DAO cần lấy connection trực tiếp. */
    public Connection getConnection() { return connection; }
}
