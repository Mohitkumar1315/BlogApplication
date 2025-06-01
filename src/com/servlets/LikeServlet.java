package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.dao.LikeDao;
import com.tech.helper.ConnectionProvider;

/**
 * Servlet implementation class LikeServlet
 */
@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
        String operation = request.getParameter("operation");
        int userId = Integer.parseInt(request.getParameter("uid"));
        int postId = Integer.parseInt(request.getParameter("pid"));
        
        //
        	if(operation.equals("like"))
        	{
        		boolean f=likeDao.isLikeByUser(userId, postId);
        		if(f)
        		{
        			likeDao.DisLike(userId, postId);
        		}
        		else
        		{
        			boolean x = likeDao.insertLike(postId, userId);
                  if (x) {
                      int likeCount = likeDao.countLikeOnPost(postId);
                      out.print(likeCount); // Return the updated like count to the client-side JavaScript
                  }
        		}
        	}
        //
        
//        if (operation.equals("like")) 
//        {
//            boolean f = likeDao.insertLike(postId, userId);
//            if (f) {
//                int likeCount = likeDao.countLikeOnPost(postId);
//                out.print(likeCount); // Return the updated like count to the client-side JavaScript
//            }
//        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{	
		
	}

}
