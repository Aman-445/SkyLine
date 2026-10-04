<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="com.skyline.model.EmployeePayment" %>
<%@ page import="com.skyline.dao.EmployeePaymentDAO" %>
<%@ page import="com.skyline.model.User" %>
<%@ page import="com.skyline.dao.UserDAO" %>

<%
if (!"Employee".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

String message = "";
String messageType = "";

String search = request.getParameter("search");

if (search == null) {
search = "";
}

EmployeePayment editPayment = null;

String editId = request.getParameter("editId");

EmployeePaymentDAO dao = new EmployeePaymentDAO();
UserDAO userDAO = new UserDAO();
List<User> employees = userDAO.getActiveEmployees();

if (editId != null && !editId.isEmpty()) {
try {
editPayment = dao.getEmployeePaymentById(Integer.parseInt(editId));
} catch (Exception e) {
e.printStackTrace();
}
}

if ("POST".equalsIgnoreCase(request.getMethod())) {
String action = request.getParameter("action");

if ("delete".equals(action)) {
try {
int id = Integer.parseInt(request.getParameter("id"));
if (dao.deleteEmployeePayment(id)) {
response.sendRedirect("EmployeePaymentEntry.jsp");
return;
} else {
message = "Unable to delete employee payment.";
messageType = "error";
}
} catch (Exception e) {
e.printStackTrace();
message = "Unable to delete employee payment.";
messageType = "error";
}
}

if ("save".equals(action) || "update".equals(action)) {

String paymentDate = request.getParameter("paymentDate");
String employeeName = request.getParameter("employeeName");
String amountText = request.getParameter("amount");
String paymentMode = request.getParameter("paymentMode");
String remarks = request.getParameter("remarks");

try {
double amount = Double.parseDouble(amountText);
EmployeePayment payment = new EmployeePayment();

if ("update".equals(action)) {
payment.setId(Integer.parseInt(request.getParameter("id")));
}

payment.setPaymentDate(Date.valueOf(paymentDate));
payment.setEmployeeName(employeeName);
payment.setAmount(amount);
payment.setPaymentMode(paymentMode);
payment.setRemarks(remarks);

if ("save".equals(action)) {

if (dao.addEmployeePayment(payment)) {
response.sendRedirect("EmployeePaymentEntry.jsp");
return;
} else {
message = "Unable to save employee payment.";
messageType = "error";
}

} else {

if (dao.updateEmployeePayment(payment)) {
response.sendRedirect("EmployeePaymentEntry.jsp");
return;
} else {
message = "Unable to update employee payment.";
messageType = "error";
}
}

} catch (Exception e) {
e.printStackTrace();
message = "Please enter valid employee payment details.";
messageType = "error";
}
}
}

List<EmployeePayment> paymentList;

    if (!search.trim().isEmpty()) {
    paymentList = dao.searchEmployeePayments(search.trim());
    } else {
    paymentList = dao.getAllEmployeePayments();
    }
    %>

    <%@ include file="../Common.jsp" %>

    <style>
        .payment-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            max-width: 700px;
            margin: 16px auto;
        }

        .card-title {
            color: #24056f;
            font-size: 15px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 1px solid #cfc3e8;
            margin-bottom: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 15px;
        }

        .form-group label {
            font-size: 11px;
            color: #303044;
            margin-bottom: 6px;
        }

        .required {
            color: #e63946;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            box-sizing: border-box;
            border: 1px solid #dddddd;
            border-radius: 5px;
            padding: 8px 9px;
            font-size: 11px;
            color: #555555;
            outline: none;
            background: #ffffff;
        }

        .form-group input,
        .form-group select {
            height: 34px;
        }

        .form-group textarea {
            height: 65px;
            resize: none;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #6337bd;
        }

        .form-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .save-btn,
        .reset-btn {
            border-radius: 5px;
            padding: 8px 16px;
            font-size: 11px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .save-btn {
            border: none;
            background: #6337bd;
            color: #ffffff;
        }

        .reset-btn {
            border: 1px solid #dddddd;
            background: #ffffff;
            color: #555555;
        }

        .save-btn:hover {
            background: #512aa5;
        }

        .message {
            margin-bottom: 14px;
            padding: 9px 12px;
            border-radius: 5px;
            font-size: 11px;
        }

        .success {
            background: #e8f7ed;
            color: #218838;
        }

        .error {
            background: #fdeaea;
            color: #c82333;
        }

        .list-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 18px;
            margin-top: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
        }

        .payment-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 700px;
        }

        .payment-table th {
            background: #f0ebff;
            color: #303044;
            font-size: 10px;
            font-weight: 600;
            padding: 11px 8px;
            text-align: left;
            white-space: nowrap;
        }

        .payment-table td {
            padding: 12px 8px;
            border-bottom: 1px solid #eeeeee;
            font-size: 10px;
            color: #303044;
            white-space: nowrap;
        }

        .payment-table tbody tr:hover {
            background: #faf8ff;
        }

        .action-buttons {
            display: flex;
            gap: 6px;
        }

        .edit-btn,
        .delete-btn {
            width: 27px;
            height: 27px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }

        .edit-btn {
            background: #fff5df;
            color: #e39a00;
        }

        .delete-btn {
            background: #fff0f0;
            color: #e63946;
        }

        .table-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 12px;
            font-size: 10px;
            color: #777777;
        }

        .pagination {
            display: flex;
            gap: 5px;
        }

        .page-btn {
            width: 30px;
            height: 28px;
            border: 1px solid #dddddd;
            background: #ffffff;
            border-radius: 5px;
            cursor: pointer;
        }

        .page-btn.active {
            background: #6337bd;
            color: #ffffff;
            border-color: #6337bd;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 10px 0 18px 0;
        }

        .page-header h2 {
            font-size: 24px;
            font-weight: 600;
            color: #24056f;
        }

        .search-box {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #ffffff;
            border: 1px solid #dddddd;
            border-radius: 8px;
            padding: 8px 12px;
            width: 280px;
        }

        .search-box i {
            color: #718096;
        }

        .search-box input {
            border: none;
            outline: none;
            width: 100%;
            font-size: 14px;
        }

        .search-box button {
            border: none;
            background: none;
            cursor: pointer;
            padding: 0;
        }
    </style>

    <% if (!message.isEmpty()) { %>
    <div class="message <%= messageType %>">
        <%= message %>
    </div>
    <% } %>

    <div class="page-header">
        <h2>Employee Payment</h2>

        <form method="get" action="EmployeePaymentEntry.jsp" class="search-box">
            <i class="fa fa-search"></i>

            <input type="text" name="search" value="<%= search %>" placeholder="Search employee payment...">
        </form>

    </div>

    <div class="payment-card">

        <div class="card-title">
            <%= editPayment == null ? "Employee Payment Entry" : "Edit Employee Payment" %>
        </div>

        <form method="post" action="EmployeePaymentEntry.jsp">

            <input type="hidden" name="action" value="<%= editPayment == null ? "save" : "update" %>">

            <% if (editPayment != null) { %>
            <input type="hidden" name="id" value="<%= editPayment.getId() %>">
            <% } %>

            <div class="form-group">
                <label>
                    Date <span class="required">*</span>
                </label>

                <input type="date" name="paymentDate" value="<%= editPayment != null ? editPayment.getPaymentDate() : "" %>" required>
            </div>

            <div class="form-group">

                <label>
                    Employee Name <span class="required">*</span>
                </label>

                <select name="employeeName" required>

                    <option value="">
                        Select Employee
                    </option>

                    <% for (User employee : employees) { %>

                    <option value="<%= employee.getFullName() %>"
                    <%= editPayment != null
                    && employee.getFullName().equals(editPayment.getEmployeeName()) ? "selected" : "" %>>
                    <%= employee.getFullName() %>
                    </option>
                    <% } %>

                </select>
            </div>

            <div class="form-group">

                <label>
                    Amount
                    (<i class="fa-solid fa-indian-rupee-sign"></i>)
                    <span class="required">*</span>
                </label>

                <input type="number" name="amount" value="<%= editPayment != null ? editPayment.getAmount() : "" %>"
                placeholder="Enter amount"
                step="0.01"
                min="0" required>
            </div>

            <div class="form-group">

                <label>
                    Payment Mode <span class="required">*</span>
                </label>

                <select name="paymentMode" required>

                    <option value="">Select Mode</option>

                    <option value="Cash"
                    <%= editPayment != null && "Cash".equals(editPayment.getPaymentMode()) ? "selected" : "" %>>
                    Cash
                    </option>

                    <option value="UPI"
                    <%= editPayment != null && "UPI".equals(editPayment.getPaymentMode()) ? "selected" : "" %>>
                    UPI
                    </option>

                    <option value="Bank"
                    <%= editPayment != null && "Bank".equals(editPayment.getPaymentMode()) ? "selected" : "" %>>
                    Bank
                    </option>

                    <option value="Cheque"
                    <%= editPayment != null && "Cheque".equals(editPayment.getPaymentMode()) ? "selected" : "" %>>
                    Cheque
                    </option>

                </select>
            </div>

            <div class="form-group">

                <label>
                    Remarks
                </label>

                <textarea name="remarks" placeholder="Enter remarks (optional)"><%= editPayment != null && editPayment.getRemarks() != null ? editPayment.getRemarks() : "" %></textarea>
            </div>

            <div class="form-buttons">

                <button type="submit" class="save-btn">
                    <i class="fa fa-save"></i>
                    &nbsp;
                    <%= editPayment == null ? "Save Payment" : "Update Payment" %>
                </button>

                <% if (editPayment != null) { %>

                <a href="EmployeePaymentEntry.jsp" class="reset-btn">
                    <i class="fa fa-rotate-left"></i>
                    &nbsp; Cancel
                </a>
                <% } else { %>

                <button type="reset" class="reset-btn">
                    <i class="fa fa-rotate-left"></i>
                    &nbsp; Reset
                </button>
                <% } %>

            </div>
        </form>
    </div>

    <div class="list-card">

        <div class="card-title">
            Employee Payment List
        </div>

        <div class="table-container">
            <table class="payment-table">
                <thead>

                <tr>
                    <th>S No</th>
                    <th>Date</th>
                    <th>Employee Name</th>
                    <th>Amount (<i class="fa-solid fa-indian-rupee-sign"></i>)</th>
                    <th>Payment Mode</th>
                    <th>Remarks</th>
                    <th>Action</th>
                </tr>

                </thead>

                <tbody>
                <%
                int count = 1;
                if (paymentList != null && !paymentList.isEmpty()) {
                for (EmployeePayment payment : paymentList) {
                %>
                <tr>

                    <td><%= count %></td>
                    <td><%= payment.getPaymentDate() %></td>
                    <td><%= payment.getEmployeeName() %></td>
                    <td><%= String.format("%.2f", payment.getAmount()) %></td>
                    <td><%= payment.getPaymentMode() %></td>
                    <td><%= payment.getRemarks() == null || payment.getRemarks().isEmpty() ? "-" : payment.getRemarks() %></td>
                    <td>
                        <div class="action-buttons">

                            <a href="EmployeePaymentEntry.jsp?editId=<%= payment.getId() %>" class="edit-btn" title="Edit">
                                <i class="fa fa-pen"></i>
                            </a>

                            <form method="post" action="EmployeePaymentEntry.jsp" style="display:inline;"
                                  onsubmit="return confirm('Are you sure you want to delete this payment?');">

                                <input type="hidden" name="action" value="delete">

                                <input type="hidden" name="id" value="<%= payment.getId() %>">

                                <button type="submit" class="delete-btn" title="Delete">
                                    <i class="fa fa-trash"></i>
                                </button>

                            </form>
                        </div>
                    </td>
                </tr>
                <%
                count++;
                }
                } else {
                %>

                <tr>
                    <td colspan="7" style="text-align:center;padding:25px;color:#777777;">
                        No employee payment entries found.
                    </td>
                </tr>

                <%
                }
                %>

                </tbody>
            </table>
        </div>

        <div class="table-footer">

            <div>
                Showing 1 to <%= paymentList.size() %>
                of <%= paymentList.size() %> entries
            </div>

            <div class="pagination">

                <button type="button" class="page-btn">
                    <i class="fa fa-chevron-left"></i>
                </button>

                <button type="button" class="page-btn active">
                    1
                </button>

                <button type="button" class="page-btn">
                    <i class="fa fa-chevron-right"></i>
                </button>

            </div>
        </div>
    </div>

    </div>
    </div>
    </body>
    </html>