<%@ page import="java.sql.*, com.skyline.util.DBConnection" %>

<%
String userType = request.getParameter("user_type");
String username = request.getParameter("username");
String password = request.getParameter("password");

try (Connection conn = DBConnection.getConnection()) {

String sql = "SELECT * FROM users WHERE username = ? AND password = ? AND user_type = ?";

PreparedStatement ps = conn.prepareStatement(sql);

ps.setString(1, username);
ps.setString(2, password);
ps.setString(3, userType);

ResultSet rs = ps.executeQuery();

if (rs.next()) {

// Store logged-in user details in session
session.setAttribute("username", rs.getString("username"));
session.setAttribute("user_type", rs.getString("user_type"));
session.setAttribute("full_name", rs.getString("full_name"));

// Redirect according to user role
if ("Admin".equals(userType)) {
response.sendRedirect("Admin/dashboard.jsp");

} else if ("Employee".equals(userType)) {
response.sendRedirect("Employee/AllEnquiry.jsp");

} else {
request.setAttribute("errorMessage", "This user type is not configured yet.");
request.getRequestDispatcher("login.jsp").forward(request, response);           //request.getRequestDispatcher("login.jsp") login.jsp ko find karega and .forward(request, response): current request and response ko login.jsp par forward karega
}

} else {

request.setAttribute("errorMessage",
"Invalid username, password, or user type.");

request.getRequestDispatcher("login.jsp").forward(request, response);
}

} catch (Exception e) {

e.printStackTrace();

request.setAttribute("errorMessage",
"Database connection error. Please try again.");

request.getRequestDispatcher("login.jsp").forward(request, response);
}
%>