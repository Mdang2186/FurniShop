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
            // ----- FINAL CONNECTION PARAMETERS -----
            // Based on your screenshots, these should be correct.
            
            String serverName = "DOOKUMMINK\\MSSQLSERVER01"; 
            String dbName = "LuxeHomeDB";
            String port = "1433"; // We will verify this in the next step
            String user = "sa";
            String pass = "Mdang2186";

            // -----------------------------------------

            String url = String.format("jdbc:sqlserver://%s:%s;databaseName=%s;encrypt=true;trustServerCertificate=true;",
                                       serverName, port, dbName);

            System.out.println("Attempting to connect with URL: " + url);

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);

            if (connection != null) {
                System.out.println("SUCCESS: Database connection established!");
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "FATAL ERROR: SQL Server JDBC Driver not found in project libraries.", ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "FATAL ERROR: Connection Failed! Check credentials, server name, port, and SQL service status.", ex);
        }
    }
}