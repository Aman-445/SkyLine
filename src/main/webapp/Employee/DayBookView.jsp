<%@ page pageEncoding="UTF-8" %>
<%@ page import="com.skyline.model.DayBook" %>
<%@ page import="com.skyline.dao.DayBookDAO" %>

<%
if (!"Employee".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

DayBook dayBook = null;

try {
int id = Integer.parseInt(request.getParameter("id"));

DayBookDAO dao = new DayBookDAO();
dayBook = dao.getDayBookById(id);

} catch (Exception e) {
e.printStackTrace();
}
%>

<%@ include file="../Common.jsp" %>

<style>
    .daybook-view-card {
        background: #ffffff;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        max-width: 700px;
    }
    .daybook-view-title {
        color: #164b8a;
        font-size: 16px;
        font-weight: 600;
        padding-bottom: 10px;
        border-bottom: 1px solid #d5e5f5;
        margin-bottom: 20px;
    }
    .daybook-detail-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 18px;
    }
    .daybook-detail {
        display: flex;
        flex-direction: column;
    }
    .daybook-detail label {
        font-size: 10px;
        color: #777777;
        margin-bottom: 5px;
    }
    .daybook-detail span {
        font-size: 12px;
        color: #303044;
        font-weight: 500;
    }
    .daybook-back-btn {
        display: inline-block;
        margin-top: 20px;
        background: #1769e0;
        color: #ffffff;
        text-decoration: none;
        padding: 8px 15px;
        border-radius: 5px;
        font-size: 11px;
    }
    .daybook-back-btn:hover {
        color: #ffffff;
        background: #0d5bc4;
    }
    .income-detail {
        color: #218838 !important;
    }
    .expense-detail {
        color: #e63946 !important;
    }
    @media (max-width: 600px) {
        .daybook-detail-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="page-header">
    <h2>Day Book Details</h2>
</div>

<div class="daybook-view-card">

    <%
    if (dayBook != null) {
    %>

    <div class="daybook-view-title">
        Day Book Entry Details
    </div>

    <div class="daybook-detail-grid">

        <div class="daybook-detail">
            <label>Date</label>
            <span>
                <%= dayBook.getTransactionDate() %>
            </span>
        </div>

        <div class="daybook-detail">
            <label>Particulars</label>
            <span>
                <%= dayBook.getParticulars() %>
            </span>
        </div>

        <div class="daybook-detail">
            <label>Transaction Type</label>
            <span>
                <%= dayBook.getTransactionType() %>
            </span>
        </div>

        <div class="daybook-detail">
            <label>Payment Mode</label>
            <span>
                <%= dayBook.getPaymentMode() %>
            </span>
        </div>

        <div class="daybook-detail">
            <label>Amount</label>

            <%
            if ("Income".equalsIgnoreCase(dayBook.getTransactionType())) {
            %>

            <span class="income-detail">
                ₹<%= String.format("%.2f", dayBook.getAmount()) %>
            </span>

            <%
            } else {
            %>

            <span class="expense-detail">
                ₹<%= String.format("%.2f", dayBook.getAmount()) %>
            </span>

            <%
            }
            %>

        </div>

        <div class="daybook-detail">
            <label>Entry ID</label>
            <span>
                <%= dayBook.getId() %>
            </span>
        </div>

    </div>

    <a href="DayBook.jsp"
       class="daybook-back-btn">
        <i class="fa fa-arrow-left"></i>
        &nbsp; Back to Day Book
    </a>

    <%
    } else {
    %>

    <div style="text-align:center;color:#777777;font-size:12px;padding:25px;">
        Day book entry not found.
    </div>

    <a href="DayBook.jsp"
       class="daybook-back-btn">
        <i class="fa fa-arrow-left"></i>
        &nbsp; Back to Day Book
    </a>

    <%
    }
    %>

</div>

</div>
</div>
</body>
</html>