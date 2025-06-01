<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sorry!Some thing went wrong</title>
</head>
<body>
	<%@include file="script.jsp"%>
	<div class="container text-center">
		<img  src="images/error.png" class="img-fluid">
		<h3 class="display-3">Sorry! Something went wrong...</h3>
		<%
		if(exception==null)
		{}
		else
		{
			%>
			<%=exception%>
			<% 
		}
		%>		
		<a href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home</a>	
	</div>
</body>
</html>