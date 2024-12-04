<%@page import="com.tech.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.Message"%>
<%@page import="com.tech.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Page</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href="../CSS/style.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		.banner-background{
			clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 96%, 63% 100%, 22% 91%, 0 99%, 0 0);
			
		}
	</style>
</head>
<body>
<%
	User user=(User)session.getAttribute("current_user");	
	if(user==null)
	{
		response.sendRedirect("login_page.jsp");
	}	
%>
		<nav class="navbar navbar-expand-lg navbar-dark primary-background">
  <a class="navbar-brand" href="../index.jsp"><span class="	fa fa-american-sign-language-interpreting"></span>Tech Blog</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">
        <span class="fa fa-home"></span>
        Home <span class="sr-only">(current)</span></a>
      </li>
     
      <li class="nav-item dropdown">
     
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         <span class="fa fa-check-square-o"></span>
          Cetegory
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Programing language</a>
          <a class="dropdown-item" href="#">Project Implemetation</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Data structure</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
        <span class="	fa fa-link"></span>
        More...
        </a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="contact.jsp">
               <span class="fa fa-address-book-o fa fa-address-card"></span>
        See Contacts</a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="#!" data-toggle="modal" data-target="#DoPost_model">  
               <span class="fa fa-asterisk"></span>
        Check Post</a>
      </li>     
    </ul>
    <ul class="navbar-nav mr-right">
       <li class="nav-item">
        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile_details">
               <span class="fa fa-user-circle"> </span>
               <span><%=user.getName() %></span>
       </a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="Logout_Servlet">
              <span class="fa fa-sign-out"></span>
       Log out</a>
      </li>
    </ul>   
   </div>
</nav>
	<!-- error box -->
	<!-- 					<%
							Message msg=(Message)session.getAttribute("msg");
							if(msg!=null)
							{
								%>
									<div class="alert <%=msg.getCssClass() %>" role="alert">
									 	<%=msg.getContent() %>
									</div>
								<% 
								//session.removeAttribute("msg");
							}
						%>			 -->
<!-- end of navbar -->
<div class="modal fade" id="profile_details" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header primary-background ">
        <h5 class="modal-title " id="exampleModalLabel text-center">Tech Blog</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">         
        </button>
      </div>
      <div class="modal-body">
        <div class="container text-center">
        	<img  src="pics/<%=user.getProfile() %>" class="img-fluid" style="border-radious:50%; max-width:100px" >
        	<br>
        	<h5 class="modal-title mt-3" id="exampleModalLabel text-center"><%=user.getName() %></h5>
       		<!-- Details  -->
       	<div id="user_details">
       		<table class="table">
  			  <tbody>
    			<tr>
      				<th scope="row">ID :</th>
      				<td><%=user.getId() %></td>
    			</tr>
    			<tr>
      				<th scope="row">Email :</th>
      				<td><%=user.getEmail() %></td>
    			</tr>    
   				 <tr>
      				<th scope="row">Gender :</th>
      					<%
      						String g =user.getGender();
      						if(g.equalsIgnoreCase("on"))
      						{
    	  						g="Male";
      						}
      						else
      						{
    	 						 g="Female";
      						}
      					%>
     				 <td><%=g%></td>
    			</tr>
    		<tr>
      				<th scope="row"> About</th>
      				<td><%=user.getAbout() %></td>
   		   </tr>
    			<tr>
      				<th scope="row">Registered On  :</th>
      				<td><%=user.getRdate().toString()%></td>
    			</tr>
  			  </tbody>
		  </table>
		</div>
		<div id="user_edit">
			<h2 class="mt-2">Please Edit details Carefully</h2>
			<form action="${pageContext.request.contextPath}/EditServlet" method="post" enctype="multipart/form-data">			
				<table class="table">
					<tr>
						<td>ID:</td>
						<td><%=user.getId() %></td> 
					</tr>
					<tr>
						<td>Email:</td>
						<td><input type="email" name="user_email" class="form-control" value="<%=user.getEmail()%>"></td>
					</tr>
					<tr>
						<td>Name:</td>
						<td><input type="text" name="user_name" class="form-control" value="<%=user.getName()%>"></td>
					</tr>
					<tr>
						<td>Password:</td>
						<td><input type="password" name="user_password" class="form-control" value="<%=user.getPassword()%>"></td>
					</tr>
					<tr>						
						<td>Gender:</td>
						<%
							String gender=user.getGender();
							if(gender.equalsIgnoreCase("ON"))
							{
								gender="Male";
							}
							else 
							{
								gender=user.getGender();
							}
						%>
						<td><%=gender%></td>
					</tr>
					<tr>
						<td>New profile:</td>
						<td><input type="file" name="image"class="form-control "></td>
					</tr>
					
				</table>
				<div class="container">
					<button type="submit" class="btn btn-outline-primary">
						Save
					</button>
				</div>
			</form>
		</div>
			
        </div>
      </div>
      <div class="modal-footer">
       <button type="button" class="btn primary-background" id="user_edit-btn">Update Profile</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>       
      </div>
    </div>
  </div>
</div>
	<!-- profile model end -->	
</body>
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>	
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script>
		$(document).ready(function(){
			$("#user_edit").hide()
			let editStatus=false;
			$('#user_edit-btn').click(function(){
				//alert("djfskd")
				$("#user_details").hide()
				$("#user_edit").show()
				if(editStatus==false)
				{
					$("#user_details").hide();
					$("#user_edit").show();
					editStatus=true;
					$(this).text("Back");
				}
				else
					{
					$("#user_details").show();
					$("#user_edit").hide();
					editStatus=false;
					$(this).text("Update Profle");
					}			})
		});
	</script>
	<script>
    document.addEventListener("DOMContentLoaded", function () {
        const navLinks = document.querySelectorAll(".nav-link");
        const currentUrl = window.location.href;

        navLinks.forEach(link => {
            if (link.href === currentUrl) {
                link.parentElement.classList.add("active");
            }
        });
    });
</script>
	
</html>
