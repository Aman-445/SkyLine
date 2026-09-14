<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.skyline.model.User" %>
<%@ page import="com.skyline.dao.UserDAO" %>

<%
if (!"Admin".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

String message = "";
String messageType = "";

UserDAO dao = new UserDAO();

if ("POST".equalsIgnoreCase(request.getMethod())) {

try {
int id = Integer.parseInt(request.getParameter("id"));

String username = request.getParameter("username");
String password = request.getParameter("password");
String userType = request.getParameter("userType");
String fullName = request.getParameter("fullName");
String mobile = request.getParameter("mobile");
String status = request.getParameter("status");

User user = new User();

user.setId(id);
user.setUsername(username);
user.setPassword(password);
user.setUserType(userType);
user.setFullName(fullName);
user.setMobile(mobile);
user.setStatus(status);

if (dao.updateUser(user)) {
message = "User updated successfully.";
messageType = "success";
} else {
message = "Unable to update user.";
messageType = "error";
}

} catch (Exception e) {
message = "Please enter valid user details.";
messageType = "error";
}
}

User selectedUser = null;

String selectedId = request.getParameter("id");

if (selectedId != null && !selectedId.trim().isEmpty()) {

try {
selectedUser = dao.getUserById(Integer.parseInt(selectedId));
} catch (Exception e) {
e.printStackTrace();
}
}

List<User> userList = dao.getAllUsers();
    %>

    <%@ include file="../Common.jsp" %>

    <style>
        .update-user-layout {
            display: grid;
            grid-template-columns: 380px minmax(0,1fr);
            gap: 18px;
        }
        .update-user-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        .update-user-title {
            color: #4b2aa5;
            font-size: 15px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 1px solid #cfc2e8;
            margin-bottom: 18px;
        }
        .update-form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 14px;
        }
        .update-form-group label {
            font-size: 11px;
            color: #303044;
            margin-bottom: 6px;
        }
        .update-form-group input,
        .update-form-group select {
            width: 100%;
            height: 33px;
            box-sizing: border-box;
            border: 1px solid #dddddd;
            border-radius: 5px;
            padding: 0 9px;
            font-size: 11px;
            outline: none;
        }
        .update-form-group input:focus,
        .update-form-group select:focus {
            border-color: #6337bd;
        }
        .update-btn {
            border: none;
            background: #6337bd;
            color: #ffffff;
            padding: 8px 15px;
            border-radius: 5px;
            font-size: 11px;
            cursor: pointer;
        }
        .update-btn:hover {
            background: #512aa5;
        }
        .update-message {
            margin-bottom: 14px;
            padding: 9px 12px;
            border-radius: 5px;
            font-size: 11px;
        }
        .update-success {
            background: #e8f7ed;
            color: #218838;
        }
        .update-error {
            background: #fdeaea;
            color: #c82333;
        }
        .update-table-wrapper {
            width: 100%;
            overflow-x: auto;
        }
        .update-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 650px;
        }
        .update-table th {
            background: #f0ebff;
            color: #303044;
            font-size: 10px;
            font-weight: 600;
            padding: 11px 8px;
            text-align: left;
        }
        .update-table td {
            padding: 11px 8px;
            border-bottom: 1px solid #eeeeee;
            font-size: 10px;
            color: #303044;
        }
        .update-table tbody tr:hover {
            background: #faf8ff;
        }
        .edit-user-btn {
            border: none;
            background: #eee8ff;
            color: #6337bd;
            padding: 6px 10px;
            border-radius: 5px;
            font-size: 10px;
            text-decoration: none;
        }
        .edit-user-btn:hover {
            background: #6337bd;
            color: #ffffff;
        }
        @media (max-width: 1000px) {
            .update-user-layout {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="page-header">
        <h2>Update User</h2>
    </div>

    <% if (!message.isEmpty()) { %>
    <div class="update-message <%= messageType.equals("success") ? "update-success" : "update-error" %>">
    <%= message %>
    </div>
    <% } %>

    <div class="update-user-layout">

        <div class="update-user-card">

            <div class="update-user-title">
                Update User
            </div>

            <%
            if (selectedUser != null) {
            %>

            <form method="post" action="UpdateUser.jsp">

                <input type="hidden"
                       name="id"
                       value="<%= selectedUser.getId() %>">

                <div class="update-form-group">
                    <label>Username</label>
                    <input type="text"
                           name="username"
                           value="<%= selectedUser.getUsername() %>"
                           required>
                </div>

                <div class="update-form-group">
                    <label>Password</label>
                    <input type="text"
                           name="password"
                           value="<%= selectedUser.getPassword() %>"
                           required>
                </div>

                <div class="update-form-group">
                    <label>User Type</label>
                    <select name="userType" required>

                        <option value="Admin"
                        <%= "Admin".equals(selectedUser.getUserType()) ? "selected" : "" %>>
                        Admin
                        </option>

                        <option value="Employee"
                        <%= "Employee".equals(selectedUser.getUserType()) ? "selected" : "" %>>
                        Employee
                        </option>

                        <option value="Agent User"
                        <%= "Agent User".equals(selectedUser.getUserType()) ? "selected" : "" %>>
                        Agent User
                        </option>

                    </select>
                </div>

                <div class="update-form-group">
                    <label>Full Name</label>
                    <input type="text"
                           name="fullName"
                           value="<%= selectedUser.getFullName() == null ? "" : selectedUser.getFullName() %>"
                    required>
                </div>

                <div class="update-form-group">
                    <label>Mobile</label>
                    <input type="tel"
                           name="mobile"
                           value="<%= selectedUser.getMobile() == null ? "" : selectedUser.getMobile() %>">
                </div>

                <div class="update-form-group">
                    <label>Status</label>

                    <select name="status">

                        <option value="Active"
                        <%= "Active".equals(selectedUser.getStatus()) ? "selected" : "" %>>
                        Active
                        </option>

                        <option value="Inactive"
                        <%= "Inactive".equals(selectedUser.getStatus()) ? "selected" : "" %>>
                        Inactive
                        </option>

                        <option value="Online"
                        <%= "Online".equals(selectedUser.getStatus()) ? "selected" : "" %>>
                        Online
                        </option>

                    </select>

                </div>

                <button type="submit"
                        class="update-btn">
                    <i class="fa fa-save"></i>
                    &nbsp; Update User
                </button>

            </form>

            <%
            } else {
            %>

            <div style="text-align:center;color:#777777;font-size:11px;padding:30px 10px;">
                Select a user from the list to update.
            </div>

            <%
            }
            %>

        </div>

        <div class="update-user-card">

            <div class="update-user-title">
                User List
            </div>

            <div class="update-table-wrapper">

                <table class="update-table">

                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Username</th>
                        <th>Full Name</th>
                        <th>User Type</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>

                    <%
                    int count = 1;

                    if (userList != null && !userList.isEmpty()) {

                    for (User user : userList) {
                    %>

                    <tr>

                        <td>
                            <%= count %>
                        </td>

                        <td>
                            <%= user.getUsername() %>
                        </td>

                        <td>
                            <%= user.getFullName() %>
                        </td>

                        <td>
                            <%= user.getUserType() %>
                        </td>

                        <td>
                            <%= user.getStatus() %>
                        </td>

                        <td>
                            <a href="UpdateUser.jsp?id=<%= user.getId() %>"
                               class="edit-user-btn">
                                <i class="fa fa-pen"></i>
                                &nbsp; Edit
                            </a>
                        </td>

                    </tr>

                    <%
                    count++;
                    }

                    } else {
                    %>

                    <tr>
                        <td colspan="6"
                            style="text-align:center;padding:25px;color:#777777;">
                            No users found.
                        </td>
                    </tr>

                    <%
                    }
                    %>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

    </div>
    </div>
    </body>
    </html>