<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="com.skyline.model.DayBook" %>
<%@ page import="com.skyline.dao.DayBookDAO" %>

<%
if (!"Employee".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

String message = "";
String messageType = "";
DayBook editDayBook = null;

String editId = request.getParameter("editId");

if (editId != null && !editId.isEmpty()) {
try {
DayBookDAO tempDao = new DayBookDAO();
editDayBook = tempDao.getDayBookById(Integer.parseInt(editId));
} catch (Exception e) {
e.printStackTrace();
}
}

if ("POST".equalsIgnoreCase(request.getMethod())) {
String action = request.getParameter("action");

if ("update".equals(action)) {
try {
int id = Integer.parseInt(request.getParameter("id"));
String transactionDate = request.getParameter("transactionDate");
String particulars = request.getParameter("particulars");
String transactionType = request.getParameter("transactionType");
String paymentMode = request.getParameter("paymentMode");
String amountText = request.getParameter("amount");

double amount = Double.parseDouble(amountText);

DayBook dayBook = new DayBook();

dayBook.setId(id);
dayBook.setTransactionDate(Date.valueOf(transactionDate));
dayBook.setParticulars(particulars);
dayBook.setTransactionType(transactionType);
dayBook.setPaymentMode(paymentMode);
dayBook.setAmount(amount);

DayBookDAO dao = new DayBookDAO();

if (dao.updateDayBook(dayBook)) {
message = "Day book entry updated successfully.";
messageType = "success";
editDayBook = null;
} else {
message = "Unable to update day book entry.";
messageType = "error";
}

} catch (Exception e) {
message = "Please enter valid details.";
messageType = "error";
}
}

if ("add".equals(action)) {
String transactionDate = request.getParameter("transactionDate");
String particulars = request.getParameter("particulars");
String transactionType = request.getParameter("transactionType");
String paymentMode = request.getParameter("paymentMode");
String amountText = request.getParameter("amount");

try {
double amount = Double.parseDouble(amountText);

DayBook dayBook = new DayBook();

dayBook.setTransactionDate(Date.valueOf(transactionDate));
dayBook.setParticulars(particulars);
dayBook.setTransactionType(transactionType);
dayBook.setPaymentMode(paymentMode);
dayBook.setAmount(amount);

DayBookDAO dao = new DayBookDAO();

if (dao.addDayBook(dayBook)) {
message = "Day book entry added successfully.";
messageType = "success";
} else {
message = "Unable to add day book entry.";
messageType = "error";
}

} catch (Exception e) {
message = "Please enter valid details.";
messageType = "error";
}
}

if ("delete".equals(action)) {
try {
int id = Integer.parseInt(request.getParameter("id"));

DayBookDAO dao = new DayBookDAO();

if (dao.deleteDayBook(id)) {
message = "Day book entry deleted successfully.";
messageType = "success";
} else {
message = "Unable to delete entry.";
messageType = "error";
}

} catch (Exception e) {
message = "Invalid entry.";
messageType = "error";
}
}
}

DayBookDAO dao = new DayBookDAO();

String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");
String transactionType = request.getParameter("transactionType");
String paymentMode = request.getParameter("paymentMode");
String search = request.getParameter("search");

if (search == null) {
search = "";
}

List<DayBook> dayBookList;

    if (!search.trim().isEmpty()) {

    dayBookList = dao.searchDayBooks(search.trim());

    } else if ((fromDate != null && !fromDate.isEmpty())
    || (toDate != null && !toDate.isEmpty())
    || (transactionType != null && !transactionType.isEmpty())
    || (paymentMode != null && !paymentMode.isEmpty())) {

    dayBookList = dao.getFilteredDayBooks(
    fromDate,
    toDate,
    transactionType,
    paymentMode
    );

    } else {

    dayBookList = dao.getAllDayBooks();
    }

    double balance = 0;
    %>

    <%@ include file="../Common.jsp" %>

    <style>
        .daybook-filter-box {
            background: #ffffff;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            margin-bottom: 15px;
        }
        .daybook-filter-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr 1fr auto auto;
            gap: 12px;
            align-items: end;
        }
        .daybook-filter-group {
            display: flex;
            flex-direction: column;
        }
        .daybook-filter-group label {
            font-size: 10px;
            color: #303044;
            margin-bottom: 5px;
        }
        .daybook-filter-group input,
        .daybook-filter-group select {
            width: 100%;
            height: 32px;
            box-sizing: border-box;
            border: 1px solid #dddddd;
            border-radius: 5px;
            padding: 0 8px;
            font-size: 10px;
            outline: none;
            background: #ffffff;
        }
        .daybook-filter-group input:focus,
        .daybook-filter-group select:focus {
            border-color: #1769e0;
        }
        .daybook-filter-btn {
            height: 32px;
            border: none;
            background: #1769e0;
            color: #ffffff;
            border-radius: 5px;
            padding: 0 16px;
            font-size: 10px;
            cursor: pointer;
        }
        .daybook-filter-btn:hover {
            background: #0d5bc4;
        }
        .daybook-add-btn {
            height: 32px;
            border: none;
            background: #21a366;
            color: #ffffff;
            border-radius: 5px;
            padding: 0 16px;
            font-size: 10px;
            cursor: pointer;
        }
        .daybook-add-btn:hover {
            background: #198754;
        }
        .daybook-card {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        .daybook-title {
            color: #24056f;
            font-size: 20px;
            font-weight: 600;
            padding: 11px 14px;
            border-bottom: 1px solid #d5e5f5;
        }
        .daybook-table-wrapper {
            width: 100%;
            overflow-x: auto;
        }
        .daybook-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }
        .daybook-table th {
            background: #f6f9fc;
            color: #303044;
            font-size: 10px;
            font-weight: 600;
            padding: 11px 8px;
            text-align: left;
            white-space: nowrap;
        }
        .daybook-table td {
            padding: 12px 8px;
            border-bottom: 1px solid #eeeeee;
            font-size: 10px;
            color: #303044;
            white-space: nowrap;
        }
        .daybook-table tbody tr:hover {
            background: #fafcff;
        }
        .income-amount {
            color: #218838;
            font-weight: 500;
        }
        .expense-amount {
            color: #e63946;
            font-weight: 500;
        }
        .balance-amount {
            color: #303044;
            font-weight: 500;
        }
        .daybook-actions {
            display: flex;
            gap: 5px;
        }
        .daybook-view,
        .daybook-edit,
        .daybook-delete {
            width: 27px;
            height: 27px;
            border: none;
            border-radius: 5px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            text-decoration: none;
        }
        .daybook-view {
            background: #edf5ff;
            color: #2878c8;
        }
        .daybook-edit {
            background: #fff5df;
            color: #e39a00;
        }
        .daybook-delete {
            background: #fff0f0;
            color: #e63946;
        }
        .daybook-view:hover {
            color: #2878c8;
        }
        .daybook-edit:hover {
            color: #e39a00;
        }
        .daybook-delete:hover {
            color: #e63946;
        }
        .daybook-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 14px;
        }
        .daybook-count {
            font-size: 10px;
            color: #777777;
        }
        .daybook-pagination {
            display: flex;
            gap: 5px;
        }
        .daybook-page-btn {
            width: 30px;
            height: 28px;
            border: 1px solid #dddddd;
            background: #ffffff;
            color: #555555;
            border-radius: 5px;
            font-size: 10px;
        }
        .daybook-page-btn.active {
            background: #1769e0;
            color: #ffffff;
            border-color: #1769e0;
        }
        .daybook-message {
            padding: 9px 12px;
            border-radius: 5px;
            font-size: 11px;
            margin-bottom: 15px;
        }
        .daybook-success {
            background: #e8f7ed;
            color: #218838;
        }
        .daybook-error {
            background: #fdeaea;
            color: #c82333;
        }

         .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
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
            background: white;
            border: 1px solid #ddd;
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

        @media (max-width: 1100px) {
            .daybook-filter-grid {
                grid-template-columns: 1fr 1fr 1fr;
            }
        }
        @media (max-width: 700px) {
            .daybook-filter-grid {
                grid-template-columns: 1fr;
            }
            .daybook-footer {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }
    </style>

    <div class="page-header">
        <h2>Day Book</h2>

        <form method="get"
              action="DayBook.jsp"
              class="search-box">

            <i class="fa fa-search"></i>

            <input type="text"
                   name="search"
                   value="<%= search %>"
                   placeholder="Search day book...">
        </form>
    </div>

    <% if (!message.isEmpty()) { %>
    <div class="daybook-message <%= "success".equals(messageType) ? "daybook-success" : "daybook-error" %>">
    <%= message %>
    </div>
    <% } %>

    <div class="daybook-filter-box">
        <form method="get" action="DayBook.jsp">
            <div class="daybook-filter-grid">
                <div class="daybook-filter-group">
                    <label>From Date</label>
                    <input type="date" name="fromDate">
                </div>
                <div class="daybook-filter-group">
                    <label>To Date</label>
                    <input type="date" name="toDate">
                </div>
                <div class="daybook-filter-group">
                    <label>Transaction Type</label>
                    <select name="transactionType">
                        <option value="">All</option>
                        <option value="Income">Income</option>
                        <option value="Expense">Expense</option>
                    </select>
                </div>
                <div class="daybook-filter-group">
                    <label>Payment Mode</label>
                    <select name="paymentMode">
                        <option value="">All</option>
                        <option value="Cash">Cash</option>
                        <option value="UPI">UPI</option>
                        <option value="Bank Transfer">Bank Transfer</option>
                        <option value="Cheque">Cheque</option>
                    </select>
                </div>
                <button type="submit" class="daybook-filter-btn">
                    <i class="fa fa-filter"></i>
                    &nbsp; Filter
                </button>
                <button type="button"
                        class="daybook-add-btn"
                        onclick="document.getElementById('addEntryBox').style.display='block';">
                    <i class="fa fa-plus"></i>
                    &nbsp; Add Entry
                </button>
            </div>
        </form>
    </div>

    <div id="addEntryBox"
         style="display:<%= editDayBook == null ? "none" : "block" %>;background:#ffffff;border-radius:8px;padding:15px;margin-bottom:15px;box-shadow:0 2px 12px rgba(0,0,0,0.08);">

    <div class="daybook-title"
         style="margin:-15px -15px 15px -15px;">
        <%= editDayBook == null ? "Add Day Book Entry" : "Update Day Book Entry" %>
    </div>

    <form method="post" action="DayBook.jsp">
        <input type="hidden"
               name="action"
               value="<%= editDayBook == null ? "add" : "update" %>">

        <% if (editDayBook != null) { %>
        <input type="hidden"
               name="id"
               value="<%= editDayBook.getId() %>">
        <% } %>

        <div class="daybook-filter-grid">

            <div class="daybook-filter-group">
                <label>Date</label>
                <input type="date"
                       name="transactionDate"
                       value="<%= editDayBook == null ? "" : editDayBook.getTransactionDate() %>"
                required>
            </div>

            <div class="daybook-filter-group">
                <label>Particulars</label>
                <input type="text"
                       name="particulars"
                       value="<%= editDayBook == null ? "" : editDayBook.getParticulars() %>"
                placeholder="Enter particulars"
                required>
            </div>

            <div class="daybook-filter-group">
                <label>Transaction Type</label>
                <select name="transactionType"
                        required>
                    <option value="">Select Type</option>
                    <option value="Income"
                    <%= editDayBook != null && "Income".equals(editDayBook.getTransactionType()) ? "selected" : "" %>>
                    Income
                    </option>
                    <option value="Expense"
                    <%= editDayBook != null && "Expense".equals(editDayBook.getTransactionType()) ? "selected" : "" %>>
                    Expense
                    </option>
                </select>
            </div>

            <div class="daybook-filter-group">
                <label>Payment Mode</label>
                <select name="paymentMode"
                        required>
                    <option value="">Select Mode</option>
                    <option value="Cash"
                    <%= editDayBook != null && "Cash".equals(editDayBook.getPaymentMode()) ? "selected" : "" %>>
                    Cash
                    </option>
                    <option value="UPI"
                    <%= editDayBook != null && "UPI".equals(editDayBook.getPaymentMode()) ? "selected" : "" %>>
                    UPI
                    </option>
                    <option value="Bank Transfer"
                    <%= editDayBook != null && "Bank Transfer".equals(editDayBook.getPaymentMode()) ? "selected" : "" %>>
                    Bank Transfer
                    </option>
                    <option value="Cheque"
                    <%= editDayBook != null && "Cheque".equals(editDayBook.getPaymentMode()) ? "selected" : "" %>>
                    Cheque
                    </option>
                </select>
            </div>

            <div class="daybook-filter-group">
                <label>Amount</label>
                <input type="number"
                       name="amount"
                       value="<%= editDayBook == null ? "" : editDayBook.getAmount() %>"
                placeholder="Enter amount"
                step="0.01"
                required>
            </div>

            <button type="submit"
                    class="daybook-add-btn">
                <i class="fa fa-save"></i>
                &nbsp; <%= editDayBook == null ? "Save Entry" : "Update Entry" %>
            </button>

        </div>
    </form>
    </div>

    <div class="daybook-card">

        <div class="daybook-title">
            Day Book List
        </div>

        <div class="daybook-table-wrapper">

            <table class="daybook-table">

                <thead>
                <tr>
                    <th>S No</th>
                    <th>Date</th>
                    <th>Particulars</th>
                    <th>Transaction Type</th>
                    <th>Payment Mode</th>
                    <th>Income (₹)</th>
                    <th>Expense (₹)</th>
                    <th>Balance (₹)</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>

                <%
                int count = 1;

                if (dayBookList != null && !dayBookList.isEmpty()) {

                for (DayBook dayBook : dayBookList) {

                double income = 0;
                double expense = 0;

                if ("Income".equalsIgnoreCase(dayBook.getTransactionType())) {
                income = dayBook.getAmount();
                balance += income;
                } else if ("Expense".equalsIgnoreCase(dayBook.getTransactionType())) {
                expense = dayBook.getAmount();
                balance -= expense;
                }
                %>

                <tr>

                    <td>
                        <%= count %>
                    </td>

                    <td>
                        <%= dayBook.getTransactionDate() %>
                    </td>

                    <td>
                        <%= dayBook.getParticulars() %>
                    </td>

                    <td>
                        <%= dayBook.getTransactionType() %>
                    </td>

                    <td>
                        <%= dayBook.getPaymentMode() %>
                    </td>

                    <td class="income-amount">
                        <%
                        if (income > 0) {
                        %>
                        <%= String.format("%.2f", income) %>
                        <%
                        } else {
                        %>
                        -
                        <%
                        }
                        %>
                    </td>

                    <td class="expense-amount">
                        <%
                        if (expense > 0) {
                        %>
                        <%= String.format("%.2f", expense) %>
                        <%
                        } else {
                        %>
                        -
                        <%
                        }
                        %>
                    </td>

                    <td class="balance-amount">
                        <%= String.format("%.2f", balance) %>
                    </td>

                    <td>

                        <div class="daybook-actions">

                            <a href="DayBookView.jsp?id=<%= dayBook.getId() %>"
                               class="daybook-view"
                               title="View">
                                <i class="fa fa-eye"></i>
                            </a>

                            <a href="DayBook.jsp?editId=<%= dayBook.getId() %>"
                               class="daybook-edit"
                               title="Edit">
                                <i class="fa fa-pen"></i>
                            </a>

                            <form method="post"
                                  action="DayBook.jsp"
                                  style="display:inline;"
                                  onsubmit="return confirm('Are you sure you want to delete this entry?');">

                                <input type="hidden"
                                       name="action"
                                       value="delete">

                                <input type="hidden"
                                       name="id"
                                       value="<%= dayBook.getId() %>">

                                <button type="submit"
                                        class="daybook-delete"
                                        title="Delete">
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

                    <td colspan="9"
                        style="text-align:center;padding:25px;color:#777777;">
                        No day book entries found.
                    </td>

                </tr>

                <%
                }
                %>

                </tbody>

            </table>

        </div>

        <div class="daybook-footer">

            <div class="daybook-count">
                Showing 1 to <%= dayBookList.size() %> of <%= dayBookList.size() %> entries
            </div>

            <div class="daybook-pagination">

                <button type="button"
                        class="daybook-page-btn">
                    <i class="fa fa-chevron-left"></i>
                </button>

                <button type="button"
                        class="daybook-page-btn active">
                    1
                </button>

                <button type="button"
                        class="daybook-page-btn">
                    <i class="fa fa-chevron-right"></i>
                </button>

            </div>

        </div>

    </div>

    </div>
    </div>
    </body>
    </html>