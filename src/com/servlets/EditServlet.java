package com.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.dao.UserDao;
import com.tech.entities.Message;
import com.tech.entities.User;
import com.tech.helper.ConnectionProvider;
import com.tech.helper.Helper;

/**
 * Servlet implementation class EditServlet
 */
@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=rep.getWriter();
		//fetch all data from edit form 
		String user_email=req.getParameter("user_email");
		System.out.println(user_email);
		String user_name=req.getParameter("user_name");
		String user_password=req.getParameter("user_password");
		Part part=req.getPart("image");
		String imageName=part.getSubmittedFileName();
		System.out.println(imageName);
		//get the user from the session
		HttpSession s=req.getSession();
		User user=(User)s.getAttribute("current_user");
		user.setEmail(user_email);
		user.setName(user_name);
		user.setPassword(user_password);
		user.setProfile(imageName);
		//out.println(user_email);
		UserDao userDao=new UserDao(ConnectionProvider.getConnection());
		boolean updateStatus=userDao.updateUser(user);
		if(updateStatus)
		{
			String  path=req.getRealPath("/")+"pics"+File.separator+user.getProfile() ;
			//  for remving old pic
		//	String  path=req.getRealPath("/")+"pics"+File.separator+user.getProfile() ;
			System.out.println(path);
		   	Helper.deleteFle(path);
			
				if(Helper.saveFile(part.getInputStream(), path))
				{
					//out.print("profile updated");
					Message msg=new Message("Profile  updated ", "success", "alert-success");
					s.setAttribute("msg", msg);
					
				}
			
		}
		else
		{
			Message msg=new Message("Someting went wrong  ", "faild", "alert-danger");
			s.setAttribute("msg", msg);
		}
		if(user.getUserRole().equals("User"))
		{
		rep.sendRedirect("User_profile.jsp");
		}
		else
		{
			rep.sendRedirect("Admin/adminProfile.jsp");
		}
	}	
}
