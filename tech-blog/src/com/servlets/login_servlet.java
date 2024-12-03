package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.tech.dao.UserDao;
import com.tech.entities.Message;
import com.tech.entities.User;
import com.tech.helper.ConnectionProvider;

/**
 * Servlet implementation class login_servlet
 */
@WebServlet("/login_servlet")
public class login_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login_servlet() {
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
	protected void doPost(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException {
		// TODO Auto-generated method stu
		PrintWriter out=rep.getWriter();
		String check=req.getParameter("check");	
//		if(check==null)
//		{
//			out.print("Someting went wrong");
//		}
		//featch user details from request
		User user=null;
		String userEmail=req.getParameter("user_email");
		String userPassword=req.getParameter("user_password");
		String loginRole=req.getParameter("login_role");
		UserDao userDao=new UserDao(ConnectionProvider.getConnection());
		user=userDao.getUserByEmailAndPassword(userEmail, userPassword);
		System.out.println("User:"+user);
		if(user==null)
		{
			Message message=new Message("Invalid Details ! try with another","error","alert-danger");
			HttpSession session =req.getSession();
			session.setAttribute("msg", message);
			rep.sendRedirect("login_page.jsp");
		}else
		if(user.getUserRole().equals("Admin")&&loginRole.equals("Admin")) {
			System.out.println("You are admin:"+loginRole);
			HttpSession session =req.getSession();
			session.setAttribute("current_user", user);
			rep.sendRedirect("Admin/adminProfile.jsp");
		}
		else  
			if(user.getUserRole().equals("User")&&loginRole.equals("User")) 
			{
				System.out.println("Your have the User role ");
				HttpSession session =req.getSession();
				session.setAttribute("current_user", user);
				rep.sendRedirect("User_profile.jsp");
			}

	}

}
