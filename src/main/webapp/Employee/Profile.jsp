<%@ page pageEncoding="UTF-8" %>
<%@ page import="com.skyline.model.User" %>
<%@ page import="com.skyline.dao.UserDAO" %>

<%
if (!"Employee".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

String username = (String) session.getAttribute("username");

String message = "";
String messageType = "";

UserDAO dao = new UserDAO();

if ("POST".equalsIgnoreCase(request.getMethod())) {

String fullName = request.getParameter("fullName");
String mobile = request.getParameter("mobile");

if (dao.updateProfile(username, fullName, mobile)) {

session.setAttribute("full_name", fullName);

message = "Profile updated successfully.";
messageType = "success";

} else {

message = "Unable to update profile.";
messageType = "error";
}
}

User user = dao.getUserByUsername(username);
%>

<%@ include file="../Common.jsp" %>

<style>
    .profile-card {
        background: #ffffff;
        border-radius: 8px;
        padding: 25px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        max-width: 700px;
    }
    .profile-title {
        color: #4b2aa5;
        font-size: 17px;
        font-weight: 600;
        padding-bottom: 10px;
        border-bottom: 1px solid #d8cbed;
        margin-bottom: 25px;
    }
    .profile-avatar-large {
        width: 75px;
        height: 75px;
        border-radius: 50%;
        background: #eee8ff;
        color: #4b2aa5;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 20px;
    }
    .profile-avatar-large i {
        font-size: 42px;
    }
    .profile-form {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 18px 20px;
    }
    .profile-group {
        display: flex;
        flex-direction: column;
    }
    .profile-group label {
        font-size: 12px;
        color: #303044;
        margin-bottom: 7px;
    }
    .profile-group input {
        height: 34px;
        border: 1px solid #dddddd;
        border-radius: 5px;
        padding: 0 10px;
        font-size: 11px;
        color: #555555;
        outline: none;
        box-sizing: border-box;
    }
    .profile-group input:focus {
        border-color: #6337bd;
    }
    .profile-group input:disabled {
        background: #f5f5f5;
        color: #777777;
    }
    .profile-save-btn {
        margin-top: 5px;
        border: none;
        background: #6337bd;
        color: #ffffff;
        padding: 9px 18px;
        border-radius: 5px;
        font-size: 11px;
        cursor: pointer;
    }
    .profile-save-btn:hover {
        background: #512aa5;
    }
    .profile-message {
        margin-bottom: 18px;
        padding: 9px 12px;
        border-radius: 5px;
        font-size: 11px;
    }
    .profile-success {
        background: #e8f7ed;
        color: #218838;
    }
    .profile-error {
        background: #fdeaea;
        color: #c82333;
    }
    .profile-status {
        display: inline-block;
        background: #e8f7ed;
        color: #218838;
        padding: 4px 9px;
        border-radius: 12px;
        font-size: 10px;
    }
    @media (max-width: 700px) {
        .profile-form {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="profile-card">

    <div class="profile-title">
        My Profile
    </div>

    <% if (!message.isEmpty()) { %>

    <div class="profile-message <%= "success".equals(messageType) ? "profile-success" : "profile-error" %>">
    <%= message %>
</div>

<% } %>

<div class="profile-avatar-large">
    <i class="fa fa-user"></i>
</div>

<form method="post" action="Profile.jsp">

    <div class="profile-form">

        <div class="profile-group">
            <label>Username</label>
            <input type="text"
                   value="<%= user != null ? user.getUsername() : "" %>"
            disabled>
        </div>

        <div class="profile-group">
            <label>User Type</label>
            <input type="text"
                   value="<%= user != null ? user.getUserType() : "" %>"
            disabled>
        </div>

        <div class="profile-group">
            <label>Full Name</label>
            <input type="text"
                   name="fullName"
                   value="<%= user != null && user.getFullName() != null ? user.getFullName() : "" %>"
            placeholder="Enter full name"
            required>
        </div>

        <div class="profile-group">
            <label>Mobile Number</label>
            <input type="tel"
                   name="mobile"
                   value="<%= user != null && user.getMobile() != null ? user.getMobile() : "" %>"
            placeholder="Enter mobile number"
            required>
        </div>

        <div class="profile-group">
            <label>Status</label>
            <div style="padding-top:8px;">
                    <span class="profile-status">
                        <%= user != null ? user.getStatus() : "Active" %>
                    </span>
            </div>
        </div>

        <div class="profile-group">
            <label> </label>
            <div>
                <button type="submit"
                        class="profile-save-btn">
                    <i class="fa fa-save"></i>
                    &nbsp; Save Changes
                </button>
            </div>
        </div>

    </div>

</form>

</div>

</div>
</div>
</body>
</html>