<%@page import="com.tech.entities.ContactUs"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.dao.ContactDao"%>

<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get the contact list from the database
    ContactDao contactDao = new ContactDao(ConnectionProvider.getConnection());
    List<ContactUs> contactList = contactDao.getContactsByPage();	
%>
<%
    for (ContactUs contact : contactList) {
%>
<tr>
    <td><%= contact.getName() %></td>
    <td><%= contact.getEmail() %></td>
    <td><%= contact.getMessage() %></td>
    <td>
        <a href="<%= request.getContextPath() %>/ContactUs_Servlet?email=<%= contact.getEmail() %>">Delete</a> |
        <a href="https://mail.google.com/mail/u/0/#inbox/FMfcgzQXKWpRNkmdKXZbLRlFTtSVFNfh?compose=new">Revert</a>
    </td>
</tr>
<%
    }
%>
