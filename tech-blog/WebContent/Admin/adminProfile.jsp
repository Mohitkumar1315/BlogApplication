<%@page import="com.tech.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="../CSS/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .contact-list {
            display: none;
            margin-top: 20px;
        }
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
                    <span class="fa fa-address-book-o"></span> See Contacts
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

<!-- Contact List Div -->
<div class="container">
    <div id="contactList" class="contact-list">
        <h3>ContactList</h3>
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
</div>

<script src="https://code.jquery.com/jquery-3.6.3.min.js" crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {
        $('#seeContactsLink').click(function (e) {
            e.preventDefault();

            // Show loading spinner or message
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
    });
</script>
</body>
</html>
