<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
    List<Category> categoriesList = postDao.getCategories();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Categories</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container my-5">
    <h2>Manage Categories</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Category ID</th>
                <th>Category Name</th>
                <th>Category Description</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Category category : categoriesList) {
            %>
            <tr>
                <td><%= category.getCid() %></td>
                <td><%= category.getName() %></td>
                <td><%= category.getDescription() %></td>
                <td>
                     <a href="#" class="btn btn-danger btn-sm delete-btn" data-cid="<%= category.getCid() %>">Delete</a>
                  <!--   <a href="#" class="btn btn-danger btn-sm delete-btn" data-cid="123">Delete</a>-->                  
                    <a href="#" class="btn btn-warning btn-sm update-btn" data-cid="<%= category.getCid() %>" data-name="<%= category.getName() %>" data-description="<%= category.getDescription() %>">Update</a>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">Add Category</button>
</div>

<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="<%= request.getContextPath() %>/CategoryServlet" method="post">
            <%
            	System.out.println(request.getContextPath());
            %>
                <div class="modal-header">
                    <h5 class="modal-title" id="addCategoryLabel">Add Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="categoryName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="categoryDescription" class="form-label">Category Description</label>
                        <textarea class="form-control" id="categoryDescription" name="description" rows="3" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add Category</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Update Category Modal -->
<div class="modal fade" id="updateCategoryModal" tabindex="-1" aria-labelledby="updateCategoryLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/tech-blog/CategoryServlet" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateCategoryLabel">Update Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="updateCategoryId" name="cid">
                    <div class="mb-3">
                        <label for="updateCategoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="updateCategoryName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="updateCategoryDescription" class="form-label">Category Description</label>
                        <textarea class="form-control" id="updateCategoryDescription" name="description" rows="3" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Update Category</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- JavaScript for Delete and Update Actions -->
<script>
document.querySelectorAll('.delete-btn').forEach(btn => {
    btn.addEventListener('click', function (event) {
        event.preventDefault(); // Prevent default link behavior

        // Fetch and log `cid` for debugging
        const cid = this.getAttribute('data-cid');
        console.log('Category ID:', cid);

        // Validate `cid`
        if (!cid || isNaN(cid)) {
            alert('Invalid Category ID');
            return;
        }

        // Confirm deletion
        if (confirm('Are you sure you want to delete this category?')) {
            // Create a form
            const form = document.createElement('form');
            form.action = '/tech-blog/CategoryServlet';
            form.method = 'post';

            // Safely generate input elements
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';

            const cidInput = document.createElement('input');
            cidInput.type = 'hidden';
            cidInput.name = 'cid';
            cidInput.value = cid;

            // Append inputs to form
            form.appendChild(actionInput);
            form.appendChild(cidInput);

            console.log('Generated Form:', form);

            // Append form to the body and submit
            document.body.appendChild(form);
            setTimeout(() => form.submit(), 0);
        }
    });
});


    document.querySelectorAll('.update-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            const cid = this.getAttribute('data-cid');
            const name = this.getAttribute('data-name');
            const description = this.getAttribute('data-description');
            document.getElementById('updateCategoryId').value = cid;
            document.getElementById('updateCategoryName').value = name;
            document.getElementById('updateCategoryDescription').value = description;
            const updateModal = new bootstrap.Modal(document.getElementById('updateCategoryModal'));
            updateModal.show();
        });
    });
</script>
</body>
</html>
