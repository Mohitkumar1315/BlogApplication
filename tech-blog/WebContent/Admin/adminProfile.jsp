<%@page import="com.tech.dao.ContactDao"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="../CSS/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script type="text/javascript" src="../JS/admin.js"></script>
    <style>
        body {
            background-color: #f4f4f4;
        }
        .dashboard {
            margin-top: 20px;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .card-title {
            font-size: 1.5rem;
        }
        .icon {
            font-size: 3rem;
        }
        .contact-list {
            margin-top: 20px;
        }
        .category-list{
        marrgin-top:30px
        }
        .post-list{
        marrgin-top:30px
        }
        .user-list{
        margin:30x}
    </style>
</head>
<body>
<%
    User user = (User) session.getAttribute("current_user");
    if (user == null) {
        response.sendRedirect("../login_page.jsp");
    }
%>
<nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="../index.jsp">
        <span class="fa fa-american-sign-language-interpreting"></span> Tech Blog
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="adminProfile.jsp"><span class="fa fa-home"></span> Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" id="seeContactsLink">
                    <span class="fa fa-address-book-o"></span>Contacts
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" id="seeCategoryLink">
                    <span class="fa fa-shopping-bag"></span> Categories
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" id="seePostLink">
                     <span class="fa fa-asterisk"></span>Posts
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" id="seeUserLink">
                     <span class="fa fa-user-o"></span>Users
                </a>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="Logout_Servlet">
                    <span class="fa fa-sign-out"></span> Log out
                </a>
            </li>
        </ul>
    </div>
</nav>

<!-- Dashboard -->
<div class="container dashboard">
    <div class="row">
        <!-- Total Posts -->
        <div class="col-md-4">
            <div class="card text-center text-white bg-primary">
                <div class="card-body">
                    <i class="fa fa-file-text icon"></i>
                    <h5 class="card-title">Total Posts</h5>
                    <p class="card-text">
                        <%-- Fetch total posts from the database --%>
                        <%
                            int totalPosts = 0; // Replace with actual DB query
                            PostDao postDao=new PostDao(ConnectionProvider.getConnection());
                            totalPosts=postDao.getPostCout();
                            out.print(totalPosts);
                        %>
                    </p>
                </div>
            </div>
        </div>
        <!-- Total Categories -->
        <div class="col-md-4">
            <div class="card text-center text-white bg-success">
                <div class="card-body">
                    <i class="fa fa-list-alt icon"></i>
                    <h5 class="card-title">Total Categories</h5>
                    <p class="card-text">
                        <%-- Fetch total categories from the database --%>
                        <%
                            int totalCategories = 0; // Replace with actual DB query
                            PostDao posDao=new PostDao(ConnectionProvider.getConnection());
                            totalCategories=posDao.getCatgoryCont();
                            out.print(totalCategories);
                        %>
                    </p>
                </div>
            </div>
        </div>
        <!-- Total Contacts -->
        <div class="col-md-4">
            <div class="card text-center text-white bg-warning">
                <div class="card-body">
                    <i class="fa fa-envelope icon"></i>
                    <h5 class="card-title">Total Contacts</h5>
                    <p class="card-text">
                        <%-- Fetch total contacts from the database --%>
                        <%
                            int totalContacts = 0; // Replace with actual DB query
                           	ContactDao contactDao=new ContactDao(ConnectionProvider.getConnection());
                            totalContacts=contactDao.getTotalContacts();
                            out.print(totalContacts);
                        %>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- If there are  changes are do by the admin here show the message of success or failed -->
<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");

    if ("deleted".equals(success)) {
%>
        <div class="alert alert-success"style="align-content: center">Contact deleted successfully.</div>
<%
    } else if ("notDeleted".equals(error)) {
%>
        <div class="alert alert-danger"style="align-content: center">Failed to delete contact. Try again.</div>
<%
    }
%>
<!-- Contact List Div -->
<div class="container">
    <div id="contactList" class="contact-list" style="display: none;">
        <h3>Contact List</h3>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Message</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="contactTableBody">
            <!-- Contact list will be appended here -->
            </tbody>
        </table>
    </div>
    <!-- categories -->
    <div id="categoryList" class="category-list" style="display: none;">
        <table class="table table-bordered">
            
            <tbody id="categoryTableBody">
      			<!-- categorie is show here dyanmically using ajax request -->
            </tbody>
        </table>
    </div>
    <!-- Post -->
    <div id="postList" class="post-list" style="display: none;">
        <h3>Post List</h3>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>Post.Id</th>
                <th>Title</th>
                <th>User Name</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="postTableBody">
      			<!-- Post is show here dyanmically using ajax request -->
            </tbody>
        </table>
    </div>
    <!--Users-->
    <div id="userList" class="user-list" style="display: none;">
        <h3>User List</h3>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>Post.Id</th>
                <th>Title</th>
                <th>User Name</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="userTableBody">
      			<!-- Post is show here dyanmically using ajax request -->
            </tbody>
        </table>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.3.min.js" crossorigin="anonymous"></script>
<script>
$(document).ready(function () {
    $('#seeContactsLink').click(function (e) {
        e.preventDefault();

        $('#categoryList').hide();
        $('#postList').hide(); // Hide post list as well
        $('#userList').hide();
        $('#contactList').show();
        $('#contactTableBody').html('<tr><td colspan="4">Loading...</td></tr>');

        // Make AJAX request to fetch contact data
        $.ajax({
            url: 'seeContact.jsp',
            method: 'GET',
            success: function (response) {
                $('#contactTableBody').html(response);
            },
            error: function () {
                $('#contactTableBody').html('<tr><td colspan="4">Error fetching contacts.</td></tr>');
            }
        });
    });

    $('#seePostLink').click(function (e) {
        e.preventDefault();

        // Hide all sections except postList
        
        $('#contactList').hide();
        $('#categoryList').hide();
        $('#userList').hide();
        $('#postList').show();
        $('#postTableBody').html('<tr><td colspan="4">Loading...</td></tr>'); // Ensure the colspan matches the table structure

        // Make AJAX request to fetch post data
        $.ajax({
            url: 'seePost.jsp',
            method: 'GET',
            success: function (response) {
                $('#postTableBody').html(response);
            },
            error: function () {
                $('#postTableBody').html('<tr><td colspan="4">Error fetching posts.</td></tr>'); // Ensure the colspan matches
            }
        });
    });

    $('#seeCategoryLink').click(function (e) {
        e.preventDefault();

        $('#contactList').hide();
        $('#postList').hide(); // Hide post list as well
        $('#userList').hide();
        $('#categoryList').show();
        $('#categoryTableBody').html('<tr><td colspan="3">Loading...</td></tr>'); // Adjusted colspan

        // Make AJAX request to fetch category data
        $.ajax({
            url: 'seeCategory.jsp', // Ensure this JSP file is correct
            method: 'GET',
            success: function (response) {
                $('#categoryTableBody').html(response);
            },
            error: function () {
                $('#categoryTableBody').html('<tr><td colspan="3">Error fetching categories.</td></tr>'); // Adjusted colspan
            }
        });
    });
    
    $('#seeUserLink').click(function (e) {
        e.preventDefault();

        $('#contactList').hide();
        $('#postList').hide(); // Hide post list as well
        $('#categoryList').hide();
        $('#userList').show();
        $('#userTableBody').html('<tr><td colspan="3">Loading...</td></tr>'); // Adjusted colspan

        // Make AJAX request to fetch category data
        $.ajax({
            url: 'seeUser.jsp', // Ensure this JSP file is correct
            method: 'GET',
            success: function (response) {
                $('#userTableBody').html(response);
            },
            error: function () {
                $('#categoryTableBody').html('<tr><td colspan="3">Error fetching categories.</td></tr>'); // Adjusted colspan
            }
        });
    });
    
});

</script>
</body>
</html>
