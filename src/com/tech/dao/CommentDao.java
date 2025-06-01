package com.tech.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CommentDao 
{	
	
	Connection con;
	public  CommentDao(Connection con)
	{
		this.con=con;
	}
	 public boolean doComment(int userid, int postid, String cmt)
	{
		 System.out.print("userID "+userid+"postid:"+postid+"cmt:"+cmt);
		boolean f=false;
		try 
		{
			String query="insert into Comments(userid,postId,cmt) values(?,?,?)";
			PreparedStatement stmt=con.prepareStatement(query);
			stmt.setInt(1, userid);
			stmt.setInt(2, postid);
			stmt.setString(3,cmt);	
			stmt.executeUpdate();
			f=true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}		
		return f;
	}
}
