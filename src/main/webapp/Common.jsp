<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String fullName = (String) session.getAttribute("full_name");
String userType = (String) session.getAttribute("user_type");

if (fullName == null) {
fullName = (String) session.getAttribute("username");
}

if (fullName == null) {
fullName = "User";
}

if (userType == null) {
userType = "";
}

String currentPage = request.getServletPath();
%>

<html>

<head>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.3.1/css/all.min.css"
          rel="stylesheet">

    <style>

        * {
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }


        /* HEADER*/

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 10px;
            background-color: #ffffff;
            box-shadow: 1px 1px 3px grey;
        }

        .header .container {
            display: flex;
            align-items: center;
            gap: 12px;
            position: relative;
        }

        .header .container img {
            object-fit: cover;
        }


        /* HEADER USER DETAILS */

        .profile-text {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .user-name-label {
            font-size: 15px;
            font-weight: 600;
            color: #1a1a1a;
            text-transform: capitalize;
        }

        .super-admin {
            font-size: 12px;
            font-weight: 400;
            color: #718096;
        }


        /* DROPDOWN */

        .dropdown-arrow {
            color: #4a5568;
            display: flex;
            align-items: center;
            padding-right: 4px;
            cursor: pointer;
        }

        .dropdown-menu {
            position: absolute;
            top: 115%;
            right: 0;
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            min-width: 180px;
            display: none;
            flex-direction: column;
            padding: 4px 0;
            z-index: 1000;
        }

        .dropdown-menu.show {
            display: flex;
        }

        .dropdown-item {
            padding: 10px 16px;
            font-size: 14px;
            color: #1a1a1a;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 400;
            cursor: default;
        }

        .dropdown-item:hover {
            background-color: transparent;
            color: #1a1a1a;
        }


        /* SIDEBAR */

        .sidebar {
            width: 260px;
            height: 100%;
            min-height: 100vh;
            position: relative;
            background: #24056f;
            z-index: 100;
            display: flex;
            flex-direction: column;
            transition: all 0.3s ease;
            bottom: 0;
            overflow-y: auto;
        }

        .sidebar-user-info {
            display: flex;
            flex-direction: row;
            margin: 10px;
        }

        .sidebar-user-info .profile-text {
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 2px;
            color: white;
        }

        .profile-avatar {
            width: 42px;
            height: 42px;
            background-color: #4908e8;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            color: white;
            margin: 5px 8px;
        }


        /* SIDEBAR LINKS*/

        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 25px;
            color: white;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .sidebar-link.active {
            margin: 5px 10px 0px 10px;
            background-color: #583d9c;
            border-radius: 8px;
            font-weight: 700;
        }

        .sidebar-link:hover {
            margin: 5px 10px 0px 10px;
            border-radius: 8px;
            background-color: #583d9c;
        }


        /* LOGOUT */

        .sidebar-footer {
            margin-top: 50px;
            padding: 5px 10px;
            border-top: 1px solid white;
        }

        .btn-logout {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 11px 25px;
            color: red;
            border-radius: 10px;
            text-decoration: none;
            font-size: 18px;
            font-weight: 500;
            width: 50%;
            transition: all 0.3s ease;
        }

        .btn-logout:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

    </style>

</head>


<body>


<!-- HEADER -->

<div style="background-color: white">

    <nav class="header">

        <!-- Skyline Logo -->

        <img alt="logo" height="50" width="150" src="<%=request.getContextPath()%>/Images/skyline_logo.png">


        <div class="container">

            <!-- User Logo -->

            <img alt="user logo" height="44" width="44"  src="<%=request.getContextPath()%>/Images/user_logo.png">


            <!-- Logged-in User Details -->

            <div class="profile-text">

                <span class="user-name-label">
                    <%= fullName %>
                </span>

                <span class="super-admin">
                    <%= userType %>
                </span>

            </div>


            <!-- Dropdown Arrow -->

            <div class="dropdown-arrow" id="arrowToggle">

                <i class="fa fa-sort-desc"
                        aria-hidden="true">
                </i>

            </div>


            <!-- User Role Dropdown -->

            <div class="dropdown-menu" id="rolesMenu">

                <div class="dropdown-item">

                    <i class="fa fa-user-shield"
                            aria-hidden="true">
                    </i>

                    <span>
                        Admin User
                    </span>

                </div>


                <div class="dropdown-item">

                    <i class="fa fa-user"
                            aria-hidden="true">
                    </i>

                    <span>
                        Employee User
                    </span>

                </div>


                <div class="dropdown-item">

                    <i class="fa fa-user-tie"
                            aria-hidden="true">
                    </i>

                    <span>
                        Agent User
                    </span>

                </div>

            </div>

        </div>

    </nav>

</div>



<!-- MAIN LAYOUT-->

<div class="layout-wrapper"
        style="display: flex; height: calc(100vh - 70px);">


    <!--SIDEBAR-->

    <div class="sidebar">
        <!-- Logged-in User -->

        <div class="sidebar-user-info">
            <div class="profile-avatar">
                <i class="fa fa-user-circle"
                        aria-hidden="true">
                </i>
            </div>


            <div class="profile-text">
                <span class="user-name"
                        style="font-weight: 700;">
                    <%= fullName %>
                </span>

                <span class="super-user"
                        style="font-weight: 50;">
                    <%= userType %>
                </span>
            </div>
        </div>



        <!-- Sidebar Navigation -->

        <div class="sidebar-nav">

            <hr>


            <!-- DASHBOARD -->

            <% if ("Admin".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/dashboard.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/dashboard.jsp" >

            <i class="fa fa-home"
                    aria-hidden="true">
            </i>
            Dashboard

            </a>


            <% } else if ("Employee".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/AllEnquiry.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/AllEnquiry.jsp" >

            <i class="fa fa-bars"
               aria-hidden="true">
            </i>
            All Enquiry
            </a>

            <% } %>



            <!--  ADMIN USER MANAGEMENT -->

            <% if ("Admin".equals(userType)) { %>



            <a class="sidebar-link <%= currentPage.endsWith("/AddUser.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/AddUser.jsp" >

            <i class="fa fa-user-plus"
                    aria-hidden="true">
            </i>
            Add User
            </a>


            <a class="sidebar-link <%= currentPage.endsWith("/DisplayUser.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/DisplayUser.jsp" >

            <i class="fa fa-users"
                    aria-hidden="true">
            </i>
            Display User
            </a>


            <a class="sidebar-link <%= currentPage.endsWith("/RemoveUser.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/RemoveUser.jsp" >

            <i class="fa fa-user-minus"
                    aria-hidden="true">
            </i>
            Remove User
            </a>


            <a class="sidebar-link <%= currentPage.endsWith("/UpdateUser.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/UpdateUser.jsp" >

            <i class="fa fa-pencil-square"
                    aria-hidden="true">
            </i>
            Update User
            </a>
            <% } %>


            <!--ALL ENQUIRY-->

            <% if ("Admin".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/AllEnquiry.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/AllEnquiry.jsp" >

            <i class="fa fa-bars"
                    aria-hidden="true">
            </i>
            All Enquiry
            </a>


            <% } %>

            <!-- FOLLOW UP-->

            <% if ("Admin".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/FollowUp.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/FollowUp.jsp" >

            <i class="fa fa-volume-control-phone"
                    aria-hidden="true">
            </i>
            Follow Up
            </a>


            <% } else if ("Employee".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/FollowUp.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/FollowUp.jsp" >

            <i class="fa fa-volume-control-phone"
                    aria-hidden="true">
            </i>
            Follow Up
            </a>

            <% } %>



            <!--LEAD-->

            <% if ("Admin".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/Lead.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/Lead.jsp" >

            <i class="fa fa-line-chart"
                    aria-hidden="true">
            </i>
            Lead
            </a>


            <% } else if ("Employee".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/Lead.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/Lead.jsp" >

            <i class="fa fa-line-chart"
                    aria-hidden="true">
            </i>
            Lead
            </a>

            <% } %>
            <hr>


            <!--DAY BOOK -->

            <% if ("Admin".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/DayBook.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/DayBook.jsp" >

            <i class="fa fa-book"
                    aria-hidden="true">
            </i>
            Day Book
            </a>


            <% } else if ("Employee".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/DayBook.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/DayBook.jsp" >

            <i class="fa fa-book"
                    aria-hidden="true">
            </i>
            Day Book
            </a>

            <% } %>



            <!-- ADMIN FINANCIAL MODULES -->

            <% if ("Admin".equals(userType)) { %>


            <a class="sidebar-link <%= currentPage.endsWith("/PettyCash.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/PettyCash.jsp" >

            <i class="fa fa-briefcase"
                    aria-hidden="true">
            </i>
            Petty Cash

            </a>


            <a class="sidebar-link <%= currentPage.endsWith("/VendorPayment.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/VendorPayment.jsp" >

            <i class="fa fa-credit-card-alt"
                    aria-hidden="true">
            </i>
            Vendor Payment
            </a>

            <a class="sidebar-link <%= currentPage.endsWith("/EmployeePayment.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Admin/EmployeePayment.jsp" >

            <i class="fa fa-inr"
                    aria-hidden="true">
            </i>
            Employee Payment

            </a>



            <!--EMPLOYEE ENTRY MODULES-->

            <% } else if ("Employee".equals(userType)) { %>

            <a class="sidebar-link <%= currentPage.endsWith("/PettyCashEntry.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/PettyCashEntry.jsp" >
            <i class="fa fa-briefcase"
                    aria-hidden="true">
            </i>
            Petty Cash Entry

            </a>

            <a class="sidebar-link <%= currentPage.endsWith("/VendorPaymentEntry.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/VendorPaymentEntry.jsp" >

            <i class="fa fa-credit-card-alt"
                    aria-hidden="true">
            </i>
            Vendor Payment Entry

            </a>
            <a class="sidebar-link <%= currentPage.endsWith("/EmployeePaymentEntry.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/EmployeePaymentEntry.jsp" >

            <i class="fa fa-inr"
               aria-hidden="true">
            </i>
            Employee Payment Entry

            </a>
            <a class="sidebar-link <%= currentPage.endsWith("/FlatSaleEntry.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/FlatSaleEntry.jsp" >

            <i class="fa fa-building"
                    aria-hidden="true">
            </i>
            Flat Sale Entry
            </a>

            <hr>


            <!-- EMPLOYEE PROFILE -->

            <a class="sidebar-link <%= currentPage.endsWith("/Profile.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/Profile.jsp" >

            <i class="fa fa-user"
                    aria-hidden="true">
            </i>

            Profile

            </a>
            <a class="sidebar-link <%= currentPage.endsWith("/ChangePassword.jsp") ? "active" : "" %>"
            href="<%=request.getContextPath()%>/Employee/ChangePassword.jsp">
            <i class="fa fa-lock"
                    aria-hidden="true"> </i>
            Change Password
            </a>
            <% } %>



            <!-- LOGOUT -->

            <div class="sidebar-footer">

                <a class="btn-logout"
                        href="<%=request.getContextPath()%>/logout.jsp">

                    <i class="fa fa-power-off"
                            aria-hidden="true"> </i>
                    Logout
                </a>
            </div>
        </div>
    </div>

    <!--MAIN CONTENT AREA-->

    <div class="main-content"
            style="flex-grow: 1;
            padding: 30px;
            background-color: #f4f7f6;
            overflow-y: auto;">


        <!-- USER DROPDOWN JAVASCRIPT-->

        <script>

            const arrowBtn = document.getElementById("arrowToggle");
            const menuBox = document.getElementById("rolesMenu");

            if (arrowBtn && menuBox) {

                arrowBtn.addEventListener("click", function(e) {

                    e.stopPropagation();

                    menuBox.classList.toggle("show");

                });


                window.addEventListener("click", function() {

                    menuBox.classList.remove("show");

                });

            }

        </script>