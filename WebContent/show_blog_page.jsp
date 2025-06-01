<%@page import="com.tech.dao.LikeDao"%>
<%@page import="com.tech.entities.Like"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.entities.Post"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.User"%>
<%@page errorPage="error.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
	.post-title
	{
		font-weight:100;
	}
</style>
</head>
<body>
	<%
		PostDao postDao=new PostDao(ConnectionProvider.getConnection());
		List<Category> categories=postDao.getCategories();
	%>
		<!-- navbar -->
		<nav class="navbar navbar-expand-lg navbar-dark primary-background">
  <a class="navbar-brand" href="index.jsp"><span class="	fa fa-american-sign-language-interpreting"></span>Tech Blog</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="User_profile.jsp">
        <span class="fa fa-home"></span>
        mk1315codes_learning <span class="sr-only">(current)</span></a>
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
       <li class="nav-item">
        <a class="nav-link" href="contact.jsp">
               <span class="fa fa-address-book-o fa fa-address-card"></span>
        Contact</a>
      </li>     
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
		<!-- navbar  end here -->
		<%
	User user=(User)session.getAttribute("current_user");
	if(user==null)
	{
		response.sendRedirect("login_page.jsp");		
	}
	else
	{
		int pId=Integer.parseInt(request.getParameter("post_id"));	
	//	PostDao postDao=new PostDao(ConnectionProvider.getConnection());
		Post post=postDao.getPostByPostId(pId);
		%>
			<div class="container text-center">
				 <div class="row my-4">
				 	<div class="col-md-6 offset-md-3"> <!-- for only one coloumn-->
				 		<div class="card">
				 			<div class="card-header">
				 				<h4 class="post-title"><%=post.getpTitle()%></h4>
				 			</div>
				 			<div class="card-body">
				 				<p class="post-content"><%=post.getpContent()%></p>
				 				<h6 style="margin-right"><a href="User_profile.jsp"><%=user.getName()%></a> has posted:</h6>

				 				<hr>
				 				<h5 style="float:left"><i>Example...</i></h5><br><br>
				 				<div class="post-code">
				 					<pre class="post-code"><%=post.getpCode()%></pre>
				 				</div>				 				
				 			</div>
				 			<div class="card-footer">
				 				<%
				 					LikeDao likeDao=new LikeDao(ConnectionProvider.getConnection());
				 					int countLike=likeDao.countLikeOnPost(post.getPid());
				 					System.out.println("PostID:"+post.getPid());
				 					System.out.println("Total counts of like "+countLike);
				 				%>
				 				<a href="#" onclick="doLike(<%=post.getPid()%>,<%=user.getId()%>)"class="btn btn-outline-primary btn-sm"><i class="fa fa-thumbs-o-up"><span class="like-counter"><%=likeDao.countLikeOnPost(post.getPid())%></span></i></a>											
								<a class="nav-link" href="#!" data-toggle="modal" data-target="#DoComment"><i class="fa fa-commenting"></i>10</a>	
				 			</div>				 			
				 			<div>
				 			</div>
				 		</div>
				 	</div>
				 </div>
			</div>
			<div class="modal fade" id="DoComment" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"> 
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><span style="color: red; font-weight: bold;">mk</span>Codes1315_learning</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="DoCommentServlet" id="do-comment" method="post"> 
                    <div class="form-group">
                        <input type="text" name="Comment" placeholder="Comment..." class="form-control"> 
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="postId" value="<%=pId%>" placeholder="Comment..." class="form-control"> 
                         <input type="hidden" name="userId" value="<%=user.getId()%>" placeholder="Comment..." class="form-control">
                    </div>
                    <div class="container text-center">
                        <button type="submit" class="btn btn-outline-primary">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

		<% 
	}		
	%>
	
	<%@include file="script.jsp"%>
	<script>
		$(document).ready(function(e){
    $("#do-comment").on("submit", function(event){
       
        event.preventDefault();
        console.log("You have clicked on the submit button");
        let form = new FormData(this);
        $.ajax({
        	console.log("Heloo");
            url: "DoCommentServlet",
            type: "POST",
            data: form,
            success: function(data, textStatus, jqXHR){
             
                		swal("Good job!","dfgdfgdf","sucess");               
           
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
</body>
</html>