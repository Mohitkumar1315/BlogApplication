<%@ page import="com.tech.helper.ConnectionProvider" %>
<%@ page import="com.tech.dao.PostDao" %>
<%@ page import="com.tech.entities.Post" %>
<%@ page import="java.util.ArrayList" %>

<%
    int categoryId = request.getParameter("categoryId") != null ? Integer.parseInt(request.getParameter("categoryId")) : 0;
    PostDao postdao = new PostDao(ConnectionProvider.getConnection());
    ArrayList<Post> postList = (categoryId == 0) ? postdao.getAllPost() : postdao.getPostByCatId(categoryId);
    if(postList.size()==0)
    {
    	out.println("<h5 class='display-3 text-center' style='color:red'>No post in this category...</h5>");
    	return;
    }
    for (Post p : postList) {
%>
        <div class="post-card mb-3 p-3 bg-white shadow-sm">
            <div class="post-title font-weight-bold mb-2"><%= p.getpTitle() %></div>
            <p class="post-excerpt text-muted">
                This is a preview of the post. Click "Read More" to view full details.
            </p>
            <button class="btn btn-primary btn-sm read-more-btn" onclick="readMore(<%= p.getPid() %>)">
                Read More
            </button>
        </div>
<%
    }
%>
