<%@ page pageEncoding="UTF-8" %>
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
String username = request.getParameter("username");
String password = request.getParameter("password");
String userType = request.getParameter("userType");
String fullName = request.getParameter("fullName");
String mobile = request.getParameter("mobile");
String status = request.getParameter("status");

try {
User user = new User();

user.setUsername(username);
user.setPassword(password);
user.setUserType(userType);
user.setFullName(fullName);
user.setMobile(mobile);
user.setStatus(status);

UserDAO dao = new UserDAO();

if (dao.addUser(user)) {
message = "User added successfully.";
messageType = "success";
} else {
message = "Unable to add user. Username may already exist.";
messageType = "error";
}

} catch (Exception e) {
message = "Please enter valid user details.";
messageType = "error";
}
}
%>

<%@ include file="../Common.jsp" %>

<style>
    .user-card {
        background: #ffffff;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        max-width: 850px;
    }
    .user-title {
        color: #4b2aa5;
        font-size: 16px;
        font-weight: 600;
        padding-bottom: 10px;
        border-bottom: 1px solid #cfc2e8;
        margin-bottom: 22px;
    }
    .user-form-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0,1fr));
        gap: 18px 22px;
    }
    .user-form-group {
        display: flex;
        flex-direction: column;
    }
    .user-form-group label {
        font-size: 12px;
        color: #303044;
        margin-bottom: 7px;
    }
    .user-form-group input,
    .user-form-group select {
        width: 100%;
        height: 34px;
        box-sizing: border-box;
        border: 1px solid #dddddd;
        border-radius: 5px;
        padding: 0 10px;
        font-size: 11px;
        outline: none;
    }
    .user-form-group input:focus,
    .user-form-group select:focus {
        border-color: #6337bd;
    }
    .required {
        color: #e63946;
    }
    .user-save-btn {
        margin-top: 20px;
        border: none;
        background: #6337bd;
        color: #ffffff;
        padding: 9px 18px;
        border-radius: 5px;
        font-size: 12px;
        cursor: pointer;
    }
    .user-save-btn:hover {
        background: #512aa5;
    }
    .user-message {
        margin-bottom: 15px;
        padding: 9px 12px;
        border-radius: 5px;
        font-size: 12px;
    }
    .user-success {
        background: #e8f7ed;
        color: #218838;
    }
    .user-error {
        background: #fdeaea;
        color: #c82333;
    }
    @media (max-width: 700px) {
        .user-form-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="page-header">
    <h2>Add User</h2>
</div>

<div class="user-card">

    <div class="user-title">
        Add User
    </div>

    <% if (!message.isEmpty()) { %>
    <div class="user-message <%= messageType.equals("success") ? "user-success" : "user-error" %>">
    <%= message %>
</div>
<% } %>

<form method="post" action="AddUser.jsp">

    <div class="user-form-grid">

        <div class="user-form-group">
            <label>
                Username <span class="required">*</span>
            </label>
            <input type="text"
                   name="username"
                   placeholder="Enter username"
                   required>
        </div>

        <div class="user-form-group">
            <label>
                Password <span class="required">*</span>
            </label>
            <input type="password"
                   name="password"
                   placeholder="Enter password"
                   required>
        </div>

        <div class="user-form-group">
            <label>
                User Type <span class="required">*</span>
            </label>
            <select name="userType" required>
                <option value="">Select User Type</option>
                <option value="Admin">Admin</option>
                <option value="Employee">Employee</option>
                <option value="Agent User">Agent User</option>
            </select>
        </div>

        <div class="user-form-group">
            <label>
                Full Name <span class="required">*</span>
            </label>
            <input type="text"
                   name="fullName"
                   placeholder="Enter full name"
                   required>
        </div>

        <div class="user-form-group">
            <label>
                Mobile
            </label>
            <input type="tel"
                   name="mobile"
                   placeholder="Enter mobile number">
        </div>

        <div class="user-form-group">
            <label>
                Status
            </label>
            <select name="status">
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
                <option value="Online">Online</option>
            </select>
        </div>

    </div>

    <button type="submit" class="user-save-btn">
        <i class="fa fa-user-plus"></i>
        &nbsp; Add User
    </button>

</form>

</div>

</div>
</div>
</body>
</html>