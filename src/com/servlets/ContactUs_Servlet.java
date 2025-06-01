package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.dao.ContactDao;
import com.tech.entities.ContactUs;
import com.tech.helper.ConnectionProvider;

@WebServlet("/ContactUs_Servlet")
public class ContactUs_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10; // Number of records per page

    public ContactUs_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException 
    {
    	String email = req.getParameter("email");
    	if (email == null || email.isEmpty()) {
    	    rep.sendRedirect("adminProfile.jsp.jsp?error=invalidEmail");
    	    return;
    	}
    	ContactDao contactDao = new ContactDao(ConnectionProvider.getConnection());

        if (contactDao.deleteContactByMail(email)) {
            rep.sendRedirect("Admin/adminProfile.jsp?success=deleted");
        } else {
            rep.sendRedirect("Admin/adminProfle.jsp?error=notDeleted");
        }
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException {
        PrintWriter out = rep.getWriter();

        try {
            // Fetch parameters
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String message = req.getParameter("message");

            if (name == null || email == null || message == null) {
                out.println("Error: All fields are required.");
                return;
            }

            System.out.println("Received: " + name + ", " + email + ", " + message);

            // Save contact details
            ContactUs contact = new ContactUs(email, name, message);
            ContactDao contactDao = new ContactDao(ConnectionProvider.getConnection());
            boolean isSaved = contactDao.saveContact(contact);

            // Redirect based on result
            if (isSaved) {
                req.getRequestDispatcher("successContact.jsp").forward(req, rep);
            } else {
                req.getRequestDispatcher("error.jsp").forward(req, rep);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("error.jsp").forward(req, rep);
        }
    }

}
