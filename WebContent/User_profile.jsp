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
<title>Insert title here</title>
<script>																		
</script>
</head>
<body>
<%
	User user=(User)session.getAttribute("current_user");	
	if(user==null)
	{
		response.sendRedirect("login_page.jsp");
	}
	String jwtToken = (String) session.getAttribute("jwtToken");
	System.out.println("JWT token in USerProfle"+jwtToken);
%>
	<%@include file="script.jsp"%>
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
        Contact</a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="#!" data-toggle="modal" data-target="#DoPost_model">  
               <span class="fa fa-asterisk"></span>
        Do Post</a>
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
						<%
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
						%>			
<!-- end of navbar -->

	<!-- Main body of the page -->
		<main>
			<div class="container">
				<div class="row mt-4">
					<!-- first coloumn for categories -->
					<div class="col-md-6">
						<div class="list-group">
  							<a href="#" onclick="getPost(0,this)" class="c-link list-group-item list-group-item-action active " aria-current="true">
   									All Post
  							</a>
 							<%
 								PostDao postdao=new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> catlist1= postdao.getCategories();
								for(Category cat:catlist1)
								{
									%>
										<a href="#" onclick="getPost(<%=cat.getCid()%>,this)" class="c-link list-group-item list-group-item-action" aria-current="true"><%=cat.getName() %></a>
									<%
								}							
 							%>
						</div>
					</div>
					<!-- second row for showing posts   -->
					<div class="col-md-8">
						<div class="container text-center" id="loader">
							<i class="fa fa-refresh fa-4x fa-spin "></i>
							<h3>Loading.....</h3>
						</div>
					</div>
					<div class="container-fluid" id="post_container">
						
					</div>
				</div>
			</div>
		</main>
	<!--  end of main body of the page -->
	<!-- profile model start -->
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
			<form action="EditServlet" method="post" enctype="multipart/form-data">
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
<!-- Do post model start -->
		
<div class="modal fade" id="DoPost_model" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">provide the Post Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       		<form action="AddPostServlet" method="Post" id="add-post-form">
       			<div class="form-group">
       				<select class="form-control" name ="cid">
       					<option selected disabled="disabled">---Select Category---</option>
       					<% 
       						PostDao postDao=new PostDao(ConnectionProvider.getConnection());
       						ArrayList<Category> catlist=postDao.getCategories();
       						for(Category c:catlist)
       						{
       							%>
       								<option value="<%=c.getCid()%>"><%=c.getName()%></option>
       								
       							<%
       						}
       					%>
       					
       				</select>
       			</div>
       			<div class="form-group">
       				<input type="Text" name="pTitle" placeholder="Entere post Title" class="form-control">       				
       			</div>
       			<div class="form-group">
        				<textarea placeholder="Enter your Content" name="pContent" style="height:200px" class="form-control"></textarea>
    			</div>
    			<div class="form-group">
        				<textarea placeholder="Enter your Code" name="pCode" style="height:200px" class="form-control"></textarea>
    			</div>				
    			<div class="form-group">
    					<label>Select your pic.. </label>
    					<br>
        				<input name="pPic" type="file">
    			</div>
				<div class="container text-center">
					<button type="submit" class="btn btn-outline-primary">Submit
					</button>
				</div>
				 
       		</form>
      </div>    
    </div>
  </div>
</div>
<!-- Do Post model end  -->
	
</body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
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
		// add post from Do Post to AddPost_Servlet
		$(document).ready(function(e){
    $("#add-post-form").on("submit", function(event){
        // This code gets called when the form is submitted.
        event.preventDefault();
        console.log("You have clicked on the submit button");
        let form = new FormData(this);
        // Now send a request to the server
        $.ajax({
            url: "AddPostServlet",
            type: "POST",
            data: form,
            success: function(data, textStatus, jqXHR){
             
                		swal("Good job!","Post successfully posted","sucess");               
           
            },
            error: function(jqXHR, textStatus, errorThrown){
                swal("Hii babu! You doing something wrong ")
            },
            processData: false,
            contentType: false
        });
    });
});

	</script>
	<!-- loading post using ajax -->
	<script>
		$(document).ready(function(){
			//getPost(0);
		})
		function getPost(catId, temp) 
		{
    $("#loader").show();
    $("#post_container").hide();

    $('.c-link').removeClass('active');

    $.ajax({
        url: "load_posts.jsp",
        data: { cid: catId },
        success: function (data, textStatus, jqXHR) {
            $("#loader").hide();
            $("#post_container").show();
            $("#post_container").html(data);
            $(temp).addClass('active');
        }
    });
}
	</script>
</html>