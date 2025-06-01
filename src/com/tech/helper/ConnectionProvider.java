package com.tech.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
    private static Connection con;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Use Railway's MySQL URL, user, and password here
                String url = "jdbc:mysql://tramway.proxy.rlwy.net:19045/railway";
                String user = "root";
                String password = "LUdkBQVHTJofYxynCqROfnLOwWnKiYXu";

                con = DriverManager.getConnection(url, user, password);
                // System.out.println("Connected to Railway DB...");
            }
        } catch (Exception ex) {
            System.out.println("Database connection failed: " + ex);
        }
        return con;
    }
}
