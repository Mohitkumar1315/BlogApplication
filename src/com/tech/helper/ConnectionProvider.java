package com.tech.helper;
import java.sql.*;
public class ConnectionProvider 
{
	private static Connection con;
	public static  Connection getConnection()
	{
		try 
		{
			if(con==null)
			{
				Class.forName("com.mysql.cj.jdbc.Driver");
			    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techBlock_jsp","root","root");
				//System.out.println("Connected...");
			}
		}
		catch(Exception ex)
		{
			System.out.println(ex);
		}
		return con;
	} 
}
