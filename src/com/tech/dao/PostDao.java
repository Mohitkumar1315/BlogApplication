package com.tech.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tech.entities.Category;
import com.tech.entities.Post;

public class PostDao 
{
	
    private Connection con;
    public PostDao(Connection con)
    {
        this.con = con;
    }
    public ArrayList<Category> getCategories()
    {
        ArrayList<Category> categoriesList = null;
        try {
            String query = "select * from categories";
            Statement s = this.con.createStatement();
            ResultSet set = s.executeQuery(query);
            categoriesList = new ArrayList<>();
            while (set.next())
            {
               int cid=set.getInt("cid");
               String name=set.getString("name");
               String description=set.getString("description");
               System.out.println("cid:"+cid+"name:"+name+"");
               Category cat=new Category(cid,name,description);
               categoriesList.add(cat);
            }
        } catch (Exception e) 
        {
            e.printStackTrace();
        }
        return categoriesList;
    }
    public boolean savePost(Post post)
    {
    	boolean f=false;
    	try {
    		String query="insert into post (pTitle,pContent,pCode,pPic,catId,user_id)values(?,?,?,?,?,?)";
			PreparedStatement pst=con.prepareStatement(query);
			pst.setString(1, post.getpTitle());
			pst.setString(2, post.getpContent());
			pst.setString(3, post.getpCode());
			pst.setString(4, post.getpPic());
			pst.setInt(5, post.getCatId());
			pst.setInt(6, post.getUser_id());
			pst.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return  f;
    }
    public ArrayList<Post> getAllPost() throws SQLException
    {
    	String query="select * from post";
    	Statement s=this.con.createStatement();
    	ResultSet set=s.executeQuery(query);
    	ArrayList<Post> postlist=new ArrayList<Post>();
    	while(set.next())
    	{
    		Post p=new Post();
    		p.setCatId(set.getInt("catId"));
    		p.setpCode(set.getString("pCode"));
    		p.setpContent(set.getString("pContent"));
    		p.setpDate(set.getTimestamp("pDate"));
    		p.setPid(set.getInt("pId"));
    		p.setpPic(set.getString("pPic"));
    		p.setpTitle(set.getString("pTitle"));
    		p.setUser_id(set.getInt("user_id"));
    		postlist.add(p);
    	}    
    	return  postlist;
    }
    public int getPostCout()
    {
    	int totalPost=0;
    	try {
			String query="select count(pId) from post";
			Statement s=this.con.createStatement();
			ResultSet set=s.executeQuery(query);
			if(set.next())
			{
				totalPost=set.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return totalPost;
    }
    public List<Post> getPostById(int cid ,int userId)
    {
    	System.out.println("Cat id :"+cid+"and USerId"+userId+"");
    	ArrayList<Post> postList=new ArrayList<Post>();
    	try {
    		String query="select * from post where catId=? and user_id=?";
    		PreparedStatement pst=con.prepareStatement(query);
    		pst.setInt(1, cid);
    		pst.setInt(2, userId);
    		ResultSet set=pst.executeQuery();
    		while(set.next())
        	{
        		Post p=new Post();
        		p.setCatId(set.getInt("catId"));
        		p.setpCode(set.getString("pCode"));
        		p.setpContent(set.getString("pContent"));
        		p.setpDate(set.getTimestamp("pDate"));
        		p.setPid(set.getInt("pId"));
        		p.setpPic(set.getString("pPic"));
        		p.setpTitle(set.getString("pTitle"));
        		p.setUser_id(set.getInt("user_id"));
        		postList.add(p);
        	}			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return postList;
    			
    }
    public Post getPostByPostId(int postId)
    {
    	Post p=null;
    	String query="select * from post where pId=?";
    	try
    	{
    		PreparedStatement pst=this.con.prepareStatement(query);
        	pst.setInt(1, postId);
        	ResultSet set=pst.executeQuery();
        	while(set.next())
        	{
        		p=new Post();
        		p.setCatId(set.getInt("catId"));
        		p.setpCode(set.getString("pCode"));
        		p.setpContent(set.getString("pContent"));
        		p.setpDate(set.getTimestamp("pDate"));
        		p.setPid(set.getInt("pId"));
        		p.setpPic(set.getString("pPic"));
        		p.setpTitle(set.getString("pTitle"));
        		p.setUser_id(set.getInt("user_id"));
        	}
        		
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
    	
    	return p;
    }
    public ArrayList<Post> getPostByCatId(int catId) {
    	System.out.println("Get all post using CatID");
        ArrayList<Post> postList = new ArrayList<>();
        String query = "select * from post where catId=?";
        try {
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, catId);
            ResultSet set = pst.executeQuery();
            while (set.next()) {
                Post p = new Post();
                p.setCatId(set.getInt("catId"));
                p.setpCode(set.getString("pCode"));
                p.setpContent(set.getString("pContent"));
                p.setpDate(set.getTimestamp("pDate"));
                p.setPid(set.getInt("pId"));
                p.setpPic(set.getString("pPic"));
                p.setpTitle(set.getString("pTitle"));
                p.setUser_id(set.getInt("user_id"));
                postList.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return postList;
    }
    public int getCatgoryCont()
    {
    	int totalCategory=0;
    	try {
			String query="select count(cid) from categories";
			Statement s=this.con.createStatement();
			ResultSet set=s.executeQuery(query);
			if(set.next())
			{
				totalCategory=set.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
    	return totalCategory;
    }
    public boolean deletePostByPostId(String postid)
    {
    	int pId=Integer.parseInt(postid);
    	boolean isPostDelete=false;
    	try {
			String query="delete from post where pId=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, pId);
			int deletePost=pst.executeUpdate();
			if(deletePost>0)
			{
				isPostDelete=true;
			}
		} catch (Exception e)
    	{
			e.printStackTrace();
		}
    	return isPostDelete;   	
    }
    public boolean deletePostByUserId(String userid)
    {
    	if (userid == null || userid.isEmpty()) {
    	    throw new IllegalArgumentException("User ID cannot be null or empty");
    	}
    	System.out.println("You are in Delete User method in PostDao");
    	boolean isPostDelete=false;
    	int userId=Integer.parseInt(userid);
    	try {
			String query="delete from post where user_id=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, userId);
			int deletePost=pst.executeUpdate();
			if(deletePost>0)
			{
				isPostDelete=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return isPostDelete;
    }
    public boolean deleteAllPostByCategory(int catId)
    {   	
    	boolean isdeleted=false;
    	//int catid=Integer.parseInt(catId);
    	try {
			String query="delete from post where catId=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, catId);
			int deletepost=pst.executeUpdate();
			if(deletepost>0)
			{
				isdeleted=true;
			}
    	} catch (Exception e)
    	{
			e.printStackTrace();
		}
    	
    	return isdeleted;
    }
}
