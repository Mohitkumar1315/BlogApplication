<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.Post"%>
<%@page contentType="texthtml"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.tech.helper.*"%>
<html>
<%
	PostDao postdao=new PostDao(ConnectionProvider.getConnection());
	ArrayList<Category> catList=postdao.getCategories();
	int i=0;
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
	   <!-- navbar -->
	<%@include file="normal_navbar.jsp"%>
	 <!-- banner -->
	 <div class="container-fluid p-0 m-0 banner-background">
	 	<div class="jumbotron primary-background text-white">
	 		<div class="container">
	 			<h3 class="display-3">Welcome to Tech Blog</h3>
	 			<p>Welcome to technical blog, word of Technology   A programming language is usually described in terms of its syntax (form) and semantics (meaning). These are usually defined by a formal language</p>
	 			<p>Programming languages share properties with natural languages related to their purpose as vehicles for communication
	 			</p>
	 			<button class="btn-outline-light btn-lg "><span class="fa fa fa-user-plus"> </span> Start !its free </button>
	 			<a href="login_page.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-o fa-spin"> </span> Login Here </a>
	 		</div>
	 	</div>
	 </div>
	 <!-- cards -->
	 <div class="container">
	 	<%
	 			//int i=0;
	 			String catName[]=new String[50];	 	
	 		for( i = 0; i < catList.size(); i++) 
	 		{
	 			//System.out.println("Testing ...... "+catList.get(i).getName()+"");
	 			 catName[i] = catList.get(i).getName(); 			
	 		}	 		   
	 		%>
	 	
	 	<div class="row mb-2">     <!--one row contains 12 grid--->	 			
	 		<div class="col-md-4">
	 			<div class="card">
					<div class="card-body">
   						 <h5 class="card-title"><%=catName[0]%></h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="login_page.jsp" class="btn primary-background text-white ">Read more</a>
  					</div>
				</div>
	 		</div>
	 		<div class="col-md-4">
	 			<div class="card">
					<div class="card-body">
   						 <h5 class="card-title"><%=catName[1]%></h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="login_page.jsp" class="btn primary-background text-white ">Read more</a>
  					</div>
				</div>
	 		</div>
	 		<div class="col-md-4">
	 			<div class="card">
					<div class="card-body">
   						 <h5 class="card-title"><%=catName[3]%></h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="login_page.jsp" class="btn primary-background text-white ">Read more</a>
  					</div>
				</div>
	 		</div>
	 	</div>
	 	
	 	
	 	<div class="row">     <!--one row contains 12 grid--->
	 		<div class="col-md-4">
	 			<div class="card">
					<div class="card-body">
   						 <h5 class="card-title">Java Programing</h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="#" class="btn primary-background text-white ">Read more</a>
  					</div>
				</div>
	 		</div>
	 		<div class="col-md-4">
	 			<div class="card">
					<div class="card-body">
   						 <h5 class="card-title">Python Programing</h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="#" class="btn primary-background text-white ">Read more</a>
  					</div>
				</div>
	 		</div>
	 		<div class="col-md-4">
	 			<div class="card">
					<div class="card-body">
   						 <h5 class="card-title">C++ Programing</h5>
    					<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    					<a href="#" class="btn primary-background text-white ">Read more</a>
  					</div>
				</div>
	 		</div>
	 	</div>
	 		 		 	
	 </div>	
</body>
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>	
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="JS/myjs.js"></script>
</html>