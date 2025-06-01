package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.dao.UserDao;
import com.tech.entities.User;
import com.tech.helper.ConnectionProvider;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated construttor stub
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
		// TODO Auto-generated method stub
		PrintWriter out=rep.getWriter();
		String check=req.getParameter("check");		
		//fetch form all data
		if(check==null)
		{
			out.println("Please check term and conditions");
		}
		else
		{
			String name=req.getParameter("user_name");
			String password=req.getParameter("user_password");
			String gender=req.getParameter("gender");
			String email=req.getParameter("user_email");
			String about=req.getParameter("about");
			
			User user=new User();
			user.setName(name);
			user.setAbout(about);
			user.setEmail(email);
			user.setGender(gender);
			user.setPassword(password);
			//create  user Dao Object
			UserDao userdao=new UserDao(ConnectionProvider.getConnection());
			//save all data using dao			
			userdao.SaveUser(user);
			if(userdao.SaveUser(user))
			{
				out.println("save");
			}
			else
			{
				out.println("Some thing went wrong pleas try again");
			}
			}
		
	}
	protected void processRequesst(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException
	{
		
	}
}
