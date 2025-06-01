package com.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.dao.PostDao;
import com.tech.entities.Post;
import com.tech.entities.User;
import com.tech.helper.ConnectionProvider;
import com.tech.helper.Helper;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPostServlet() { //
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String postId=request.getParameter("pId");
		if(postId==null||postId.isEmpty())
		{
			response.sendRedirect("Admin/adminProfile.jsp?error=Error in getting Post Id...!");

		}
		PostDao postDao=new PostDao(ConnectionProvider.getConnection());
		if(postDao.deletePostByPostId(postId))
		{
			response.sendRedirect("Admin/adminProfile.jsp?success=Post is delete with id:"+postId+"");

		}
		else
		{
			response.sendRedirect("Admin/adminProfile.jsp?error=SQL ERRor...!");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException 
	{
		PrintWriter out=rep.getWriter();
		String pTitle=req.getParameter("pTitle");
		//System.out.println(pTitle);
		String pCode=req.getParameter("pCode");
		int  catId= Integer.parseInt(req.getParameter("cid")) ;
		String pContent=req.getParameter("pContent");
		Part part =req.getPart("pPic");
		//getting user id from session 
		HttpSession s=req.getSession();
		User user=(User)s.getAttribute("current_user");
	//	System.out.println(user);
		int user_id=user.getId();
	//	out.println(part.getSubmittedFileName());
		String imagename=part.getSubmittedFileName();
		Post post=new Post(pTitle, pContent, pCode, imagename, null, catId, user_id);
		PostDao postDao=new PostDao(ConnectionProvider.getConnection());	 		
		boolean savePost=postDao.savePost(post);
		if(savePost)
		{	//System.out.println("hlsdkhf");		
			String  path=req.getRealPath("/")+"blog_pics"+File.separator+imagename;
			//String path1="/blogs_pics"+File.separator+imagename+"";
			System.out.println(path);
			try {
			    Helper.saveFile(part.getInputStream(), path);
		//	    out.println("Done");
			} catch (Exception e) {
			    e.printStackTrace();
			    out.println("Failed to save the file");
			}
		}
		else
		{
			out.println("NOtkdnfds");
		}
		
		
		
	}

}
