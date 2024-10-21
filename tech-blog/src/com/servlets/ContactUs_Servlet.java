package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.dao.ContactDao;
import com.tech.entities.ContactUs;
import com.tech.helper.ConnectionProvider;

/**
 * Servlet implementation class ContactUs_Servlet
 */
@WebServlet("/ContactUs_Servlet")
public class ContactUs_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContactUs_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		rep.getWriter().append("Served at: ").append(req.getContextPath());
//		PrintWriter out=rep.getWriter();
//		
		
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, rep);
		System.out.println("hELLLO TEST");
		PrintWriter out=rep.getWriter();
		out.println("Hii kaBir");
		ContactDao conDao=new ContactDao(ConnectionProvider.getConnection());
		String email=req.getParameter("name");
		System.out.println(email);
		ContactUs contact=new ContactUs(req.getParameter("email"),req.getParameter("name"),req.getParameter("message"));
		boolean f=conDao.saveContact(contact);
		if(f)
		{
			RequestDispatcher	rd=req.getRequestDispatcher("successContact.jsp");
			rd.forward(req, rep);
		}
		else {		
		RequestDispatcher	rd=req.getRequestDispatcher("error.jsp");
			rd.forward(req, rep);
		}
	}

}
