<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tech-Blog_Registertin</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){		
		$('#reg-form').on('submit',function(event){
			event.preventDefault();			
			let form=new FormData(this);
			
			$("#btn_submit").hide();
			$("#loader").show();
			//send register servlet
			$.ajax({
				url: "RegisterServlet",
				type: 'POST', 
				data: form,
				success: function(data, textStatus, jqHR){
					console.log(data);
					$("#btn_submit").show();
					$("#loader").hide();					
						swal("Register successfully! we are going to redirecting to Login page...")
						.then((value) => {
						    window.location.href = "login_page.jsp"
						});					
				},
				error: function(jqXHR, textStatus, errorThrown) {
					$("#btn_submit").hide();
					$("#loader").show();
					swal("Something went wrong...")
				},				
				processData: false,
				contentType: false
			});
			
		});
	});
</script>

</head>
<body>
	<%@include file="script.jsp"%>
	<%@include file="normal_navbar.jsp"%>
	<main class="primary-background p-2  banner-background">
	 	<div class="container mb-5">
	 		<div class="col-md-6 offset-md-3">
	 			<div class="card">
	 			  <div class="card-header text-center">
	 			  	<span class="fa fa-3x fa-user-circle"></span>
	 			  	<br>
	 			  	User Registration 
	 			  </div>
	 			  <div class="card-body">
	 			  	<form id="reg-form" action="RegisterServlet" method="Post">
  								<div class="form-group">
  								   <label for="exampleInputEmail1" style="color:black">User Name <span style="color:red">*</span></label>
  								   <input type="text" name="user_name" class="form-control" id="user_name"required="required" aria-describedby="emailHelp">
 								</div>
  								<div class="form-group">
  									  <label for="exampleInputPassword1" style="color:black">Email address <span style="color:red">*</span></label>
 								      <input type="email" name="user_email" class="form-control" id="email" required="required">
 								 	<small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
 								 </div>
 								 <div class="form-group">
  								   <label for="exampleInputEmail1" style="color:black">User Password<span style="color:red">*</span> </label>
  								   <input type="password" name="user_password" class="form-control" id="user_password"required="required" aria-describedby="emailHelp">
 								</div>
 								<div class="form-group">
 								   <label for="exampleInputEmail1" style="color:black">Select Gender<span style="color:red">*</span></label>
   									 <br>
    								<input type="radio" id="malegender" name="gender">Male
   									 <input type="radio" id="femalegender" name="gender">Female
								</div>

  								<div class="form-group">
  						    	 <textarea name="about"required="required" class="form-control" id="about" cols="30" rows="5" aria-describedby="emailHelp" placeholder="Enter somthing about your self"></textarea>
 								</div>
  								<div class="form-group form-check" >
  									  <input type="checkbox" name="check" class="form-check-input" id="exampleCheck1">
  									  <label class="form-check-label" for="exampleCheck1" style="color:black">agree terms and conditions</label>
  								</div>
  								<BR>
  									<div class="contaier text-center" id="loader" style="display: none">
  										<span class="fa fa-refresh fa-spin fa-2x"></span>
  										<h4>Pleas Wait....</h4>
  									</div>
 								 <button type="submit" id="btn_submit" class="btn primary-background text-white">Submit</button>
							</form>
	 			  </div>	 			 
	 			</div>
	 		</div>
	 	</div>
	</main>
</body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
</html>