<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.skyline.model.FollowUp" %>
<%@ page import="com.skyline.dao.FollowUpDAO" %>

<%
if (!"Admin".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

String status = request.getParameter("status");
String followUpType = request.getParameter("followUpType");
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");
String search = request.getParameter("search");
String editId = request.getParameter("editId");

if (status == null) {
status = "All";
}

if (followUpType == null) {
followUpType = "All";
}

if (fromDate == null) {
fromDate = "";
}

if (toDate == null) {
toDate = "";
}

if (search == null) {
search = "";
}

FollowUp editFollowUp = null;

if (editId != null && !editId.isEmpty()) {

try {

FollowUpDAO editDao = new FollowUpDAO();

editFollowUp =
editDao.getFollowUpById(
Integer.parseInt(editId)
);

} catch (Exception e) {

e.printStackTrace();
}
}

if ("POST".equalsIgnoreCase(request.getMethod())) {

String action = request.getParameter("action");

if ("add".equals(action)
|| "update".equals(action)) {

try {

String enquiryId =
request.getParameter("enquiryId");

String customerName =
request.getParameter("customerName");

String mobileNo =
request.getParameter("mobileNo");

String followUpTypeValue =
request.getParameter("followUpType");

String followUpDate =
request.getParameter("followUpDate");

String statusValue =
request.getParameter("status");

String nextFollowUp =
request.getParameter("nextFollowUp");

FollowUp followUp =
new FollowUp();

if ("update".equals(action)) {

String id =
request.getParameter("id");

followUp.setId(
Integer.parseInt(id)
);
}

followUp.setEnquiryId(enquiryId);
followUp.setCustomerName(customerName);
followUp.setMobileNo(mobileNo);
followUp.setFollowUpType(followUpTypeValue);

followUp.setFollowUpDate(
java.sql.Date.valueOf(followUpDate)
);

followUp.setStatus(statusValue);

if (nextFollowUp != null
&& !nextFollowUp.isEmpty()) {

followUp.setNextFollowUp(
java.sql.Date.valueOf(nextFollowUp)
);

} else {

followUp.setNextFollowUp(null);
}

FollowUpDAO saveDao =
new FollowUpDAO();

boolean saved;

if ("update".equals(action)) {

saved =
saveDao.updateFollowUp(
followUp
);

} else {

saved =
saveDao.addFollowUp(
followUp
);
}

if (saved) {

response.sendRedirect("FollowUp.jsp");
return;

} else {

request.setAttribute(
"errorMessage",
"Unable to save follow up."
);
}

} catch (Exception e) {

e.printStackTrace();

request.setAttribute(
"errorMessage",
"Please enter valid follow up details."
);
}
}

if ("delete".equals(action)) {

String deleteId =
request.getParameter("deleteId");

if (deleteId != null
&& !deleteId.isEmpty()) {

try {

FollowUpDAO deleteDao =
new FollowUpDAO();

boolean deleted =
deleteDao.deleteFollowUp(
Integer.parseInt(deleteId)
);

if (deleted) {

response.sendRedirect("FollowUp.jsp");
return;

} else {

request.setAttribute(
"errorMessage",
"Unable to delete follow up."
);
}

} catch (Exception e) {

e.printStackTrace();

request.setAttribute(
"errorMessage",
"Unable to delete follow up."
);
}
}
}
}

FollowUpDAO dao =
new FollowUpDAO();

List<FollowUp> followUps;

    if (!search.trim().isEmpty()) {

    followUps =
    dao.searchFollowUps(
    search.trim()
    );

    } else {

    followUps =
    dao.getFollowUps(
    status,
    followUpType,
    fromDate,
    toDate
    );
    }

    String errorMessage =
    (String) request.getAttribute(
    "errorMessage"
    );
    %>

    <%@ include file="../Common.jsp" %>

    <style>

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

        .header-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-form {
            display: flex;
            align-items: center;
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
            color: #6337bd;
        }

        .add-btn {
            height: 34px;
            border: none;
            background: #14a085;
            color: white;
            padding: 0 15px;
            border-radius: 5px;
            font-size: 12px;
            cursor: pointer;
        }

        .add-btn:hover {
            background: #10866f;
        }

        .message {
            padding: 9px 12px;
            border-radius: 5px;
            font-size: 11px;
            margin-bottom: 15px;
            background: #fdeaea;
            color: #c82333;
        }

        .filter-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 18px;
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr) auto;
            gap: 18px;
            align-items: end;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
        }

        .filter-group label {
            font-size: 12px;
            color: #303044;
            margin-bottom: 7px;
        }

        .filter-group select,
        .filter-group input {
            height: 34px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 0 10px;
            font-size: 12px;
            color: #555;
            outline: none;
            background: #ffffff;
            box-sizing: border-box;
            width: 100%;
        }

        .filter-group select:focus,
        .filter-group input:focus {
            border-color: #6337bd;
        }

        .filter-btn {
            height: 34px;
            border: none;
            background: #6337bd;
            color: white;
            padding: 0 20px;
            border-radius: 5px;
            font-size: 12px;
            cursor: pointer;
        }

        .filter-btn:hover {
            background: #512aa5;
        }

        .add-followup-box {
            background: #ffffff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 18px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        }

        .add-followup-title {
            font-size: 18px;
            font-weight: 600;
            color: #24056f;
            margin-bottom: 18px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-size: 12px;
            color: #303044;
            margin-bottom: 7px;
        }

        .form-group input,
        .form-group select {
            height: 34px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 0 10px;
            font-size: 12px;
            color: #555;
            outline: none;
            background: #ffffff;
            box-sizing: border-box;
            width: 100%;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #6337bd;
        }

        .form-buttons {
            display: flex;
            gap: 8px;
            margin-top: 18px;
        }

        .cancel-btn {
            height: 34px;
            border: 1px solid #ddd;
            background: #ffffff;
            color: #555;
            padding: 0 15px;
            border-radius: 5px;
            font-size: 12px;
            cursor: pointer;
        }

        .cancel-btn:hover {
            background: #f5f5f5;
        }

        .list-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 18px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        }

        .list-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .list-title {
            color: #24056f;
            font-size: 22px;
            font-weight: 600;
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
        }

        .followup-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        .followup-table th {
            background: #f0ebff;
            color: #303044;
            font-size: 11px;
            font-weight: 600;
            padding: 12px 8px;
            text-align: left;
            white-space: nowrap;
        }

        .followup-table td {
            padding: 13px 8px;
            border-bottom: 1px solid #eeeeee;
            font-size: 11px;
            color: #303044;
            white-space: nowrap;
        }

        .followup-table tbody tr:hover {
            background: #faf8ff;
        }

        .status {
            display: inline-block;
            padding: 5px 9px;
            border-radius: 6px;
            font-size: 10px;
            font-weight: 500;
        }

        .status-pending {
            background: #fff3df;
            color: #d88900;
        }

        .status-completed {
            background: #e8f7ed;
            color: #218838;
        }

        .status-in-progress {
            background: #e8f2ff;
            color: #2878c8;
        }

        .status-default {
            background: #eeeeee;
            color: #555555;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .edit-btn,
        .delete-btn {
            width: 28px;
            height: 28px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .edit-btn {
            background: #f1ebff;
            color: #6337bd;
        }

        .delete-btn {
            background: #fff0f0;
            color: #e63946;
        }

        .edit-btn:hover {
            background: #e2d8ff;
        }

        .delete-btn:hover {
            background: #ffe0e0;
        }

        .table-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 12px;
            font-size: 11px;
            color: #777777;
        }

        .pagination {
            display: flex;
            gap: 5px;
        }

        .page-btn {
            width: 32px;
            height: 30px;
            border: 1px solid #dddddd;
            background: #ffffff;
            border-radius: 5px;
            cursor: pointer;
            color: #555555;
        }

        .page-btn.active {
            background: #6337bd;
            color: white;
            border-color: #6337bd;
        }

        @media (max-width: 1000px) {

            .filter-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 600px) {

            .filter-grid {
                grid-template-columns: 1fr;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .page-header {
                align-items: flex-start;
                flex-direction: column;
                gap: 10px;
            }

            .header-actions {
                width: 100%;
                flex-direction: column;
                align-items: stretch;
            }

            .search-form {
                width: 100%;
            }

            .search-box {
                width: 100%;
                box-sizing: border-box;
            }

        }

    </style>

    <div class="page-header">

        <h2>Follow Up</h2>

        <div class="header-actions">

            <form method="get"
                  action="FollowUp.jsp"
                  class="search-form">

                <div class="search-box">

                    <i class="fa fa-search"></i>

                    <input type="text"
                           name="search"
                           value="<%= search %>"
                           placeholder="Search enquiry...">

                    <button type="submit"
                            title="Search">
                    </button>

                </div>

            </form>

            <button type="button"
                    class="add-btn"
                    onclick="document.getElementById('addFollowUpBox').style.display='block';">

                <i class="fa fa-plus"></i>
                &nbsp; Add Follow Up

            </button>

        </div>

    </div>

    <% if (errorMessage != null && !errorMessage.isEmpty()) { %>

    <div class="message">
        <%= errorMessage %>
    </div>

    <% } %>

    <div id="addFollowUpBox"
         class="add-followup-box"
         style="<%= editFollowUp != null ? "display:block;" : "display:none;" %>">

    <div class="add-followup-title">

        <%= editFollowUp != null
        ? "Edit Follow Up"
        : "Add Follow Up" %>

    </div>

    <form method="post"
          action="FollowUp.jsp">

        <input type="hidden"
               name="action"
               value="<%= editFollowUp != null
                       ? "update"
        : "add" %>">

        <% if (editFollowUp != null) { %>

        <input type="hidden"
               name="id"
               value="<%= editFollowUp.getId() %>">

        <% } %>

        <div class="form-grid">

            <div class="form-group">

                <label>Enquiry ID</label>

                <input type="text"
                       name="enquiryId"
                       value="<%= editFollowUp != null
                               ? editFollowUp.getEnquiryId()
                               : "" %>"
                placeholder="Enter enquiry ID"
                required>

            </div>

            <div class="form-group">

                <label>Customer Name</label>

                <input type="text"
                       name="customerName"
                       value="<%= editFollowUp != null
                               ? editFollowUp.getCustomerName()
                               : "" %>"
                placeholder="Enter customer name"
                required>

            </div>

            <div class="form-group">

                <label>Mobile No.</label>

                <input type="text"
                       name="mobileNo"
                       value="<%= editFollowUp != null
                               ? editFollowUp.getMobileNo()
                               : "" %>"
                placeholder="Enter mobile number"
                required>

            </div>

            <div class="form-group">

                <label>Follow Up Type</label>

                <select name="followUpType"
                        required>

                    <option value="">
                        Select Type
                    </option>

                    <option value="Call"
                    <%= editFollowUp != null
                    && "Call".equals(
                    editFollowUp.getFollowUpType())
                    ? "selected"
                    : "" %>>
                    Call
                    </option>

                    <option value="Visit"
                    <%= editFollowUp != null
                    && "Visit".equals(
                    editFollowUp.getFollowUpType())
                    ? "selected"
                    : "" %>>
                    Visit
                    </option>

                    <option value="Email"
                    <%= editFollowUp != null
                    && "Email".equals(
                    editFollowUp.getFollowUpType())
                    ? "selected"
                    : "" %>>
                    Email
                    </option>

                </select>

            </div>

            <div class="form-group">

                <label>Follow Up Date</label>

                <input type="date"
                       name="followUpDate"
                       value="<%= editFollowUp != null
                               && editFollowUp.getFollowUpDate() != null
                               ? editFollowUp.getFollowUpDate()
                               : "" %>"
                required>

            </div>

            <div class="form-group">

                <label>Status</label>

                <select name="status"
                        required>

                    <option value="">
                        Select Status
                    </option>

                    <option value="pending"
                    <%= editFollowUp != null
                    && "pending".equalsIgnoreCase(
                    editFollowUp.getStatus())
                    ? "selected"
                    : "" %>>
                    Pending
                    </option>

                    <option value="completed"
                    <%= editFollowUp != null
                    && "completed".equalsIgnoreCase(
                    editFollowUp.getStatus())
                    ? "selected"
                    : "" %>>
                    Completed
                    </option>

                    <option value="in progress"
                    <%= editFollowUp != null
                    && "in progress".equalsIgnoreCase(
                    editFollowUp.getStatus())
                    ? "selected"
                    : "" %>>
                    In Progress
                    </option>

                </select>

            </div>

            <div class="form-group">

                <label>Next Follow Up</label>

                <input type="date"
                       name="nextFollowUp"
                       value="<%= editFollowUp != null
                               && editFollowUp.getNextFollowUp() != null
                               ? editFollowUp.getNextFollowUp()
                               : "" %>">

            </div>

        </div>

        <div class="form-buttons">

            <button type="submit"
                    class="add-btn">

                <i class="fa fa-save"></i>

                &nbsp;

                <%= editFollowUp != null
                ? "Update Follow Up"
                : "Save Follow Up" %>

            </button>

            <button type="button"
                    class="cancel-btn"
                    onclick="window.location.href='FollowUp.jsp';">

                Cancel

            </button>

        </div>

    </form>

    </div>

    <div class="filter-card">

        <form method="get"
              action="FollowUp.jsp">

            <div class="filter-grid">

                <div class="filter-group">

                    <label>Status</label>

                    <select name="status">

                        <option value="All"
                        <%= "All".equals(status)
                        ? "selected"
                        : "" %>>
                        All
                        </option>

                        <option value="pending"
                        <%= "pending".equals(status)
                        ? "selected"
                        : "" %>>
                        Pending
                        </option>

                        <option value="completed"
                        <%= "completed".equals(status)
                        ? "selected"
                        : "" %>>
                        Completed
                        </option>

                        <option value="in progress"
                        <%= "in progress".equals(status)
                        ? "selected"
                        : "" %>>
                        In Progress
                        </option>

                    </select>

                </div>

                <div class="filter-group">

                    <label>Follow Up Type</label>

                    <select name="followUpType">

                        <option value="All"
                        <%= "All".equals(followUpType)
                        ? "selected"
                        : "" %>>
                        All
                        </option>

                        <option value="Call"
                        <%= "Call".equals(followUpType)
                        ? "selected"
                        : "" %>>
                        Call
                        </option>

                        <option value="Visit"
                        <%= "Visit".equals(followUpType)
                        ? "selected"
                        : "" %>>
                        Visit
                        </option>

                        <option value="Email"
                        <%= "Email".equals(followUpType)
                        ? "selected"
                        : "" %>>
                        Email
                        </option>

                    </select>

                </div>

                <div class="filter-group">

                    <label>From Date</label>

                    <input type="date"
                           name="fromDate"
                           value="<%= fromDate %>">

                </div>

                <div class="filter-group">

                    <label>To Date</label>

                    <input type="date"
                           name="toDate"
                           value="<%= toDate %>">

                </div>

                <div class="filter-group">

                    <button type="submit"
                            class="filter-btn">

                        <i class="fa fa-filter"></i>
                        &nbsp; Filter

                    </button>

                </div>

            </div>

        </form>

    </div>

    <div class="list-card">

        <div class="list-header">

            <div class="list-title">
                Follow Up List
            </div>

        </div>

        <div class="table-container">

            <table class="followup-table">

                <thead>

                <tr>

                    <th>#</th>
                    <th>Enquiry ID</th>
                    <th>Customer Name</th>
                    <th>Mobile No.</th>
                    <th>Follow Up Type</th>
                    <th>Follow Up Date</th>
                    <th>Status</th>
                    <th>Next Follow Up</th>
                    <th>Action</th>

                </tr>

                </thead>

                <tbody>

                <%
                int count = 1;

                if (followUps != null
                && !followUps.isEmpty()) {

                for (int i = 0;
                i < followUps.size();
                i++) {

                FollowUp followUp =
                followUps.get(i);

                String statusClass =
                "status-default";

                if ("pending".equalsIgnoreCase(
                followUp.getStatus())) {

                statusClass =
                "status-pending";

                } else if ("completed".equalsIgnoreCase(
                followUp.getStatus())) {

                statusClass =
                "status-completed";

                } else if ("in progress".equalsIgnoreCase(
                followUp.getStatus())) {

                statusClass =
                "status-in-progress";
                }
                %>

                <tr>

                    <td>
                        <%= count %>
                    </td>

                    <td>
                        <%= followUp.getEnquiryId() %>
                    </td>

                    <td>
                        <%= followUp.getCustomerName() %>
                    </td>

                    <td>
                        <%= followUp.getMobileNo() %>
                    </td>

                    <td>
                        <%= followUp.getFollowUpType() %>
                    </td>

                    <td>
                        <%= followUp.getFollowUpDate() %>
                    </td>

                    <td>

                    <span class="status <%= statusClass %>">

                        <%= followUp.getStatus() %>

                    </span>

                    </td>

                    <td>

                        <% if (followUp.getNextFollowUp() != null) { %>

                        <%= followUp.getNextFollowUp() %>

                        <% } else { %>

                        -

                        <% } %>

                    </td>

                    <td>

                        <div class="action-buttons">

                            <a href="FollowUp.jsp?editId=<%= followUp.getId() %>"
                               class="edit-btn"
                               title="Edit">

                                <i class="fa fa-pen"></i>

                            </a>

                            <form method="post"
                                  action="FollowUp.jsp"
                                  style="display:inline;"
                                  onsubmit="return confirm('Are you sure you want to delete this follow up?');">

                                <input type="hidden"
                                       name="action"
                                       value="delete">

                                <input type="hidden"
                                       name="deleteId"
                                       value="<%= followUp.getId() %>">

                                <button type="submit"
                                        class="delete-btn"
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
                        style="text-align:center;
                           padding:25px;
                           color:#777;">

                        No follow up records found.

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

                Showing 1 to <%= followUps.size() %> of
                <%= followUps.size() %> entries

            </div>

            <div class="pagination">

                <button type="button"
                        class="page-btn">

                    <i class="fa fa-chevron-left"></i>

                </button>

                <button type="button"
                        class="page-btn active">

                    1

                </button>

                <button type="button"
                        class="page-btn">

                    <i class="fa fa-chevron-right"></i>

                </button>

            </div>

        </div>

    </div>

    </div>
    </div>
    </body>
    </html>