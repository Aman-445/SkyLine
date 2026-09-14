<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.skyline.model.Lead" %>
<%@ page import="com.skyline.dao.LeadDAO" %>
<%@ page import="com.skyline.model.User" %>
<%@ page import="com.skyline.dao.UserDAO" %>

<%
String source = request.getParameter("source");
String leadStatus = request.getParameter("leadStatus");
String assignTo = request.getParameter("assignTo");
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");
String search = request.getParameter("search");

if (source == null) {
source = "All";
}

if (leadStatus == null) {
leadStatus = "All";
}

if (assignTo == null) {
assignTo = "All";
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

UserDAO userDAO = new UserDAO();
List<User> employees = userDAO.getActiveEmployees();

    Lead editLead = null;

    String editId = request.getParameter("editId");

    if (editId != null && !editId.isEmpty()) {
    try {
    LeadDAO editDao = new LeadDAO();
    editLead = editDao.getLeadById(editId);
    } catch (Exception e) {
    e.printStackTrace();
    }
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {

    String action = request.getParameter("action");

    if ("add".equals(action)) {

    try {

    String leadId = request.getParameter("leadId");
    String customerName = request.getParameter("customerName");
    String mobileNo = request.getParameter("mobileNo");
    String leadSource = request.getParameter("leadSource");
    String leadStatusValue = request.getParameter("leadStatus");
    String assignToValue = request.getParameter("assignTo");
    String createdDate = request.getParameter("createdDate");

    Lead lead = new Lead();

    lead.setLeadId(leadId);
    lead.setCustomerName(customerName);
    lead.setMobileNo(mobileNo);
    lead.setSource(leadSource);
    lead.setLeadStatus(leadStatusValue);
    lead.setAssignTo(assignToValue);
    lead.setCreatedDate(java.sql.Date.valueOf(createdDate));

    LeadDAO addDao = new LeadDAO();

    if (addDao.addLead(lead)) {

    response.sendRedirect("Lead.jsp");
    return;

    } else {

    request.setAttribute("errorMessage",
    "Unable to add lead.");
    }

    } catch (Exception e) {

    e.printStackTrace();

    request.setAttribute("errorMessage",
    "Please enter valid lead details.");
    }
    }

    if ("update".equals(action)) {

    try {

    String leadId = request.getParameter("leadId");
    String customerName = request.getParameter("customerName");
    String mobileNo = request.getParameter("mobileNo");
    String leadSource = request.getParameter("leadSource");
    String leadStatusValue = request.getParameter("leadStatus");
    String assignToValue = request.getParameter("assignTo");
    String createdDate = request.getParameter("createdDate");

    Lead lead = new Lead();

    lead.setLeadId(leadId);
    lead.setCustomerName(customerName);
    lead.setMobileNo(mobileNo);
    lead.setSource(leadSource);
    lead.setLeadStatus(leadStatusValue);
    lead.setAssignTo(assignToValue);
    lead.setCreatedDate(java.sql.Date.valueOf(createdDate));

    LeadDAO updateDao = new LeadDAO();

    if (updateDao.updateLead(lead)) {

    response.sendRedirect("Lead.jsp");
    return;

    } else {

    request.setAttribute("errorMessage",
    "Unable to update lead.");
    }

    } catch (Exception e) {

    e.printStackTrace();

    request.setAttribute("errorMessage",
    "Please enter valid lead details.");
    }
    }

    if ("delete".equals(action)) {

    String deleteId = request.getParameter("deleteId");

    if (deleteId != null && !deleteId.isEmpty()) {

    LeadDAO deleteDao = new LeadDAO();

    if (deleteDao.deleteLead(deleteId)) {

    response.sendRedirect("Lead.jsp");
    return;

    } else {

    request.setAttribute("errorMessage",
    "Unable to delete lead.");
    }
    }
    }
    }

    LeadDAO dao = new LeadDAO();

    List<Lead> leads;

        if (!search.trim().isEmpty()) {

        leads = dao.searchLeads(search.trim());

        } else {

        leads = dao.getLeads(
        source,
        leadStatus,
        assignTo,
        fromDate,
        toDate
        );
        }

        String errorMessage =
        (String) request.getAttribute("errorMessage");
        %>

        <%@ include file="../Common.jsp" %>

        <style>

            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 18px;
            }

            .page-header h2 {
                font-size: 24px;
                font-weight: 600;
                color: #24056f;
            }

            .filter-card {
                background: #ffffff;
                border-radius: 8px;
                padding: 18px;
                box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
                margin-bottom: 18px;
            }

            .filter-grid {
                display: grid;
                grid-template-columns: repeat(5, 1fr) auto;
                gap: 14px;
                align-items: end;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
            }

            .filter-group label {
                font-size: 11px;
                color: #303044;
                margin-bottom: 6px;
            }

            .filter-group select,
            .filter-group input {
                height: 34px;
                border: 1px solid #dddddd;
                border-radius: 5px;
                padding: 0 9px;
                font-size: 11px;
                color: #555555;
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
                background: #14a085;
                color: white;
                padding: 0 18px;
                border-radius: 5px;
                font-size: 11px;
                cursor: pointer;
            }

            .filter-btn:hover {
                background: #10866f;
            }

            .list-card {
                background: #ffffff;
                border-radius: 8px;
                padding: 16px;
                box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            }

            .list-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 14px;
            }

            .list-title {
                color: #24056f;
                font-size: 22px;
                font-weight: 600;
            }

            .add-btn {
                border: none;
                background: #14a085;
                color: white;
                padding: 8px 14px;
                border-radius: 5px;
                font-size: 11px;
                cursor: pointer;
            }

            .add-btn:hover {
                background: #10866f;
            }

            .add-lead-box {
                display: none;
                background: #ffffff;
                border-radius: 8px;
                padding: 16px;
                margin-bottom: 15px;
                border: 1px solid #eeeeee;
            }

            .add-lead-title {
                font-size: 16px;
                font-weight: 600;
                color: #24056f;
                margin-bottom: 15px;
            }

            .add-lead-buttons {
                margin-top: 15px;
                display: flex;
                gap: 8px;
            }

            .cancel-btn {
                border: 1px solid #dddddd;
                background: #ffffff;
                color: #555555;
                padding: 8px 14px;
                border-radius: 5px;
                font-size: 11px;
                cursor: pointer;
            }

            .cancel-btn:hover {
                background: #f5f5f5;
            }

            .message {
                padding: 9px 12px;
                border-radius: 5px;
                font-size: 11px;
                margin-bottom: 15px;
                background: #fdeaea;
                color: #c82333;
            }

            .table-container {
                width: 100%;
                overflow-x: auto;
            }

            .lead-table {
                width: 100%;
                border-collapse: collapse;
                min-width: 950px;
            }

            .lead-table th {
                background: #e5f5f3;
                color: #303044;
                font-size: 10px;
                font-weight: 600;
                padding: 11px 8px;
                text-align: left;
                white-space: nowrap;
            }

            .lead-table td {
                padding: 12px 8px;
                border-bottom: 1px solid #eeeeee;
                font-size: 10px;
                color: #303044;
                white-space: nowrap;
            }

            .lead-table tbody tr:hover {
                background: #fafafa;
            }

            .lead-status {
                display: inline-block;
                padding: 5px 9px;
                border-radius: 5px;
                font-size: 9px;
                font-weight: 500;
            }

            .status-new {
                background: #e5f3ff;
                color: #2878c8;
            }

            .status-contacted {
                background: #fff3d9;
                color: #c68a00;
            }

            .status-in-progress {
                background: #eee7ff;
                color: #6337bd;
            }

            .status-follow-up {
                background: #fff0df;
                color: #d47a00;
            }

            .status-converted {
                background: #e5f7eb;
                color: #218838;
            }

            .status-default {
                background: #eeeeee;
                color: #555555;
            }

            .action-buttons {
                display: flex;
                gap: 6px;
            }

            .view-btn,
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
                text-decoration: none;
            }

            .view-btn {
                background: #e8f4ff;
                color: #2878c8;
            }

            .edit-btn {
                background: #e8f7ed;
                color: #218838;
            }

            .delete-btn {
                background: #ffb5b0;
                color: #e63946;
            }

            .view-btn:hover {
                background: #d8edff;
            }

            .edit-btn:hover {
                background: #d9f0df;
            }

            .delete-btn:hover {
                background: #ffe0e0;
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
                color: #555555;
            }

            .page-btn.active {
                background: #14a085;
                color: white;
                border-color: #14a085;
            }

            .search-box {
                display: flex;
                align-items: center;
                gap: 8px;
                background: white;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 5px 8px 5px 12px;
                width: 320px;
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

            .search-btn {
                border: none;
                background: #14a085;
                color: white;
                padding: 7px 12px;
                border-radius: 5px;
                font-size: 11px;
                cursor: pointer;
                white-space: nowrap;
            }

            .search-btn:hover {
                background: #10866f;
            }

            @media (max-width: 1000px) {

                .filter-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 600px) {

                .filter-grid {
                    grid-template-columns: 1fr;
                }

                .list-header {
                    align-items: flex-start;
                }

                .page-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .search-box {
                    width: 100%;
                }
            }

        </style>

        <div class="page-header">

            <h2>Lead</h2>

            <form method="get"
                  action="Lead.jsp"
                  class="search-box">

                <i class="fa fa-search"></i>

                <input type="text"
                       name="search"
                       value="<%= search %>"
                       placeholder="Search lead...">

            </form>

        </div>

        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>

        <div class="message">
            <%= errorMessage %>
        </div>

        <% } %>

        <div class="filter-card">

            <form method="get"
                  action="Lead.jsp">

                <div class="filter-grid">

                    <div class="filter-group">

                        <label>Lead Source</label>

                        <select name="source">

                            <option value="All"
                            <%= "All".equals(source) ? "selected" : "" %>>
                            All
                            </option>

                            <option value="Website"
                            <%= "Website".equals(source) ? "selected" : "" %>>
                            Website
                            </option>

                            <option value="Walk In"
                            <%= "Walk In".equals(source) ? "selected" : "" %>>
                            Walk In
                            </option>

                            <option value="Referral"
                            <%= "Referral".equals(source) ? "selected" : "" %>>
                            Referral
                            </option>

                            <option value="Just Dial"
                            <%= "Just Dial".equals(source) ? "selected" : "" %>>
                            Just Dial
                            </option>

                            <option value="Facebook"
                            <%= "Facebook".equals(source) ? "selected" : "" %>>
                            Facebook
                            </option>

                        </select>

                    </div>

                    <div class="filter-group">

                        <label>Lead Status</label>

                        <select name="leadStatus">

                            <option value="All"
                            <%= "All".equals(leadStatus) ? "selected" : "" %>>
                            All
                            </option>

                            <option value="new"
                            <%= "new".equals(leadStatus) ? "selected" : "" %>>
                            New
                            </option>

                            <option value="contacted"
                            <%= "contacted".equals(leadStatus) ? "selected" : "" %>>
                            Contacted
                            </option>

                            <option value="in progress"
                            <%= "in progress".equals(leadStatus) ? "selected" : "" %>>
                            In Progress
                            </option>

                            <option value="follow up"
                            <%= "follow up".equals(leadStatus) ? "selected" : "" %>>
                            Follow Up
                            </option>

                            <option value="converted"
                            <%= "converted".equals(leadStatus) ? "selected" : "" %>>
                            Converted
                            </option>

                        </select>

                    </div>

                    <div class="filter-group">

                        <label>Assign To</label>

                        <select name="assignTo">

                            <option value="All"
                            <%= "All".equals(assignTo) ? "selected" : "" %>>
                            All Employees
                            </option>

                            <% for (User employee : employees) { %>

                            <option value="<%= employee.getFullName() %>"
                            <%= employee.getFullName().equals(assignTo) ? "selected" : "" %>>
                            <%= employee.getFullName() %>
                            </option>

                            <% } %>

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
                    Lead List
                </div>

                <button type="button"
                        class="add-btn"
                        onclick="document.getElementById('addLeadBox').style.display='block';">

                    <i class="fa fa-plus"></i>
                    &nbsp; Add Lead

                </button>

            </div>

            <div id="addLeadBox"
                 class="add-lead-box"
                 style="<%= editLead != null ? "display:block;" : "display:none;" %>">

            <div class="add-lead-title">

                <%= editLead == null ? "Add Lead" : "Edit Lead" %>

            </div>

            <form method="post"
                  action="Lead.jsp">

                <input type="hidden"
                       name="action"
                       value="<%= editLead == null ? "add" : "update" %>">

                <div class="filter-grid">

                    <div class="filter-group">

                        <label>Lead ID</label>

                        <input type="text"
                               name="leadId"
                               placeholder="Enter lead ID"
                               value="<%= editLead == null ? "" : editLead.getLeadId() %>"
                        <%= editLead != null ? "readonly" : "" %>
                        required>

                    </div>

                    <div class="filter-group">

                        <label>Customer Name</label>

                        <input type="text"
                               name="customerName"
                               placeholder="Enter customer name"
                               value="<%= editLead == null ? "" : editLead.getCustomerName() %>"
                        required>

                    </div>

                    <div class="filter-group">

                        <label>Mobile No.</label>

                        <input type="text"
                               name="mobileNo"
                               placeholder="Enter mobile number"
                               value="<%= editLead == null ? "" : editLead.getMobileNo() %>"
                        required>

                    </div>

                    <div class="filter-group">

                        <label>Lead Source</label>

                        <select name="leadSource"
                                required>

                            <option value="">
                                Select Source
                            </option>

                            <option value="Website"
                            <%= editLead != null && "Website".equals(editLead.getSource()) ? "selected" : "" %>>
                            Website
                            </option>

                            <option value="Walk In"
                            <%= editLead != null && "Walk In".equals(editLead.getSource()) ? "selected" : "" %>>
                            Walk In
                            </option>

                            <option value="Referral"
                            <%= editLead != null && "Referral".equals(editLead.getSource()) ? "selected" : "" %>>
                            Referral
                            </option>

                            <option value="Just Dial"
                            <%= editLead != null && "Just Dial".equals(editLead.getSource()) ? "selected" : "" %>>
                            Just Dial
                            </option>

                            <option value="Facebook"
                            <%= editLead != null && "Facebook".equals(editLead.getSource()) ? "selected" : "" %>>
                            Facebook
                            </option>

                        </select>

                    </div>

                    <div class="filter-group">

                        <label>Lead Status</label>

                        <select name="leadStatus"
                                required>

                            <option value="">
                                Select Status
                            </option>

                            <option value="new"
                            <%= editLead != null && "new".equals(editLead.getLeadStatus()) ? "selected" : "" %>>
                            New
                            </option>

                            <option value="contacted"
                            <%= editLead != null && "contacted".equals(editLead.getLeadStatus()) ? "selected" : "" %>>
                            Contacted
                            </option>

                            <option value="in progress"
                            <%= editLead != null && "in progress".equals(editLead.getLeadStatus()) ? "selected" : "" %>>
                            In Progress
                            </option>

                            <option value="follow up"
                            <%= editLead != null && "follow up".equals(editLead.getLeadStatus()) ? "selected" : "" %>>
                            Follow Up
                            </option>

                            <option value="converted"
                            <%= editLead != null && "converted".equals(editLead.getLeadStatus()) ? "selected" : "" %>>
                            Converted
                            </option>

                        </select>

                    </div>

                    <div class="filter-group">

                        <label>Assign To</label>

                        <select name="assignTo"
                                required>

                            <option value="">
                                Select Employee
                            </option>

                            <% for (User employee : employees) { %>

                            <option value="<%= employee.getFullName() %>"
                            <%= editLead != null
                            && employee.getFullName().equals(editLead.getAssignTo())
                            ? "selected"
                            : "" %>>
                            <%= employee.getFullName() %>
                            </option>

                            <% } %>

                        </select>

                    </div>

                    <div class="filter-group">

                        <label>Created Date</label>

                        <input type="date"
                               name="createdDate"
                               value="<%= editLead == null ? "" : editLead.getCreatedDate() %>"
                        required>

                    </div>

                </div>

                <div class="add-lead-buttons">

                    <button type="submit"
                            class="add-btn">

                        <i class="fa fa-save"></i>
                        &nbsp;

                        <%= editLead == null ? "Save Lead" : "Update Lead" %>

                    </button>

                    <button type="button"
                            class="cancel-btn"
                            onclick="window.location.href='Lead.jsp';">

                        Cancel

                    </button>

                </div>

            </form>

        </div>

        <div class="table-container">

            <table class="lead-table">

                <thead>

                <tr>

                    <th>#</th>
                    <th>Lead ID</th>
                    <th>Customer Name</th>
                    <th>Mobile No.</th>
                    <th>Source</th>
                    <th>Lead Status</th>
                    <th>Assign To</th>
                    <th>Created Date</th>
                    <th>Action</th>

                </tr>

                </thead>

                <tbody>

                <%
                int count = 1;

                if (leads != null && !leads.isEmpty()) {

                for (int i = 0; i < leads.size(); i++) {

                Lead lead = leads.get(i);

                String statusClass = "status-default";

                if ("new".equalsIgnoreCase(lead.getLeadStatus())) {
                statusClass = "status-new";
                }

                if ("contacted".equalsIgnoreCase(lead.getLeadStatus())) {
                statusClass = "status-contacted";
                }

                if ("in progress".equalsIgnoreCase(lead.getLeadStatus())) {
                statusClass = "status-in-progress";
                }

                if ("follow up".equalsIgnoreCase(lead.getLeadStatus())) {
                statusClass = "status-follow-up";
                }

                if ("converted".equalsIgnoreCase(lead.getLeadStatus())) {
                statusClass = "status-converted";
                }
                %>

                <tr>

                    <td>
                        <%= count %>
                    </td>

                    <td>
                        <%= lead.getLeadId() %>
                    </td>

                    <td>
                        <%= lead.getCustomerName() %>
                    </td>

                    <td>
                        <%= lead.getMobileNo() %>
                    </td>

                    <td>
                        <%= lead.getSource() %>
                    </td>

                    <td>

                    <span class="lead-status <%= statusClass %>">
                        <%= lead.getLeadStatus() %>
                    </span>

                    </td>

                    <td>
                        <%= lead.getAssignTo() %>
                    </td>

                    <td>
                        <%= lead.getCreatedDate() %>
                    </td>

                    <td>

                        <div class="action-buttons">

                            <a href="Lead.jsp?editId=<%= lead.getLeadId() %>"
                               class="edit-btn"
                               title="Edit">

                                <i class="fa fa-pen"></i>

                            </a>

                            <form method="post"
                                  action="Lead.jsp"
                                  style="display:inline;"
                                  onsubmit="return confirm('Are you sure you want to delete this lead?');">

                                <input type="hidden"
                                       name="action"
                                       value="delete">

                                <input type="hidden"
                                       name="deleteId"
                                       value="<%= lead.getLeadId() %>">

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
                        style="text-align:center;padding:25px;color:#777777;">

                        No lead records found.

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

                Showing 1 to <%= leads.size() %> of
                <%= leads.size() %> entries

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