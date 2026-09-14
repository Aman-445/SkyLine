<%@ page pageEncoding="UTF-8" %>
<%@ page import="com.skyline.dao.UserDAO" %>

<%
if (!"Employee".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

String username = (String) session.getAttribute("username");

String message = "";
String messageType = "";

if ("POST".equalsIgnoreCase(request.getMethod())) {

String oldPassword = request.getParameter("oldPassword");
String newPassword = request.getParameter("newPassword");
String confirmPassword = request.getParameter("confirmPassword");

if (!newPassword.equals(confirmPassword)) {

message = "New password and confirm password do not match.";
messageType = "error";

} else if (newPassword.length() < 6) {

message = "New password must contain at least 6 characters.";
messageType = "error";

} else {

UserDAO dao = new UserDAO();

if (dao.changePassword(username, oldPassword, newPassword)) {

message = "Password changed successfully.";
messageType = "success";

} else {

message = "Old password is incorrect.";
messageType = "error";
}
}
}
%>

<%@ include file="../Common.jsp" %>

<style>
    .password-card {
        background: #ffffff;
        border-radius: 8px;
        padding: 25px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        max-width: 600px;
    }
    .password-title {
        color: #4b2aa5;
        font-size: 17px;
        font-weight: 600;
        padding-bottom: 10px;
        border-bottom: 1px solid #d8cbed;
        margin-bottom: 25px;
    }
    .password-icon {
        width: 65px;
        height: 65px;
        border-radius: 50%;
        background: #eee8ff;
        color: #4b2aa5;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 20px;
    }
    .password-icon i {
        font-size: 28px;
    }
    .password-group {
        display: flex;
        flex-direction: column;
        margin-bottom: 18px;
    }
    .password-group label {
        font-size: 12px;
        color: #303044;
        margin-bottom: 7px;
    }
    .password-group input {
        width: 100%;
        height: 35px;
        box-sizing: border-box;
        border: 1px solid #dddddd;
        border-radius: 5px;
        padding: 0 11px;
        font-size: 11px;
        outline: none;
    }
    .password-group input:focus {
        border-color: #6337bd;
    }
    .password-btn {
        border: none;
        background: #6337bd;
        color: #ffffff;
        padding: 9px 18px;
        border-radius: 5px;
        font-size: 11px;
        cursor: pointer;
    }
    .password-btn:hover {
        background: #512aa5;
    }
    .password-message {
        margin-bottom: 18px;
        padding: 9px 12px;
        border-radius: 5px;
        font-size: 11px;
    }
    .password-success {
        background: #e8f7ed;
        color: #218838;
    }
    .password-error {
        background: #fdeaea;
        color: #c82333;
    }
    .password-input-box {
    position: relative;
    width: 100%;
}

.password-input-box input {
    padding-right: 40px;
}

.password-eye {
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    color: #777777;
    cursor: pointer;
    font-size: 13px;
}

.password-eye:hover {
    color: #6337bd;
}

</style>

<div class="password-card">

    <div class="password-title">
        Change Password
    </div>

    <% if (!message.isEmpty()) { %>

    <div class="password-message <%= "success".equals(messageType) ? "password-success" : "password-error" %>">
    <%= message %>
</div>

<% } %>

<div class="password-icon">
    <i class="fa fa-lock"></i>
</div>

<form method="post" action="ChangePassword.jsp">

    <div class="password-group">

        <label>Current Password</label>

        <div class="password-input-box">
            <input type="password"
                   name="oldPassword"
                   id="oldPassword"
                   placeholder="Enter current password"
                   required>
            <i class="fa fa-eye password-eye"
               onclick="togglePassword('oldPassword', this)"></i>
        </div>
    </div>

    <div class="password-group">

        <label>New Password</label>

        <div class="password-input-box">
            <input type="password"
                   name="newPassword"
                   id="newPassword"
                   placeholder="Enter new password"
                   minlength="6"
                   required>
            <i class="fa fa-eye password-eye"
               onclick="togglePassword('newPassword', this)"></i>
        </div>

    </div>

    <div class="password-group">

        <label>Confirm New Password</label>

        <div class="password-input-box">
            <input type="password"
                   name="confirmPassword"
                   id="confirmPassword"
                   placeholder="Confirm new password"
                   minlength="6"
                   required>
            <i class="fa fa-eye password-eye"
               onclick="togglePassword('confirmPassword', this)"></i>
        </div>

    </div>

    <button type="submit"
            class="password-btn">

        <i class="fa fa-key"></i>
        &nbsp; Change Password

    </button>

</form>

</div>

</div>
</div>

<script>
    function togglePassword(inputId, icon) {
        const input = document.getElementById(inputId);

        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
</script>

</body>
</html>