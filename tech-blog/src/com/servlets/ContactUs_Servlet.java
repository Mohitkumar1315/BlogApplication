package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
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

    protected void doGet(HttpServletRequest req, HttpServletResponse rep) throws ServletException, IOException {
        rep.setContentType("application/json");
        PrintWriter out = rep.getWriter();
        ContactDao contactDao = new ContactDao(ConnectionProvider.getConnection());
        List<ContactUs> contactList = contactDao.getContactsByPage();

        // Convert contactList to JSON
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < contactList.size(); i++) {
            ContactUs contact = contactList.get(i);
            json.append(String.format(
                "{\"name\":\"%s\", \"email\":\"%s\", \"message\":\"%s\"}",
                contact.getName(), contact.getEmail(), contact.getMessage()
            ));
            if (i < contactList.size() - 1) json.append(",");
        }
        json.append("]");
        out.print(json.toString());
        out.flush();
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
