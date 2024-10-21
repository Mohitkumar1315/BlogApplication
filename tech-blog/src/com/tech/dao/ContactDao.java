package com.tech.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.tech.entities.ContactUs;

public class ContactDao 
{
    private Connection con;

    public ContactDao(Connection con)
    {
        this.con = con;
    }
    public boolean saveContact(ContactUs cont)
    {
    	boolean f=false;
    	if(cont!=null)
    	{
    		try 
    		{
    		  String query="insert into contactus (email,name,message) values(?,?,?)";
    		  PreparedStatement p=con.prepareStatement(query);
    		  p.setString(1, cont.getEmail());
    		  p.setString(2, cont.getName());
    		  p.setString(3, cont.getMessage());
    		  p.executeUpdate();
    		  f=true;
    		} 
    		catch (Exception e) 
    		{
				e.printStackTrace();
			}
    	}
    	return f;
    	
    }
}
