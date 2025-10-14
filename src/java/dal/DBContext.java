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
            // ----- CHECK THESE CONNECTION PARAMETERS CAREFULLY -----
            String serverName = "DOCKUMMMK\\MSSQLSERVER"; // This is your server name
            String dbName = "LuxeHomeDB";
            String port = "1433";
            String user = "sa";
            String pass = "Mdang2186"; // Your password
            // --------------------------------------------------------

            String url = String.format("jdbc:sqlserver://%s:%s;databaseName=%s;encrypt=true;trustServerCertificate=true;",
                                       serverName, port, dbName);

            System.out.println("Connecting to database with URL: " + url);

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);

            if (connection != null) {
                System.out.println("SUCCESS: Database connection established!");
            }

        } catch (ClassNotFoundException ex) {
            // This error means the JDBC driver JAR is missing from Libraries
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "FATAL ERROR: SQL Server JDBC Driver not found in project libraries.", ex);
        } catch (SQLException ex) {
            // This error means the connection parameters or server configuration is wrong
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "FATAL ERROR: Failed to connect to the database. Check connection string, server status, TCP/IP protocol, and firewall.", ex);
        }
    }
}