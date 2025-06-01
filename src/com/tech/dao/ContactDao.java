package com.tech.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tech.entities.ContactUs;

public class ContactDao {
    private Connection con;

    public ContactDao(Connection con) {
        this.con = con;
    }

    public boolean saveContact(ContactUs cont) {
        boolean f = false;
        if (cont != null) {
            try {
                String query = "INSERT INTO contactus (email, name, message) VALUES (?, ?, ?)";
                PreparedStatement p = con.prepareStatement(query);
                p.setString(1, cont.getEmail());
                p.setString(2, cont.getName());
                p.setString(3, cont.getMessage());
                p.executeUpdate();
                f = true;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return f;
    }

    public List<ContactUs> getContactsByPage() {
        List<ContactUs> contactList = new ArrayList<>();
        if (con != null) {
            try {
               // int start = (page - 1) * pageSize;
                String query = "SELECT * FROM contactus";
                PreparedStatement p = con.prepareStatement(query);
//                p.setInt(1, start);
//                p.setInt(2, pageSize);
                ResultSet set = p.executeQuery();

                while (set.next()) {
                    String email = set.getString("email");
                    String message = set.getString("message");
                    String name = set.getString("name");
                    ContactUs contacts = new ContactUs(email, name, message);
                    contactList.add(contacts);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return contactList;
    }

    public int getTotalContacts() {
        int total = 0;
        if (con != null) {
            try {
                String query = "SELECT COUNT(*) AS total FROM contactus";
                PreparedStatement p = con.prepareStatement(query);
                ResultSet set = p.executeQuery();
                if (set.next()) {
                    total = set.getInt("total");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return total;
    }
    public boolean deleteContactByMail(String email)
    {
    	System.out.println("test...");
    	boolean  deleteContactflag=false;
    	try {
			String query="delete from contactus where email=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setString(1,email);
			int deleteRow=pst.executeUpdate();
			if(deleteRow>0)
			{
				deleteContactflag=true;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
    	return deleteContactflag;
    }
}
