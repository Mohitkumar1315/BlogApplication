package com.tech.entities;

public class Comments 
{
	private int cmtId;
	private String cmt;
	private int postId;
	private int userId;
	public Comments() {}
	public int getCmtId() 
	{
		return cmtId;
	}
	public void setCmtId(int cmtId) 
	{
		this.cmtId = cmtId;
	}
	public String getCmt() 
	{
		return cmt;
	}
	public void setCmt(String cmt) {
		this.cmt = cmt;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
}
