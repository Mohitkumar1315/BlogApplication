package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.dao.CommentDao;
import com.tech.helper.ConnectionProvider;

/**
 * Servlet implementation class DoCommentServlet
 */
@WebServlet("/DoCommentServlet")
public class DoCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DoCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		String Comment=request.getParameter("Comment");
		int postId=Integer.parseInt(request.getParameter("postId"));
		int userId=Integer.parseInt(request.getParameter("userId"));
		System.out.println("Cpmment:"+Comment);
		CommentDao commentDao=new CommentDao(ConnectionProvider.getConnection());
		boolean f=commentDao.doComment(userId,postId,Comment);
		if(f)
		{
			System.out.println("Test heelo");
		}
		else
		{
			System.out.println("error");
		}
	}

}
