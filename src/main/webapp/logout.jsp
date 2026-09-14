<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String action = request.getParameter("action");

if ("logout".equals(action)) {
session.invalidate();
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        body {
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(90deg,rgba(71, 166, 204, 0.78) 0%, rgba(144, 199, 209, 1) 53%,
                                       rgba(124, 159, 242, 0.83) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logout-wrapper {
            width: 100%;
            max-width: 520px;
            max-height: 800px;
            padding: 20px;
            border-radius: 20px;
            background-color:#8ac1ea;
            box-shadow: 10px 10px 10px rgba(90, 132, 230, 0.91);
        }

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo img {
            width: 190px;
            max-width: 80%;
        }

        .logout-card {
            background: #8ac1ea;
            padding: 42px 40px;
            text-align: center;
        }

        .logout-icon {
            width: 72px;
            height: 72px;
            margin: 0 auto 18px;
            border-radius: 50%;
            background: #91c7cf;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logout-icon i {
            font-size: 34px;
            color: #1769e0;
        }

        .logout-title {
            color: #12315f;
            font-size: 34px;
            font-weight: 700;
            margin-bottom: 12px;
        }

        .title-line {
            width: 80px;
            height: 3px;
            background: #1976e8;
            margin: 0 auto 22px;
            border-radius: 5px;
        }

        .logout-question {
            color: #142d50;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .logout-text {
            color: #718096;
            font-size: 14px;
            margin-bottom: 28px;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 18px;
        }

        .cancel-btn,
        .logout-btn {
            min-width: 160px;
            padding: 11px 18px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
        }

        .cancel-btn {
            background: #c9e6ff;
            color: #1769e0;
            border: 1px solid #1769e0;
        }

        .cancel-btn:hover {
            background: #f1f7ff;
            color: #1769e0;
        }

        .logout-btn {
            background: #1769e0;
            color: #ffffff;
            border: 1px solid #1769e0;
        }

        .logout-btn:hover {
            background: #0d5bc4;
            color: #ffffff;
        }


        @media (max-width: 576px) {
            .logout-card {
                padding: 35px 20px;
            }

            .logout-title {
                font-size: 30px;
            }

            .button-group {
                flex-direction: column;
                gap: 10px;
            }

            .cancel-btn,
            .logout-btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="logout-wrapper">

    <div class="logo">
        <img src="Images/skyline_logo.png" alt="Skyline CRM">
    </div>

    <div class="logout-card">

        <div class="logout-icon">
            <i class="fa-solid fa-right-from-bracket"></i>
        </div>

        <h1 class="logout-title">
            Logout
        </h1>

        <div class="title-line"></div>

        <div class="logout-question">
            Are you sure you want to logout?
        </div>

        <div class="logout-text">
            You will be logged out of Skyline CRM.
        </div>

        <div class="button-group">

            <button type="button"
                    class="btn cancel-btn"
                    onclick="history.back();">
                <i class="fa-solid fa-xmark"></i>
                &nbsp; Cancel
            </button>

            <a href="logout.jsp?action=logout"
               class="btn logout-btn">
                <i class="fa-solid fa-power-off"></i>
                &nbsp; Yes, Logout
            </a>

        </div>

    </div>

</div>

</body>
</html>