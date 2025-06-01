<%@page import="com.tech.dao.LikeDao"%>
<%@page import="com.tech.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.auth0.jwt.exceptions.JWTVerificationException"%>
<%@page import="com.auth0.jwt.interfaces.DecodedJWT"%>
<%@page import="com.tech.helper.JwtHelper"%>
<%
	// Retrieve the JWT token from the session or request header
    String token = (String) session.getAttribute("jwtToken"); // Ensure this matches the attribute set in user_profile.jsp
    User user = (User) session.getAttribute("current_user");
	
    if (token == null || user == null) {
        out.println("<h5 class='display-3 text-center' style='color:red'>Access Denied. Please log in.</h5>");
        return;
    }
    try {
        // Validate the JWT token
        DecodedJWT decodedJWT = JwtHelper.validateToken(token);
        String username = decodedJWT.getSubject();
        String role = decodedJWT.getClaim("role").asString();
		System.out.println("User name get from the db:"+user.getName()+"and user name get fromt the JWT Token:"+username);
        // Check if the user from session matches the token's username
        if (!user.getEmail().equals(username)) {
            out.println("<h5 class='display-3 text-center' style='color:red'>Invalid token. Please log in again.</h5>");
            return;
        }
    } catch (JWTVerificationException e) {
        out.println("<h5 class='display-3 text-center' style='color:red'>Invalid or expired token. Please log in again.</h5>");
        return;
    }

    // Fetch posts based on the category ID
    PostDao postdao = new PostDao(ConnectionProvider.getConnection());
    int cid = Integer.parseInt(request.getParameter("cid"));
    int user_id = user.getId();
    List<Post> posts = new ArrayList<>();

    if (cid == 0) {
        posts = postdao.getAllPost();
    } else {
        posts = postdao.getPostById(cid, user_id);
    }

    if (posts.isEmpty()) {
        out.println("<h5 class='display-3 text-center' style='color:red'>No post in this category...</h5>");
        return;
    }

    for (Post p : posts) {
        LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
        int count = likeDao.countLikeOnPost(p.getPid());
        %>
        <div class="col-md-4 mt-2">
            <div class="card">
                <img src="blog_pics/<%= p.getpPic() %>" class="card-img-top" alt="Blog Post Image">
                <div class="card-body" id="show-blog">
                    <b><h3><%= p.getpTitle() %></h3></b>
                    <p><%= p.getpContent() %></p>
                    <a href="#" onclick="doLike(<%= p.getPid() %>, <%= user.getId() %>)" class="btn btn-outline-primary btn-sm">
                        <i class="fa fa-thumbs-o-up"><span class="like-counter"><%= count %></span></i>
                    </a>
                    <a href="show_blog_page.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-primary btn-sm">Click for Code</a>
                    <a href="#" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting"></i>10</a>
                    <a href="#" class="btn btn-outline-primary btn-sm" style="float:left"><i class="fa fa-pencil"></i> Update Blog</a>
                </div>
            </div>
        </div>
        <%
    }
%>
<%@ include file="script.jsp" %>
