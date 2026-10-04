<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.skyline.model.DayBook" %>
<%@ page import="com.skyline.model.EmployeePayment" %>
<%@ page import="com.skyline.model.VendorPayment" %>
<%@ page import="com.skyline.dao.DayBookDAO" %>
<%@ page import="com.skyline.dao.EmployeePaymentDAO" %>
<%@ page import="com.skyline.dao.VendorPaymentDAO" %>

<%
if (!"Admin".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

String selectedDateText = request.getParameter("selectedDate");

if (selectedDateText == null || selectedDateText.trim().isEmpty()) {
selectedDateText = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
}

Date selectedDate = Date.valueOf(selectedDateText);

DayBookDAO dayBookDAO = new DayBookDAO();
EmployeePaymentDAO employeePaymentDAO = new EmployeePaymentDAO();
VendorPaymentDAO vendorPaymentDAO = new VendorPaymentDAO();

List<DayBook> dayBookList = dayBookDAO.getAllDayBooks();
    List<EmployeePayment> employeePaymentList = employeePaymentDAO.getAllEmployeePayments();
        List<VendorPayment> vendorPaymentList = vendorPaymentDAO.getAllVendorPayments();

            double clientPayment = 0;
            double dayBookExpenses = 0;
            double employeePayment = 0;
            double vendorPayment = 0;

            int dayBookTransactionCount = 0;

            for (DayBook dayBook : dayBookList) {

            if (dayBook.getTransactionDate() != null
            && dayBook.getTransactionDate().equals(selectedDate)) {

            dayBookTransactionCount++;

            String transactionType = dayBook.getTransactionType();

            if (transactionType != null
            && "Income".equalsIgnoreCase(transactionType.trim())) {

            clientPayment += dayBook.getAmount();

            } else if (transactionType != null
            && "Expense".equalsIgnoreCase(transactionType.trim())) {

            dayBookExpenses += dayBook.getAmount();
            }
            }
            }

            for (EmployeePayment payment : employeePaymentList) {

            if (payment.getPaymentDate() != null
            && payment.getPaymentDate().equals(selectedDate)) {

            employeePayment += payment.getAmount();
            }
            }

            for (VendorPayment payment : vendorPaymentList) {

            if (payment.getPaymentDate() != null
            && payment.getPaymentDate().equals(selectedDate)) {

            vendorPayment += payment.getAmount();
            }
            }

            double totalExpenses = dayBookExpenses
            + employeePayment
            + vendorPayment;

            double income = clientPayment;

            double netBalance = income - totalExpenses;

            String displayDate =
            new SimpleDateFormat("dd MMMM yyyy").format(selectedDate);
            %>

            <%@ include file="../Common.jsp" %>

            <style>
                .daybook-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 22px;
                }

                .daybook-title h2 {
                    color: #24056f;
                    font-size: 25px;
                    font-weight: 600;
                    margin-bottom: 5px;
                }

                .daybook-title p {
                    color: #718096;
                    font-size: 13px;
                }

                .date-selector {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                }

                .date-selector form {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                }

                .date-input {
                    height: 38px;
                    border: 1px solid #dddddd;
                    border-radius: 7px;
                    padding: 0 10px;
                    font-size: 12px;
                    color: #555555;
                    background: #ffffff;
                    outline: none;
                }

                .date-input:focus {
                    border-color: #d62d70;
                }

                .view-date-btn {
                    height: 38px;
                    border: none;
                    border-radius: 7px;
                    background: #24056f;
                    color: #ffffff;
                    padding: 0 14px;
                    font-size: 11px;
                    cursor: pointer;
                }

                .view-date-btn:hover {
                    background: #3b1590;
                }

                .daybook-container {
                    background: #ffffff;
                    border-radius: 12px;
                    padding: 20px;
                    box-shadow: 0 2px 12px rgba(0,0,0,0.07);
                    border: 1px solid #eeeeee;
                }

                .summary-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 20px;
                }

                .summary-title {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                }

                .summary-icon {
                    width: 44px;
                    height: 44px;
                    border-radius: 9px;
                    background: #edf4ff;
                    color: #1261b5;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 21px;
                }

                .summary-title h3 {
                    color: #18365d;
                    font-size: 16px;
                    font-weight: 600;
                    margin-bottom: 4px;
                }

                .summary-title p {
                    color: #718096;
                    font-size: 11px;
                }

                .print-btn {
                    border: none;
                    background: #edf4ff;
                    color: #1261b5;
                    border-radius: 7px;
                    padding: 9px 14px;
                    font-size: 11px;
                    cursor: pointer;
                }

                .print-btn:hover {
                    background: #dceaff;
                }

                .summary-cards {
                    display: grid;
                    grid-template-columns: repeat(6, minmax(0, 1fr));
                    gap: 14px;
                }

                .summary-card {
                    min-height: 175px;
                    border-radius: 10px;
                    padding: 16px;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    border: 1px solid #eeeeee;
                }

                .summary-card.client {
                    background: #f0faf2;
                }

                .summary-card.employee {
                    background: #fff0f5;
                }

                .summary-card.vendor {
                    background: #f6f2ff;
                }

                .summary-card.expense {
                    background: #fff6e9;
                }

                .summary-card.income {
                    background: #eef6ff;
                }

                .summary-card.balance {
                    background: #173b70;
                    color: #ffffff;
                    border-color: #173b70;
                }

                .summary-card-top {
                    display: flex;
                    justify-content: center;
                }

                .summary-card-icon {
                    width: 52px;
                    height: 52px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 20px;
                }

                .client .summary-card-icon {
                    background: #65bd70;
                    color: #ffffff;
                }

                .employee .summary-card-icon {
                    background: #e54879;
                    color: #ffffff;
                }

                .vendor .summary-card-icon {
                    background: #7049c7;
                    color: #ffffff;
                }

                .expense .summary-card-icon {
                    background: #f39a24;
                    color: #ffffff;
                }

                .income .summary-card-icon {
                    background: #438ee5;
                    color: #ffffff;
                }

                .balance .summary-card-icon {
                    background: transparent;
                    color: #ffffff;
                    border: 1px solid #ffffff;
                }

                .summary-card-content {
                    text-align: center;
                }

                .summary-card-label {
                    font-size: 11px;
                    font-weight: 500;
                    margin-bottom: 8px;
                }

                .client .summary-card-label {
                    color: #287d38;
                }

                .employee .summary-card-label {
                    color: #d93668;
                }

                .vendor .summary-card-label {
                    color: #6742b7;
                }

                .expense .summary-card-label {
                    color: #dc8415;
                }

                .income .summary-card-label {
                    color: #286fba;
                }

                .balance .summary-card-label {
                    color: #ffffff;
                }

                .summary-card-amount {
                    font-size: 19px;
                    font-weight: 700;
                }

                .client .summary-card-amount {
                    color: #287d38;
                }

                .employee .summary-card-amount {
                    color: #d93668;
                }

                .vendor .summary-card-amount {
                    color: #6742b7;
                }

                .expense .summary-card-amount {
                    color: #dc8415;
                }

                .income .summary-card-amount {
                    color: #286fba;
                }

                .balance .summary-card-amount {
                    color: #ffffff;
                }

                .summary-card-footer {
                    border-top: 1px solid rgba(0,0,0,0.08);
                    padding-top: 10px;
                    text-align: center;
                    font-size: 10px;
                }

                .client .summary-card-footer {
                    color: #4b7651;
                }

                .employee .summary-card-footer {
                    color: #a64d69;
                }

                .vendor .summary-card-footer {
                    color: #75628f;
                }

                .expense .summary-card-footer {
                    color: #9b7040;
                }

                .income .summary-card-footer {
                    color: #55799d;
                }

                .balance .summary-card-footer {
                    color: #ffffff;
                    border-color: rgba(255,255,255,0.3);
                }

                .daybook-info {
                    margin-top: 18px;
                    background: #eef4ff;
                    border: 1px solid #dce7fa;
                    border-radius: 8px;
                    padding: 12px 15px;
                    display: flex;
                    align-items: center;
                    gap: 12px;
                }

                .daybook-info-icon {
                    color: #1261b5;
                    font-size: 18px;
                }

                .daybook-info-text {
                    color: #3f5067;
                    font-size: 11px;
                    line-height: 1.6;
                }

                @media (max-width: 1250px) {
                    .summary-cards {
                        grid-template-columns: repeat(3, minmax(0, 1fr));
                    }
                }

                @media (max-width: 800px) {
                    .daybook-header {
                        flex-direction: column;
                        align-items: flex-start;
                        gap: 15px;
                    }

                    .date-selector,
                    .date-selector form {
                        width: 100%;
                    }

                    .date-input {
                        flex: 1;
                    }

                    .summary-cards {
                        grid-template-columns: repeat(2, minmax(0, 1fr));
                    }
                }

                @media (max-width: 500px) {
                    .summary-cards {
                        grid-template-columns: 1fr;
                    }

                    .daybook-container {
                        padding: 12px;
                    }
                }

                @media print {
                    .date-selector,
                    .print-btn {
                        display: none;
                    }

                    .daybook-container {
                        box-shadow: none;
                        border: none;
                    }
                }
            </style>

            <div class="daybook-header">

                <div class="daybook-title">
                    <h2>Day Book</h2>
                </div>

                <div class="date-selector">

                    <form method="get" action="DayBook.jsp">

                        <i class="fa fa-calendar" style="color:#24056f;"></i>

                        <input type="date" name="selectedDate" class="date-input"
                               value="<%= selectedDateText %>" required>

                        <button type="submit" class="view-date-btn">
                            <i class="fa fa-search"></i>
                            &nbsp; View
                        </button>

                    </form>
                </div>
            </div>

            <div class="daybook-container">
                <div class="summary-header">
                    <div class="summary-title">

                        <div class="summary-icon">
                            <i class="fa fa-book"></i>
                        </div>

                        <div>
                            <h3>Day Book Summary</h3>

                            <p><%= displayDate %></p>
                        </div>

                    </div>

                    <button type="button" class="print-btn" onclick="window.print()">
                        <i class="fa fa-print"></i>
                        &nbsp; Print
                    </button>

                </div>

                <div class="summary-cards">
                    <div class="summary-card client">
                        <div class="summary-card-top">

                            <div class="summary-card-icon">
                                <i class="fa fa-user"></i>
                            </div>

                        </div>

                        <div class="summary-card-content">

                            <div class="summary-card-label">
                                Client Payment
                            </div>

                            <div class="summary-card-amount">
                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                <%= String.format("%.2f", clientPayment) %>
                            </div>

                        </div>

                        <div class="summary-card-footer">
                            <i class="fa fa-credit-card"></i>
                            &nbsp; Day Book Income
                        </div>

                    </div>

                    <div class="summary-card employee">
                        <div class="summary-card-top">

                            <div class="summary-card-icon">
                                <i class="fa fa-users"></i>
                            </div>

                        </div>

                        <div class="summary-card-content">

                            <div class="summary-card-label">
                                Employee Payment
                            </div>

                            <div class="summary-card-amount">
                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                <%= String.format("%.2f", employeePayment) %>
                            </div>

                        </div>

                        <div class="summary-card-footer">
                            <i class="fa fa-users"></i>
                            &nbsp; Employee Payments
                        </div>

                    </div>

                    <div class="summary-card vendor">
                        <div class="summary-card-top">

                            <div class="summary-card-icon">
                                <i class="fa fa-briefcase"></i>
                            </div>

                        </div>

                        <div class="summary-card-content">

                            <div class="summary-card-label">
                                Vendor Payment
                            </div>

                            <div class="summary-card-amount">
                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                <%= String.format("%.2f", vendorPayment) %>
                            </div>

                        </div>

                        <div class="summary-card-footer">
                            <i class="fa fa-truck"></i>
                            &nbsp; Vendor Payments
                        </div>

                    </div>

                    <div class="summary-card expense">
                        <div class="summary-card-top">

                            <div class="summary-card-icon">
                                <i class="fa fa-wallet"></i>
                            </div>

                        </div>

                        <div class="summary-card-content">

                            <div class="summary-card-label">
                                Expenses
                            </div>

                            <div class="summary-card-amount">
                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                <%= String.format("%.2f", totalExpenses) %>
                            </div>

                        </div>

                        <div class="summary-card-footer">
                            <i class="fa fa-arrow-down"></i>
                            &nbsp; Total Expenses
                        </div>

                    </div>

                    <div class="summary-card income">
                        <div class="summary-card-top">

                            <div class="summary-card-icon">
                                <i class="fa fa-line-chart"></i>
                            </div>

                        </div>

                        <div class="summary-card-content">

                            <div class="summary-card-label">
                                Income
                            </div>

                            <div class="summary-card-amount">
                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                <%= String.format("%.2f", income) %>
                            </div>

                        </div>

                        <div class="summary-card-footer">
                            <i class="fa fa-arrow-up"></i>
                            &nbsp; Total Income
                        </div>

                    </div>

                    <div class="summary-card balance">
                        <div class="summary-card-top">

                            <div class="summary-card-icon">
                                <i class="fa fa-balance-scale"></i>
                            </div>

                        </div>

                        <div class="summary-card-content">

                            <div class="summary-card-label">
                                Net Balance
                            </div>

                            <div class="summary-card-amount">
                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                <%= String.format("%.2f", netBalance) %>
                            </div>

                        </div>

                        <div class="summary-card-footer">
                            Income - Expenses
                        </div>

                    </div>

                </div>

            </div>

            <script>
                document.querySelector(".date-input").addEventListener("change", function() {
                    this.form.submit();
                });
            </script>

            </div>
            </div>
            </body>
            </html>