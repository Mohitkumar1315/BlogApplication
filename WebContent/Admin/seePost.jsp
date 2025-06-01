<%@page import="com.tech.entities.Post"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.ContactUs"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.dao.ContactDao"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	PostDao postDao=new PostDao(ConnectionProvider.getConnection());
	List<Post> postList=postDao.getAllPost();
%>
<%
    for (Post post : postList) {
%>
<tr>
	<td><%=post.getPid()%></td>
	<td><%=post.getpTitle()%></td>
	<td><%=post.getUser_id() %></td> 
    <td>
        <a href="<%= request.getContextPath() %>/AddPostServlet?pId=<%= post.getPid()%>">Delete Post</a> |
        <a href="">View Post</a>
    </td>
</tr>
<%
    }
%>

