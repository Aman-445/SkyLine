<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.skyline.model.User" %>
<%@ page import="com.skyline.dao.UserDAO" %>

<%
if (!"Admin".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

UserDAO dao = new UserDAO();
List<User> userList = dao.getAllUsers();
    %>

    <%@ include file="../Common.jsp" %>

    <style>
        .display-user-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        .display-user-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }
        .display-user-title {
            color: #4b2aa5;
            font-size: 16px;
            font-weight: 600;
        }
        .user-table-wrapper {
            width: 100%;
            overflow-x: auto;
        }
        .user-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }
        .user-table th {
            background: #f0ebff;
            color: #303044;
            font-size: 10px;
            font-weight: 600;
            padding: 11px 8px;
            text-align: left;
            white-space: nowrap;
        }
        .user-table td {
            padding: 12px 8px;
            border-bottom: 1px solid #eeeeee;
            font-size: 10px;
            color: #303044;
            white-space: nowrap;
        }
        .user-table tbody tr:hover {
            background: #faf8ff;
        }
        .status-active,
        .status-online,
        .status-inactive {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 9px;
        }
        .status-active {
            background: #e8f7ed;
            color: #218838;
        }
        .status-online {
            background: #e8f1ff;
            color: #2878c8;
        }
        .status-inactive {
            background: #fdeaea;
            color: #c82333;
        }
        .display-count {
            margin-top: 12px;
            font-size: 10px;
            color: #777777;
        }
    </style>

    <div class="page-header">
        <h2>Display User</h2>
    </div>

    <div class="display-user-card">

        <div class="display-user-header">
            <div class="display-user-title">
                User List
            </div>
        </div>

        <div class="user-table-wrapper">

            <table class="user-table">

                <thead>
                <tr>
                    <th>#</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Mobile</th>
                    <th>User Type</th>
                    <th>Status</th>
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
                        <%= user.getMobile() == null ? "-" : user.getMobile() %>
                    </td>

                    <td>
                        <%= user.getUserType() %>
                    </td>

                    <td>

                        <%
                        if ("Active".equals(user.getStatus())) {
                        %>
                        <span class="status-active">
                            Active
                        </span>
                        <%
                        } else if ("Online".equals(user.getStatus())) {
                        %>
                        <span class="status-online">
                            Online
                        </span>
                        <%
                        } else {
                        %>
                        <span class="status-inactive">
                            Inactive
                        </span>
                        <%
                        }
                        %>

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

        <div class="display-count">
            Total Users: <%= userList.size() %>
        </div>

    </div>

    </div>
    </div>
    </body>
    </html>