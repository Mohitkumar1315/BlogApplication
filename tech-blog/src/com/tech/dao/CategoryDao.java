package com.tech.dao;

import com.tech.entities.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    private Connection con;

    public CategoryDao(Connection con) {
        this.con = con;
    }
   public boolean addCategory(Category category) {
        boolean isAdded = false;
        try {
            String query = "INSERT INTO categories (name, description) VALUES (?, ?)";
            try (PreparedStatement pst = con.prepareStatement(query)) {
                pst.setString(1, category.getName());
                pst.setString(2, category.getDescription());
                isAdded = pst.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isAdded;
    }

    public boolean deleteCategory(int cid) {
        boolean isDeleted = false;

        try {
            // SQL Query
            String query = "DELETE FROM categories WHERE cid=?";
            System.out.println("Category ID to delete: " + cid);

            // Using PreparedStatement with try-with-resources
            try (PreparedStatement pst = con.prepareStatement(query)) {
                pst.setInt(1, cid);
                
                // Execute Update and Log Result
                int rowsAffected = pst.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);
                
                isDeleted = rowsAffected > 0;
            }
        } catch (Exception e) {
            // Log Exception
            System.err.println("Error occurred while deleting category with ID: " + cid);
            e.printStackTrace();
        }

        return isDeleted;
    }

    public boolean updateCategory(int cid, String newName, String newDescription) {
        boolean isUpdated = false;
        try {
        	System.out.println("you are in UpdateCategoryies");
            String query = "UPDATE categories SET name=?, description=? WHERE cid=?";
            try (PreparedStatement pst = con.prepareStatement(query)) {
                pst.setString(1, newName);
                pst.setString(2, newDescription);
                pst.setInt(3, cid);
                isUpdated = pst.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdated;
    }


    public List<Category> getCategories() {
        List<Category> categories = new ArrayList<>();
        try {
            String query = "SELECT * FROM category";
            try (PreparedStatement pst = con.prepareStatement(query); ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category(
                        rs.getInt("cid"),
                        rs.getString("name"),
                        rs.getString("description")
                    );
                    categories.add(category);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
}
