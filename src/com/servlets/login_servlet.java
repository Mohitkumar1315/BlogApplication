package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.dao.PostDao;
import com.tech.dao.UserDao;
import com.tech.entities.Message;
import com.tech.entities.User;
import com.tech.helper.ConnectionProvider;
import com.tech.helper.JwtHelper;

@WebServlet("/login_servlet")
public class login_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException 
    {
        rep.setContentType("application/json");
        PrintWriter out = rep.getWriter();

        String userEmail = req.getParameter("user_email");
        String userPassword = req.getParameter("user_password");
        String loginRole = req.getParameter("login_role");

        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
        User user = userDao.getUserByEmailAndPassword(userEmail, userPassword);

        if (user == null) {
            Message message = new Message("Invalid Details! Try again.", "error", "alert-danger");
            req.getSession().setAttribute("msg", message);
            rep.sendRedirect("login_page.jsp");
        } else {
            if (user.getUserRole().equals(loginRole)) {
                // Generate JWT token with user's email and role
                String token = JwtHelper.generateToken(user.getEmail(), user.getUserRole());
                System.out.println("Token in Login Servlet:"+token);
                // Store the token in the session and user details
                req.getSession().setAttribute("jwtToken", token);
                req.getSession().setAttribute("current_user", user);

                // Send the JWT token in the response header for client-side usage
                rep.setHeader("Authorization", "Bearer " + token);

                // Redirect user to the appropriate page based on role
                String redirectPage = loginRole.equals("Admin") ? "Admin/adminProfile.jsp" : "User_profile.jsp";
                rep.sendRedirect(redirectPage);
            } else {
                Message message = new Message("Invalid Role! Try again.", "error", "alert-danger");
                req.getSession().setAttribute("msg", message);
                rep.sendRedirect("login_page.jsp");
            }
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
    	String UserId=request.getParameter("uId");
    	System.out.println("userId:"+UserId);
    	if(UserId==null||UserId.isEmpty())
    	{
    		response.sendRedirect("Admin/adminProfile.jsp?success=Post is delete with id:"+UserId+"");
    	}
    	System.out.println("Test1....");
    	PostDao postDao=new PostDao(ConnectionProvider.getConnection());
    	UserDao userDao=new UserDao(ConnectionProvider.getConnection());
    	if(postDao.deletePostByUserId(UserId)&&userDao.deleteUser(UserId))
    	{
    		System.out.println("Test2....");
    		response.sendRedirect("Admin/adminProfile.jsp?success=Post is delete with id:"+UserId+"");
    	}
    	else
    	{
    		System.out.println("Test3....");
    		response.sendRedirect("Admin/adminProfile.jsp?error=SQL ERRor...!");
    	}
	}
}
