<%@page import="com.tech.dao.LikeDao"%>
<%@page import="com.tech.entities.Like"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.entities.Post"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.User"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Post Details</title>
<link href="CSS/style.css" rel='stylesheet'>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href="CSS/style.css" rel='stylesheet'>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		.banner-background{
			clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 96%, 63% 100%, 22% 91%, 0 99%, 0 0);
			
		}
	</style>
</head>
<body>
    <%
        // Fetching categories
        PostDao postDao = new PostDao(ConnectionProvider.getConnection());
        List<Category> categories = postDao.getCategories();

        // Retrieve post ID from request parameter
        int pId = 0;
       	System.out.println("Post id geted from the page :"+request.getParameter("post_id")+"");
        if (request.getParameter("post_id") != null) {
            try {
                pId = Integer.parseInt(request.getParameter("post_id"));
            } catch (NumberFormatException e) {
                out.println("<h3>Invalid Post ID.</h3>");
                return;
            }
        }
        Post post = postDao.getPostByPostId(pId);
        if (post == null) {
            out.println("<h3>Post not found.</h3>");
            return;
        }
    %>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark primary-background">
        <a class="navbar-brand" href="index.jsp">
            <span class="fa fa-american-sign-language-interpreting"></span> Tech Blog
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">
                        <span class="fa fa-home"></span> mk1315codes_learning <span class="sr-only">(current)</span>
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="fa fa-check-square-o"></span> Categories
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <% for (Category cat : categories) { %>
                            <a class="dropdown-item" href="category_page.jsp?category_id=<%= cat.getCid() %>"><%= cat.getName() %></a>
                        <% } %>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-link"></span> More...</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="contact.jsp">
                        <span class="fa fa-address-book-o"></span> Contact
                    </a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </nav>
    <!-- Navbar End -->

    <!-- Post Details -->
    <div class="container text-center">
        <div class="row my-4">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header">
                        <h4 class="post-title"><%= post.getpTitle() %></h4>
                    </div>
                    <div class="card-body">
                        <p class="post-content"><%= post.getpContent() %></p>
                        <hr>
                        <h5 style="float:left"><i>Example...</i></h5><br><br>
                        <div class="post-code">
                            <pre class="post-code"><%= post.getpCode() %></pre>
                        </div>
                    </div>
                    <div class="card-footer">
                        <%
                            LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                            int countLike = likeDao.countLikeOnPost(post.getPid());
                        %>
                        <span><strong>Likes:</strong> <%= countLike %></span>
                    </div>
                </div>
            </div>
        </div>
    </div>    
</body>
</html>
