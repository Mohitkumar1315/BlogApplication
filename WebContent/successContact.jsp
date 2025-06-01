<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Success!</title>
<style>        
     #success {
        filter: drop-shadow(10px 7px 10px orange);
    }
</style>
</head>
<body>
	<%@include file="script.jsp"%>
	<div class="container text-center">	
		<h3 class="display-3" style="margin-top:50px" id="success">We will be in touch shortly. Thank you for your patience....</h3>
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
		<a href="index.jsp" class="btn primary-background btn-sm text-white mt-3">Home</a>	
	</div>
</body>
</html>