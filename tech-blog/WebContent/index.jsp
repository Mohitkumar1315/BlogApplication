<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.Post"%>
<%@page contentType="texthtml"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.tech.helper.*"%>
<html>
<%
    PostDao postdao = new PostDao(ConnectionProvider.getConnection());
    ArrayList<Category> catList = postdao.getCategories();
%>
<head>
    <title>Tech Blog</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="CSS/style.css" rel='stylesheet'>
    <style>
       		.banner-background{
			clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 96%, 63% 100%, 22% 91%, 0 94%, 0 0);
		}
		 .card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transform: scale(1.05);
            transition: all 0.5s ease;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="normal_navbar.jsp"%>
    <!-- Banner -->
    <div class="container-fluid p-0 m-0 banner-background">
        <div class="jumbotron primary-background text-white">
            <div class="container">
                <h3 class="display-3">Welcome to Tech Blog</h3>
                <p>Welcome to the technical blog, a world of technology!</p>
                <p>Programming languages share properties with natural languages related to their purpose as vehicles for communication.</p>
                <button class="btn-outline-light btn-lg">
                    <span class="fa fa-user-plus"></span> Start! It's free
                </button>
                <a href="login_page.jsp" class="btn btn-outline-light btn-lg">
                    <span class="fa fa-user-o fa-spin"></span> Login Here
                </a>
            </div>
        </div>
    </div>

    <!-- Categories and Main Content -->
    <div class="container mt-3">
        <div class="row">
            <!-- Sidebar (Categories) -->
            <div class="col-md-3" id="sidebar">
                <div class="list-group">
                    <a href="#" onclick="getPost(0, this)" class="c-link list-group-item list-group-item-action active" aria-current="true">All Posts</a>
                    <% for (Category cat : catList) { %>
                        <a href="#" onclick="getPost(<%= cat.getCid() %>, this)" class="c-link list-group-item list-group-item-action" aria-current="true">
                            <%= cat.getName() %>
                        </a>
                    <% } %>
                </div>
            </div>
            <!-- Main Content -->
            <div class="col-md-9" id="main-content">
                <h2>Welcome to the Blogs</h2>
                <p>Select a category from the sidebar to explore related blogs.</p>
                <%
                    ArrayList<Post> allpost = postdao.getAllPost();
                    for (Post p : allpost) {
                %>
                    <div class="post-card">
                        <div class="post-title"><%= p.getpTitle() %></div>
                        <p class="post-excerpt">
                            <!-- Optional: Add a short excerpt of the content -->
                            This is a preview of the post. Click "Read More" to view full details.
                        </p>
                        <button class="read-more-btn">Read More</button>
                    </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7HibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script>
    function readMore(postId) {
        // Redirect to a detailed post page or load post details dynamically
        window.location.href = `post_details.jsp?postId=${postId}`;
    }
</script>
</html>
