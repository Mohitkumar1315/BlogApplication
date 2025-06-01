<%@page import="com.tech.entities.Message"%>
<%@page import="com.tech.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tech-Blog_Login ....</title>
</head>
<body>
	<%@include file="script.jsp"%>
	<%@include file="normal_navbar.jsp"%>
	<main class="d-flex align-items-center primary-background text-white banner-background" style="height:70vh ">
		<div class="container">
			<div class="row">
				<div class="col-md-4 offset-md-4">
					<div class="card">
					 	<div class="card-header primary-background text-white text-center">
					 		<SPAN CLASS="fa fa-user-plus fa-3x"></SPAN>
					 		<br>
					 		<p>Login Here</p>
						</div>						
						<!-- error box -->
						<%
							Message msg = (Message)session.getAttribute("msg");
							if(msg != null)
							{
								%>
									<div class="alert <%=msg.getCssClass() %>" role="alert">
									 	<%=msg.getContent() %>
									</div>
								<% 
								session.removeAttribute("msg");
							}
						%>						
						<div class="card-body">
						 	 <form action="login_servlet" method="POST">
  								<div class="form-group">
  								   <label for="exampleInputEmail1" name="user_email" style="color:black">Email Id</label>
  								   <input type="email" class="form-control" name="user_email" id="exampleInputEmail1" aria-describedby="emailHelp" required>
 								   <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
 								</div>
  								<div class="form-group">
  									  <label for="exampleInputPassword1" style="color:black">Password</label>
 								      <input type="password"  name="user_password" class="form-control" id="exampleInputPassword1"required>
 								 </div>
  								<div class="form-group">
  									<label for="loginRole" style="color:black">Login As:</label>
  									<input type="radio" id="admin" name="login_role" value="Admin" required>
  									<label for="admin" style="color:black">Admin</label>
  									<input type="radio" id="user" name="login_role" value="User" required >
  									<label for="user" style="color:black">User</label>
  									
  								</div>
  								<div class="form-group form-check">
  									  <input type="checkbox" name="check" required="required" class="form-check-input" id="exampleCheck1">
  									  <label class="form-check-label" for="exampleCheck1" style="color:black">Check me out</label>
  								</div>
 								<div class="container text-center">
 									 <button type="submit" class="btn primary-background text-white">Submit</button>
 								</div>
							</form>
						</div>
					</div>
				</div>
			</div>			
		</div>		
	</main>
</body> 
</html>
