package com.tech.dao;
import java.sql.*;

import javax.servlet.http.HttpServletResponse;

import  com.tech.entities.*;
public class UserDao 
{
	private Connection con;

	public UserDao(Connection con) 
	{
		this.con = con;
	}
	//method for insert user into db table user
	public boolean SaveUser(User user)
	{
		boolean f=false;
		try {
			
			String query="insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
			PreparedStatement pstmt= this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			
			pstmt.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	public User getUserByEmailAndPassword(String email, String user_password,String loginRole) {
	    User user = null;
	    try {
	        String query = "select * from user where email=? and password=? and user_role=?";
	        PreparedStatement pst = con.prepareStatement(query);
	        pst.setString(1, email);
	        pst.setString(2, user_password);
	        pst.setString(3, loginRole);
	        ResultSet rs = pst.executeQuery();
	        if (rs.next()) 
	        {
	            user = new User();
	            user.setId(rs.getInt("id"));
	            user.setName(rs.getString("name"));
	            user.setPassword(rs.getString("password")); 
	            user.setEmail(rs.getString("email")); 
	            user.setAbout(rs.getString("about")); 
	            user.setGender(rs.getString("gender")); 
	            user.setRdate(rs.getTimestamp("rdate"));
	            user.setProfile(rs.getString("profile"));
	            user.setUserRole("user_role");
	        } 
	        else {	        
	            System.out.println("error");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}
	public User checkUser(String email) 
	{
		User user=null;
		try {
			String query="select * from user where email=? ";
			PreparedStatement pst = con.prepareStatement(query);
		    pst.setString(1, email);
		    ResultSet rs = pst.executeQuery();
		    if(rs.next())
		    {
		    	user=new User();
		    	 user.setId(rs.getInt("id"));
		            user.setName(rs.getString("name"));
		            user.setPassword(rs.getString("password")); 
		            user.setEmail(rs.getString("email")); 
		            user.setAbout(rs.getString("about")); 
		            user.setGender(rs.getString("gender")); 
		            user.setRdate(rs.getTimestamp("rdate"));
		            user.setProfile(rs.getString("profile"));
		    }
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		
		return user;
	}
	public boolean updateUser(User user)
	{
		boolean f=false;
		try {
			String qury="update user set name=?,email=?,password=?,profile=?  where id=?";
			PreparedStatement ps=con.prepareStatement(qury);
			ps.setString(1,user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getProfile());
			ps.setInt(5, user.getId());
			ps.execute();
			f=true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return f;
		
	}
	
}
