package com.tech.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
    private static Connection con;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");

                // ✅ Public proxy URL from Railway
                String url = "jdbc:mysql://tramway.proxy.rlwy.net:19045/railway";
                String user = "root";
                String password = "LUdkBQVHTJofYxynCqROfnLOwWnKiYXu";

                con = DriverManager.getConnection(url, user, password);
                System.out.println("Connected to Railway DB");
            }
        } catch (Exception ex) {
            System.out.println("Database connection failed: " + ex);
        }
        return con;
    }
}

//package com.tech.helper;
//import java.sql.*;
//public class ConnectionProvider 
//{
//	private static Connection con;
//	public static  Connection getConnection()
//	{
//		try 
//		{
//			if(con==null)
//			{
//				Class.forName("com.mysql.cj.jdbc.Driver");
//			    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techBlock_jsp","root","root");
//				//System.out.println("Connected...");
//			}
//		}
//		catch(Exception ex)
//		{
//			System.out.println(ex);
//		}
//		return con;
//	}