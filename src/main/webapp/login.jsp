<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Skyline CRM Login</title>
    <!--    icons from font awesome website-->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!--   Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;

            background-image: url('Images/building_image1.png');
            background-size: cover;      /* Makes sure the image covers the whole screen */
            background-position: center; /* Centers the image */
            background-repeat: no-repeat;

        }

        .login-container {
            background-color: #cddafb;
            width: 100%;
            max-width: 400px;
            padding: 30px 30px;
            border-radius: 12px;
            text-align: center;
            opacity: 0.9;
        }

        .login-container img {
            object-fit: contain;
        }

        .login-header h2 {
            color: #1a1a1a;
            font-size: 22px;
            font-weight: 600;
        }

        .login-header p {
            color: #718096;
            font-size: 14px;
            margin-top: 3px;
        }

        .input-group {
            margin-bottom: 10px;
            text-align: left;
        }

        .input-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 3px;
        }

        .input-group input, select {
            width: 100%;
            padding: 8px 10px;
            font-size: 15px;
            border-radius: 8px;
            border: 2px solid #959090;
            transition: border-color 0.3s ease;
            appearance: none;
        }

        .input-group input:focus {
            border-color: blue;
        }

        /* Password toggle icon */
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 38px;
            color: #a0aec0;
            cursor: pointer;
            font-size: 16px;
        }

        .login-btn {
            width: 100%;
            padding: 12px;
            background-color: #144e94;
            color: white;
            font-size: 18px;
            font-weight:700;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .login-btn:hover {
            background-color: darkblue;
        }

        .error-message {
            color: red;
            font-size: 13px;
            margin-top: -10px;
            margin-bottom: 15px;
            display: none; /* Hidden by default */
        }

        .form-check input{
            border: 2px solid #959090;
        }

        /* Finds the label inside an input-group that has a required input */
        .input-group:has(input:required) label::after {
                content: " *";
                color: red;
                font-weight: bold;
        }


    </style>
</head>
<body>

<div class="login-container">
    <!-- Logo -->
    <img src="Images/skyline_logo.png" alt="Skyline CRM Logo" height="60" width="180">

    <div class="login-header">
        <h2>Welcome</h2>
        <p>Please enter your details to sign in</p>
    </div>

    <form id="loginForm" action="login_action.jsp" method="POST">

        <!-- Dynamic Error Message Box -->
        <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
        %>
        <div class="error-message" style="display: block; text-align: center;"><%= errorMessage %></div>
        <%
        }
        %>

        <div class="input-group">
            <label>User Type</label>
            <!--            <input type="text" id="usertype" placeholder="choose your type" required>-->
            <select name="user_type" required>
                <option value="Admin">Admin User</option>
                <option value="Employee">Employee User</option>
                <option value="Agent User">Agent User</option>
            </select>

        </div>

        <div class="input-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter your username" required>
        </div>

        <div class="input-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
            <i class="fa fa-eye toggle-password" id="eyeIcon"></i>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" name="rememberMe" id="rememberMe">
                <label class="form-check-label" for="rememberMe">
                    Remember me
                </label>
            </div>
        </div>

        <button type="submit" class="login-btn">Log In</button>

    </form>
</div>

<script>
    // 1. Password Visibility Toggle
    const passwordInput = document.getElementById('password');
    const eyeIcon = document.getElementById('eyeIcon');

    eyeIcon.addEventListener('click', function () {
        // Toggle the type attribute
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);

        // Toggle the eye icon class
        this.classList.toggle('fa-eye');
        this.classList.toggle('fa-eye-slash');
    });
</script>
</body>
</html>