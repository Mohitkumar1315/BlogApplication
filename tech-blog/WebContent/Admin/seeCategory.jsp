<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.ContactUs"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.dao.ContactDao"%>

<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	PostDao postDao=new PostDao(ConnectionProvider.getConnection());
	List<Category> categoriesList=postDao.getCategories();
%>
<%
    for (Category catgory : categoriesList) {
%>
<tr>
	<td><%=catgory.getCid()%></td>
	<td><%=catgory.getName()%></td>
    <td>
        <a href="">Delete</a> |
        <a href="#">Update</a> |
        <a href="#">Add</a>
    </td>
</tr>
<%
    }
%>
