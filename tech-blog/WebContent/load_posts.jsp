<%@page import="com.tech.dao.LikeDao"%>
<%@page import="com.tech.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.dao.PostDao"%>
<div class="row">
<%
Thread.sleep(500);  // for testing loader only 
PostDao postdao=new PostDao(ConnectionProvider.getConnection());
int cid=Integer.parseInt(request.getParameter("cid"));
User user=(User)session.getAttribute("current_user");
int user_id=user.getId();
System.out.println("USer name :"+user.getName()+"and user id is :"+user.getId());
List<Post> posts=new ArrayList<Post>();
if(cid==0)
{
	posts=postdao.getAllPost();
}
else
{
	posts=postdao.getPostById(cid,user_id);	
}
if(posts.size()==0)
{
	out.println("<h5 class='display-3 text-center' style='color:red'>No post in this category...</h5>");
	return;
}

for(Post p:posts)
{
	System.out.println("Post ID :"+p.getPid());
	LikeDao likeDao=new LikeDao(ConnectionProvider.getConnection());
	int count=likeDao.countLikeOnPost(p.getPid());
	System.out.println(count);
	%>
		<div class="col-md-4 mt-2">
			<div class="card">
				  <img src="blog_pics/<%=p.getpPic() %>" class="card-img-top">
				<div class="card-body" id="show-blog">
					<b><h3><%=p.getpTitle() %></h3></b>
					<p><%=p.getpContent() %></p>
					<a href="#" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-primary btn-sm"><i class="fa fa-thumbs-o-up"><span class="like-counter"><%=likeDao.countLikeOnPost(p.getPid())%></span></i></a>				
					<a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-primary btn-sm">Click for Code</a>
					<a href="#" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting"></i>10</a>	
					<a href="#" class="btn btn-outline-primary btn-sm" style="float:left"><i class="fa fa-pencil"></i> Update Blog</a>
					
				</div>
			</div>
		</div>
	<%
}
%>
<%@include file="script.jsp"%>
</div>
