package com.tech.entities;

import java.sql.*;

public  class User 
{
    private int id;
    private String name;
    private String email;
    private String password;
    private String gender;
    private String about;
    private Timestamp rdate;
    private String profile;
    private String userRole;
    
    public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	public User() {
    }

    //constructor 1
    public User(int id ,String name, String email, String password, String gender, String about, Timestamp rdate,String profile,String userRole) {
        this.id=id;
    	this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.rdate=rdate;
        this.profile=profile;
        this.userRole=userRole;
    }
    //constructor 2 without passing  id 
    public User(String name, String email, String password, String gender, String about, Timestamp rdate,String profile,String userRole) 
    {
    	this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.rdate=rdate;
        this.profile=profile;
        this.userRole=userRole;
    }
    
//  getter & setters
    public int getId() {
        return id;
    }

    public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public Timestamp getRdate() {
        return rdate;
    }

    public void setRdate(Timestamp rdate) {
        this.rdate = rdate;
    }

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", gender="
				+ gender + ", about=" + about + ", rdate=" + rdate + ", profile=" + profile + "]";
	}
    
}