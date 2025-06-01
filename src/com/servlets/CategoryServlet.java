package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.tech.dao.CategoryDao;
import com.tech.dao.PostDao;
import com.tech.entities.Category;
import com.tech.helper.ConnectionProvider;

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the action parameter
        String action = request.getParameter("action");
        String message = "";
        System.out.println("Action: " + action);
        System.out.println("Received cid: " + request.getParameter("cid"));

        try {
            
            CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
            PostDao postDao=new PostDao(ConnectionProvider.getConnection());
            switch (action) {
                case "add":
                	System.out.println("Test in categoriey for add..");
                    // Add a new category
                    String name = request.getParameter("name");
                    String description = request.getParameter("description");
                    Category newCategory = new Category(name, description);
                    if (categoryDao.addCategory(newCategory)) {
                        message = "Category added successfully!";
                    } else {
                        message = "Failed to add category.";
                    }
                    break;

                case "delete":
                    // Delete a category by ID
                    int cidToDelete = Integer.parseInt(request.getParameter("cid"));
                    System.out.print("Test in Category for delete"+cidToDelete);
                    if (postDao.deleteAllPostByCategory(cidToDelete)|| categoryDao.deleteCategory(cidToDelete)) {
                    	response.sendRedirect("Admin/adminProfile.jsp?success=deleted");
                    } else {
                    	response.sendRedirect("Admin/adminProfle.jsp?error=notDeleted");
                    }
                    break;

                case "update":
                    // Update category by ID
                    int cidToUpdate = Integer.parseInt(request.getParameter("cid"));
                    String updatedName = request.getParameter("name");
                    String updatedDescription = request.getParameter("description");
                    if (categoryDao.updateCategory(cidToUpdate, updatedName, updatedDescription)) {
                        message = "Category updated successfully!";
                    } else {
                        message = "Failed to update category.";
                    }
                    break;

                default:
                    message = "Invalid action.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred: " + e.getMessage();
        }

        // Send response back to the client
        response.getWriter().write(message);
    }
}