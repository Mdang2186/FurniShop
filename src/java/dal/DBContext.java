package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
            // ----- CẤU HÌNH KẾT NỐI TỚI MYSQL (XAMPP) -----
            String hostName = "localhost";
            String dbName = "furnishop";
            String port = "3306";
            String user = "root"; 
            String pass = ""; // Mật khẩu mặc định của XAMPP là rỗng

            String url = "jdbc:mysql://" + hostName + ":" + port + "/" + dbName + "?useSSL=false&serverTimezone=UTC";
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, pass);

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Database connection failed", ex);
        }
    }
}