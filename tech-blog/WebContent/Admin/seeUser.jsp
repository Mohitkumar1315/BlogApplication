<%@page import="com.tech.entities.User"%>
<%@page import="com.tech.dao.UserDao"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	UserDao userDao=new UserDao(ConnectionProvider.getConnection());
	List<User>userList=userDao.getUser();
	System.out.println("UserList:"+userList);
%>
<%
for (User user : userList) {
%>
<tr>
<td><%= user.getId() %></td>
<td><%= user.getName() %></td>
<td><%= user.getEmail() %></td>
<td>
    <a href="#">Delete</a> |
    <a href="#">View</a>
</td>
</tr>
<% } %>
