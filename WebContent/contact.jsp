<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.dao.PostDao"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>



</script>
</head>
<body>
	<%@include file="script.jsp"%>
<%
		PostDao postDao=new PostDao(ConnectionProvider.getConnection());
		List<Category> categories=postDao.getCategories();
	%>	
<nav class="navbar navbar-expand-lg navbar-dark primary-background">
  <a class="navbar-brand" href="index.jsp"><span class="	fa fa-american-sign-language-interpreting"></span>Tech Blog</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">
        <span class="fa fa-home"></span>
        Home <span class="sr-only">(current)</span></a>
      </li>
     
      <li class="nav-item dropdown">
     
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         <span class="fa fa-check-square-o"></span>
          Cetegory
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <%
          	for(Category cat:categories)
          	{
          		%>
          			<a class="dropdown-item" href="#"><%=cat.getName() %></a>
          		<% 
          	}
          %>     
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
        <span class="	fa fa-link"></span>
        More...
        </a>
      </li>     
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
    <div class="container">
        <h2>Contact Us</h2>
        <form action="ContactUs_Servlet" id="contact-form" method="post">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" placeholder="Your name.." required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email"placeholder="Your email.." required>

            <label for="message">Message</label>
            <textarea id="message" name="message" placeholder="Write something.." style="height:200px" required></textarea>

            <button type="submit" id="btn_submit" class="btn primary-background text-white">Submit</button>
        </form>
    </div>
</body>
</html>
