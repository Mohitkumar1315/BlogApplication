package com.tech.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.tech.helper.ConnectionProvider;

public class LikeDao 
{
	Connection con;
	public LikeDao(Connection con)
	{
		this.con=con;
	}
	public boolean insertLike(int pid,int uid)
	{
		boolean f=false;
		try 
		{
			String query="insert into Liked(pid,uid) values(?,?)";
			PreparedStatement stmt=this.con.prepareStatement(query);
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);
			stmt.executeUpdate();
			f=true;
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return f;
	}
	public int countLikeOnPost(int pid)
	{
		int count=0;
		try 
		{
			System.out.println("Heloo testu");
			String query="select count(*) from liked where pid=?";
			PreparedStatement stmt=con.prepareStatement(query);
			stmt.setInt(1,pid);
			ResultSet set=stmt.executeQuery();
			if(set.next())
			{
				count=set.getInt(1);
				System.out.println("Count in testu"+count);
				
			}			
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return count;
	}	
	public boolean isLikeByUser(int userId, int postid)
	{
		boolean f=false;
		try 
		{
			String query="select * from Liked where uid=? and pid=?";
			PreparedStatement stmt=con.prepareStatement(query);
			stmt.setInt(1, userId);
			stmt.setInt(2, postid);
			ResultSet set=stmt.executeQuery();
			if(set.next())
			{
				f=true;
			}
		}
		catch (Exception e) 
		{
			// TODO: handle exception
			e.printStackTrace();
		}
		return f;
	}
	public  boolean DisLike(int userId, int postId)
	{
		System.out.println("USer id in :"+userId+"");
		boolean f=false;
		try {
			String query="delete from Liked where pid=? and uid=?";
			System.out.println(query);
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setInt(1,postId);
			pstmt.setInt(2, userId);
			pstmt.executeUpdate();
			f=true;
		} catch (Exception e) 
		{
			// TODO: handle exception
			e.printStackTrace();
		}
		return f;
	}
}
