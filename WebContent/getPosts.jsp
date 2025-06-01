<%@ page import="com.tech.helper.ConnectionProvider" %>
<%@ page import="com.tech.dao.PostDao" %>
<%@ page import="com.tech.entities.Post" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <style>
        .badge-gradient-success {
            background: linear-gradient(to right, #9acd32, #32cd32); /* Yellowgreen gradient */
            color: #fff; /* White text for contrast */
            padding: 0.25rem 0.5rem; /* Adjust padding */
            border-radius: 0.25rem; /* Rounded corners */
            font-weight: bold;
            display: inline-block;
            text-align: center;
        }

        .badge-gradient-success:hover {
            background: linear-gradient(to right, #32cd32, #228b22); /* Slightly darker gradient on hover */
            color: #fff; /* Maintain white text on hover */
        }

        .post-card {
            display: flex;
            justify-content: space-between; /* Align items to edges */
            align-items: center; /* Vertically align items */
            padding: 1rem;
            border: 1px solid #e3e3e3;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
        }

        .post-title {
            font-weight: bold;
            margin-bottom: 0.5rem;
            flex-grow: 1; /* Make the title take available space */
        }

        .read-more-btn {
        	margin-top:1em
            background: linear-gradient(to right, #32cd32, #228b22); /* Custom gradient */
            color: #fff;
            border: none;
            padding: 0.2rem 1rem; /* Adjust padding for size */
            border-radius: 0.5rem; /* Rounded corners */
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .read-more-btn:hover {
            background: linear-gradient(to right, #32cd32, #228b22); /* Slightly darker gradient on hover */
            color: #fff; /* Maintain white text on hover */
        }
    </style>
</head>
<body>
    <%
        int categoryId = request.getParameter("categoryId") != null ? Integer.parseInt(request.getParameter("categoryId")) : 0;
        PostDao postdao = new PostDao(ConnectionProvider.getConnection());
        ArrayList<Post> postList = (categoryId == 0) ? postdao.getAllPost() : postdao.getPostByCatId(categoryId);
        if (postList.size() == 0) {
            out.println("<h5 class='display-3 text-center' style='color:red'>No post in this category...</h5>");
            return;
        }
        for (Post p : postList) {
    %>
        <div class="post-card">
            <div>
                <div class="post-title"  ><%= p.getpTitle()%></div>
                <p class="post-excerpt text-muted">
                    This is a preview of the post. Click "Read More" to view full details.
                </p>
                <span class="badge badge-gradient-success">Tutorial</span>
            </div>
           <button class="read-more-btn">
   				 <a href="Allshow_blog_page.jsp?post_id=<%= p.getPid()%>" style="text-decoration: none;color:white">Read More</a>
		  </button>


            
        </div>
    <%
        }
    %>
    <script>
    function readMore(postId) 
    {
    	//console.log(postId);
        // Redirect to the desired page with the post_id
       // window.location.href = `Allshow_blog_page.jsp?post_id=${postId}`;
    }
</script>
</body>
</html>
