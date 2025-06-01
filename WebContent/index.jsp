<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.Post"%>
<%@page contentType="text/html"%>
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
    	
        .banner-background {
            clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 96%, 63% 100%, 22% 91%, 0 94%, 0 0);
        }
        .card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transform: scale(1.05);
            transition: all 0.5s ease;
        }
        .category-link:hover {
            background-color: #f8f9fa;
            color: #007bff;
            cursor: pointer;
        }
        .active-category {
            background-color: #007bff;
            color: white;
        }
        .post-card {
            cursor: pointer;
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
                    <a href="#" onclick="getPost(0, this)" class="category-link list-group-item list-group-item-action active-category" aria-current="true">All Posts</a>
                    <% for (Category cat : catList) { %>
                        <a href="#" onclick="getPost(<%= cat.getCid() %>, this)" class="category-link list-group-item list-group-item-action" aria-current="true">
                            <%= cat.getName() %>
                        </a>
                    <% } %>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9" id="main-content">
                <h2 >Welcome to the Blogs</h2>
                <p>Select a category from the sidebar to explore related blogs.</p>
                <div id="post-container">
                    <!-- Posts will be loaded here -->
                </div>
           </div>
        </div>
    </div>
       
 <footer class="footer mt-5 py-4 primary-background text-white">
        <div class="container">
            <div class="row">
                <!-- Logo and About -->
                <div class="col-md-4">
                    <h4 class="mb-3">LCWM LOGO</h4>
                    <p><strong><u>Learn Code With KaBir</u></strong></p>
                    <p>Learn Code With KaBir offers a wide variety of free and premium courses on the YouTube channel and website. We are serving lakhs of students and professionals.</p>
                    <p><strong>!! Happy Coding !!</strong></p>
                </div>

                <!-- . Products -->
                <div class="col-md-4">
                    <h5 class="mb-3">Products</h5>
                    <ul class="list-unstyled">
                        <li>Master Spring Boot With Project Course</li>
                        <li>React Js Ecommerce Project Course</li>
                        <li>React + Spring Boot Full Stack</li>
                        <li>Free Courses</li>
                    </ul>
                </div>

                <!-- Contact -->
                <div class="col-md-4">
                    <h5 class="mb-3">Contact</h5>
                    <p>KaBir s/w solution Technologies, Saharanpur, INDIA,247451</p>
                    <p>Email: mvkrampur1315@gmail.com</p>
                    <p>Phone: +91-7895569366</p>
                    <h6 class="mt-3">Get In Touch</h6>
                    <div>
                        <a href="#" class="text-white mr-3" aria-label="YouTube"><span class="fa fa-youtube"></span> YouTube</a>
                        <a href="#" class="text-white mr-3" aria-label="Facebook"><span class="fa fa-facebook"></span> Facebook</a>
                        <a href="#" class="text-white mr-3" aria-label="Instagram"><span class="fa fa-instagram"></span> Instagram</a>
                        <a href="#" class="text-white" aria-label="LinkedIn"><span class="fa fa-linkedin"></span> LinkedIn</a>
                    </div>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col text-center">
                    <p>Copyright © 2023: Substring Technologies Pvt Ltd. All Rights Reserved.</p>
                    <a href="#" class="text-white">Refund Policy</a> | 
                    <a href="#" class="text-white">Privacy Policy</a> | 
                    <a href="#" class="text-white">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7HibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    
    <script>
        // Function to load posts based on category selection
        
      function getPost(catId, element)
      {
      	console.log("Test");
    // Change the active class for categories
    $('.list-group-item').removeClass('active');
    $(element).addClass('active');

    // Make an AJAX request to fetch posts based on the category
    $.ajax({
        url: 'getPosts.jsp',  // Correct URL to your JSP file that returns posts
        method: 'GET',
        data: { categoryId: catId },  // Send the selected category ID
        success: function(response) {
            $('#post-container').html(response);  // Update the posts section with new data
        },
        error: function(error) {
            console.log("Error fetching posts:", error);
        }
    });
}

// To show all posts by default
$(document).ready(function() {
    getPost(0, $(".list-group-item")[0]); // Show all posts when the page loads
});


    </script>
</body>
</html>
