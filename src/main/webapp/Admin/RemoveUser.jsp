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

if ("POST".equalsIgnoreCase(request.getMethod())) {

String idText = request.getParameter("id");

try {
int id = Integer.parseInt(idText);

UserDAO dao = new UserDAO();

if (dao.deleteUser(id)) {
message = "User removed successfully.";
messageType = "success";
} else {
message = "Unable to remove user.";
messageType = "error";
}

} catch (Exception e) {
message = "Invalid user selected.";
messageType = "error";
}
}

UserDAO dao = new UserDAO();
List<User> userList = dao.getAllUsers();
    %>

    <%@ include file="../Common.jsp" %>

    <style>
        .remove-user-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        .remove-user-title {
            color: #4b2aa5;
            font-size: 16px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 1px solid #cfc2e8;
            margin-bottom: 20px;
        }
        .remove-user-table-wrapper {
            width: 100%;
            overflow-x: auto;
        }
        .remove-user-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 750px;
        }
        .remove-user-table th {
            background: #f0ebff;
            color: #303044;
            font-size: 10px;
            font-weight: 600;
            padding: 11px 8px;
            text-align: left;
        }
        .remove-user-table td {
            padding: 12px 8px;
            border-bottom: 1px solid #eeeeee;
            font-size: 10px;
            color: #303044;
        }
        .remove-user-table tbody tr:hover {
            background: #faf8ff;
        }
        .remove-btn {
            border: none;
            background: #fdeaea;
            color: #e63946;
            padding: 6px 10px;
            border-radius: 5px;
            font-size: 10px;
            cursor: pointer;
        }
        .remove-btn:hover {
            background: #e63946;
            color: #ffffff;
        }
        .remove-message {
            margin-bottom: 15px;
            padding: 9px 12px;
            border-radius: 5px;
            font-size: 12px;
        }
        .remove-success {
            background: #e8f7ed;
            color: #218838;
        }
        .remove-error {
            background: #fdeaea;
            color: #c82333;
        }
    </style>

    <div class="page-header">
        <h2>Remove User</h2>
    </div>

    <div class="remove-user-card">

        <div class="remove-user-title">
            Remove User
        </div>

        <% if (!message.isEmpty()) { %>
        <div class="remove-message <%= messageType.equals("success") ? "remove-success" : "remove-error" %>">
        <%= message %>
    </div>
    <% } %>

    <div class="remove-user-table-wrapper">

        <table class="remove-user-table">

            <thead>
            <tr>
                <th>#</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>User Type</th>
                <th>Mobile</th>
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
                    <%= user.getMobile() == null ? "-" : user.getMobile() %>
                </td>

                <td>
                    <%= user.getStatus() %>
                </td>

                <td>

                    <form method="post"
                          action="RemoveUser.jsp"
                          style="display:inline;"
                          onsubmit="return confirm('Are you sure you want to remove this user?');">

                        <input type="hidden"
                               name="id"
                               value="<%= user.getId() %>">

                        <button type="submit"
                                class="remove-btn">
                            <i class="fa fa-trash"></i>
                            &nbsp; Remove
                        </button>

                    </form>

                </td>

            </tr>

            <%
            count++;
            }

            } else {
            %>

            <tr>
                <td colspan="7"
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
    </body>
    </html>