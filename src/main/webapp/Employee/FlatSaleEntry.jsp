<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="com.skyline.model.FlatSale" %>
<%@ page import="com.skyline.dao.FlatSaleDAO" %>

<%
if (!"Employee".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

String message = "";
String messageType = "";

String search = request.getParameter("search");
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");
String filterBuilding = request.getParameter("filterBuilding");
String filterPaymentMode = request.getParameter("filterPaymentMode");

if (search == null) {
search = "";
}

if (fromDate == null) {
fromDate = "";
}

if (toDate == null) {
toDate = "";
}

if (filterBuilding == null) {
filterBuilding = "";
}

if (filterPaymentMode == null) {
filterPaymentMode = "";
}

FlatSale editSale = null;

String editId = request.getParameter("editId");

FlatSaleDAO dao = new FlatSaleDAO();

if (editId != null && !editId.isEmpty()) {

try {
editSale = dao.getFlatSaleById(Integer.parseInt(editId));
} catch (Exception e) {
e.printStackTrace();
}
}

if ("POST".equalsIgnoreCase(request.getMethod())) {

String action = request.getParameter("action");

if ("delete".equals(action)) {

try {

int id = Integer.parseInt(request.getParameter("id"));

if (dao.deleteFlatSale(id)) {
response.sendRedirect("FlatSaleEntry.jsp");
return;
} else {
message = "Unable to delete flat sale.";
messageType = "error";
}

} catch (Exception e) {
e.printStackTrace();
message = "Unable to delete flat sale.";
messageType = "error";
}
}

if ("save".equals(action) || "update".equals(action)) {

String saleDate = request.getParameter("saleDate");
String customerName = request.getParameter("customerName");
String mobileNo = request.getParameter("mobileNo");
String buildingName = request.getParameter("buildingName");
String faltNo = request.getParameter("faltNo");
String saleAmountText = request.getParameter("saleAmount");
String bookingAmountText = request.getParameter("bookingAmount");
String paymentMode = request.getParameter("paymentMode");
String remarka = request.getParameter("remarka");

try {

double saleAmount = Double.parseDouble(saleAmountText);

double bookingAmount = 0;

if (bookingAmountText != null && !bookingAmountText.trim().isEmpty()) {
bookingAmount = Double.parseDouble(bookingAmountText);
}

FlatSale sale = new FlatSale();

if ("update".equals(action)) {
sale.setId(Integer.parseInt(request.getParameter("id")));
}

sale.setSaleDate(Date.valueOf(saleDate));
sale.setCustomerName(customerName);
sale.setMobileNo(mobileNo);
sale.setBuildingName(buildingName);
sale.setFaltNo(faltNo);
sale.setSaleAmount(saleAmount);
sale.setBookingAmount(bookingAmount);
sale.setPaymentMode(paymentMode);
sale.setRemarka(remarka);

if ("save".equals(action)) {

if (dao.addFlatSale(sale)) {
response.sendRedirect("FlatSaleEntry.jsp");
return;
} else {
message = "Unable to save flat sale.";
messageType = "error";
}

} else {

if (dao.updateFlatSale(sale)) {
response.sendRedirect("FlatSaleEntry.jsp");
return;
} else {
message = "Unable to update flat sale.";
messageType = "error";
}
}

} catch (Exception e) {
e.printStackTrace();
message = "Please enter valid flat sale details.";
messageType = "error";
}
}
}

List<FlatSale> allSaleList = dao.getAllFlatSales();

    List<FlatSale> saleList = new java.util.ArrayList<FlatSale>();

        for (FlatSale sale : allSaleList) {

        boolean matchesSearch = true;
        boolean matchesFromDate = true;
        boolean matchesToDate = true;
        boolean matchesBuilding = true;
        boolean matchesPaymentMode = true;

        if (!search.trim().isEmpty()) {

        String searchText = search.trim().toLowerCase();

        String customerName = sale.getCustomerName() == null
        ? ""
        : sale.getCustomerName().toLowerCase();

        String mobileNo = sale.getMobileNo() == null
        ? ""
        : sale.getMobileNo().toLowerCase();

        String buildingName = sale.getBuildingName() == null
        ? ""
        : sale.getBuildingName().toLowerCase();

        String faltNo = sale.getFaltNo() == null
        ? ""
        : sale.getFaltNo().toLowerCase();

        String paymentMode = sale.getPaymentMode() == null
        ? ""
        : sale.getPaymentMode().toLowerCase();

        String saleDateText = sale.getSaleDate() == null
        ? ""
        : sale.getSaleDate().toString().toLowerCase();

        matchesSearch =
        customerName.contains(searchText)
        || mobileNo.contains(searchText)
        || buildingName.contains(searchText)
        || faltNo.contains(searchText)
        || paymentMode.contains(searchText)
        || saleDateText.contains(searchText);
        }

        if (!fromDate.trim().isEmpty()) {

        try {

        Date selectedFromDate = Date.valueOf(fromDate);

        if (sale.getSaleDate() == null
        || sale.getSaleDate().before(selectedFromDate)) {

        matchesFromDate = false;
        }

        } catch (Exception e) {
        matchesFromDate = true;
        }
        }

        if (!toDate.trim().isEmpty()) {

        try {

        Date selectedToDate = Date.valueOf(toDate);

        if (sale.getSaleDate() == null
        || sale.getSaleDate().after(selectedToDate)) {

        matchesToDate = false;
        }

        } catch (Exception e) {
        matchesToDate = true;
        }
        }

        if (!filterBuilding.trim().isEmpty()) {

        if (sale.getBuildingName() == null
        || !filterBuilding.equals(sale.getBuildingName())) {

        matchesBuilding = false;
        }
        }

        if (!filterPaymentMode.trim().isEmpty()) {

        if (sale.getPaymentMode() == null
        || !filterPaymentMode.equals(sale.getPaymentMode())) {

        matchesPaymentMode = false;
        }
        }

        if (matchesSearch
        && matchesFromDate
        && matchesToDate
        && matchesBuilding
        && matchesPaymentMode) {

        saleList.add(sale);
        }
        }
        %>

        <%@ include file="../Common.jsp" %>

        <style>
            .flat-sale-layout {
                display: grid;
                grid-template-columns: 280px 1fr;
                gap: 15px;
            }

            .sale-card {
                background: #ffffff;
                border-radius: 8px;
                padding: 16px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            }

            .card-title {
                color: #24056f;
                font-size: 15px;
                font-weight: 600;
                padding-bottom: 10px;
                margin-bottom: 8px;
            }

            .form-grid {
                display: grid;
                grid-template-columns: minmax(0,1fr) minmax(0,1fr);
                gap: 13px 12px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            .form-group.full {
                grid-column: 1 / -1;
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
                padding: 7px 8px;
                font-size: 11px;
                color: #555555;
                outline: none;
                background: #ffffff;
            }

            .form-group input,
            .form-group select {
                height: 32px;
            }

            .form-group textarea {
                height: 55px;
                resize: none;
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                border-color: #d62d70;
            }

            .form-buttons {
                display: flex;
                justify-content: center;
                gap: 9px;
                margin-top: 17px;
            }

            .save-btn,
            .reset-btn {
                border-radius: 5px;
                padding: 8px 15px;
                font-size: 11px;
                cursor: pointer;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }

            .save-btn {
                border: none;
                background: #d62d70;
                color: #ffffff;
            }

            .reset-btn {
                border: 1px solid #dddddd;
                background: #ffffff;
                color: #555555;
            }

            .save-btn:hover {
                background: #bd245f;
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

            .table-container {
                width: 100%;
                overflow-x: auto;
            }

            .sale-table {
                width: 100%;
                border-collapse: collapse;
                min-width: 900px;
            }

            .sale-table th {
                background: #fcecf3;
                color: #303044;
                font-size: 10px;
                font-weight: 600;
                padding: 11px 8px;
                text-align: left;
                white-space: nowrap;
            }

            .sale-table td {
                padding: 12px 8px;
                border-bottom: 1px solid #eeeeee;
                font-size: 10px;
                color: #303044;
                white-space: nowrap;
            }

            .sale-table tbody tr:hover {
                background: #fffafd;
            }

            .sale-amount {
                color: #218838;
                font-weight: 500;
            }

            .action-buttons {
                display: flex;
                gap: 5px;
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

            .list-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .filter-btn {
                border: none;
                background: #d62d70;
                color: #ffffff;
                padding: 7px 13px;
                border-radius: 5px;
                font-size: 10px;
                cursor: pointer;
            }

            .filter-btn:hover {
                background: #bd245f;
            }

            .filter-panel {
                display: none;
                background: #faf8ff;
                border: 1px solid #e5def4;
                border-radius: 6px;
                padding: 12px;
                margin: 12px 0;
            }

            .filter-panel.show {
                display: block;
            }

            .filter-grid {
                display: grid;
                grid-template-columns: repeat(4, minmax(0,1fr));
                gap: 10px;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
            }

            .filter-group label {
                font-size: 10px;
                color: #303044;
                margin-bottom: 5px;
            }

            .filter-group input,
            .filter-group select {
                height: 32px;
                box-sizing: border-box;
                border: 1px solid #dddddd;
                border-radius: 5px;
                padding: 6px 8px;
                font-size: 10px;
                color: #555555;
                background: #ffffff;
                outline: none;
            }

            .filter-actions {
                display: flex;
                gap: 8px;
                margin-top: 10px;
            }

            .apply-filter-btn,
            .clear-filter-btn {
                border-radius: 5px;
                padding: 7px 13px;
                font-size: 10px;
                cursor: pointer;
                text-decoration: none;
            }

            .apply-filter-btn {
                border: none;
                background: #d62d70;
                color: #ffffff;
            }

            .clear-filter-btn {
                border: 1px solid #dddddd;
                background: #ffffff;
                color: #555555;
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
                background: #d62d70;
                color: #ffffff;
                border-color: #d62d70;
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
                background: #ffffff;
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

                .flat-sale-layout {
                    grid-template-columns: 1fr;
                }

                .filter-grid {
                    grid-template-columns: repeat(2, minmax(0,1fr));
                }
            }

            @media (max-width: 600px) {

                .form-grid {
                    grid-template-columns: 1fr;
                }

                .form-group.full {
                    grid-column: auto;
                }

                .page-header {
                    flex-direction: column;
                    align-items: stretch;
                    gap: 12px;
                }

                .search-box {
                    width: auto;
                }

                .filter-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>

        <% if (!message.isEmpty()) { %>

        <div class="message <%= messageType %>">
            <%= message %>
        </div>

        <% } %>

        <div class="page-header">

            <h2>Flat Sale Entry</h2>

            <form method="get"
                  action="FlatSaleEntry.jsp"
                  class="search-box">

                <i class="fa fa-search"></i>

                <input type="text"
                       name="search"
                       value="<%= search %>"
                       placeholder="Search flat sale...">

                <input type="hidden"
                       name="fromDate"
                       value="<%= fromDate %>">

                <input type="hidden"
                       name="toDate"
                       value="<%= toDate %>">

                <input type="hidden"
                       name="filterBuilding"
                       value="<%= filterBuilding %>">

                <input type="hidden"
                       name="filterPaymentMode"
                       value="<%= filterPaymentMode %>">

            </form>

        </div>

        <div class="flat-sale-layout">

            <div class="sale-card">

                <div class="card-title">
                    <%= editSale == null ? "Add Flat Sale Entry" : "Edit Flat Sale Entry" %>
                </div>

                <form method="post"
                      action="FlatSaleEntry.jsp">

                    <input type="hidden"
                           name="action"
                           value="<%= editSale == null ? "save" : "update" %>">

                    <% if (editSale != null) { %>

                    <input type="hidden"
                           name="id"
                           value="<%= editSale.getId() %>">

                    <% } %>

                    <div class="form-grid">

                        <div class="form-group">

                            <label>
                                Date <span class="required">*</span>
                            </label>

                            <input type="date"
                                   name="saleDate"
                                   value="<%= editSale != null ? editSale.getSaleDate() : "" %>"
                            required>

                        </div>

                        <div class="form-group">

                            <label>
                                Customer Name <span class="required">*</span>
                            </label>

                            <input type="text"
                                   name="customerName"
                                   value="<%= editSale != null && editSale.getCustomerName() != null ? editSale.getCustomerName() : "" %>"
                            placeholder="Enter customer name"
                            required>

                        </div>

                        <div class="form-group">

                            <label>
                                Mobile No.
                            </label>

                            <input type="tel"
                                   name="mobileNo"
                                   value="<%= editSale != null && editSale.getMobileNo() != null ? editSale.getMobileNo() : "" %>"
                            placeholder="Enter mobile number">

                        </div>

                        <div class="form-group">

                            <label>
                                Project Name
                            </label>

                            <select name="buildingName">

                                <option value="">
                                    Select Project
                                </option>

                                <option value="Skyline Heights"
                                <%= editSale != null && "Skyline Heights".equals(editSale.getBuildingName()) ? "selected" : "" %>>
                                Skyline Heights
                                </option>

                                <option value="Green Valley"
                                <%= editSale != null && "Green Valley".equals(editSale.getBuildingName()) ? "selected" : "" %>>
                                Green Valley
                                </option>

                                <option value="Sunrise Residency"
                                <%= editSale != null && "Sunrise Residency".equals(editSale.getBuildingName()) ? "selected" : "" %>>
                                Sunrise Residency
                                </option>

                            </select>

                        </div>

                        <div class="form-group">

                            <label>
                                Flat No. <span class="required">*</span>
                            </label>

                            <select name="faltNo"
                                    required>

                                <option value="">
                                    Select Flat
                                </option>

                                <option value="A-101"
                                <%= editSale != null && "A-101".equals(editSale.getFaltNo()) ? "selected" : "" %>>
                                A-101
                                </option>

                                <option value="A-202"
                                <%= editSale != null && "A-202".equals(editSale.getFaltNo()) ? "selected" : "" %>>
                                A-202
                                </option>

                                <option value="A-303"
                                <%= editSale != null && "A-303".equals(editSale.getFaltNo()) ? "selected" : "" %>>
                                A-303
                                </option>

                                <option value="A-402"
                                <%= editSale != null && "A-402".equals(editSale.getFaltNo()) ? "selected" : "" %>>
                                A-402
                                </option>

                                <option value="B-204"
                                <%= editSale != null && "B-204".equals(editSale.getFaltNo()) ? "selected" : "" %>>
                                B-204
                                </option>

                                <option value="C-302"
                                <%= editSale != null && "C-302".equals(editSale.getFaltNo()) ? "selected" : "" %>>
                                C-302
                                </option>

                                <option value="D-103"
                                <%= editSale != null && "D-103".equals(editSale.getFaltNo()) ? "selected" : "" %>>
                                D-103
                                </option>

                                <option value="E-201"
                                <%= editSale != null && "E-201".equals(editSale.getFaltNo()) ? "selected" : "" %>>
                                E-201
                                </option>

                                <option value="F-104"
                                <%= editSale != null && "F-104".equals(editSale.getFaltNo()) ? "selected" : "" %>>
                                F-104
                                </option>

                            </select>

                        </div>

                        <div class="form-group">

                            <label>
                                Sale Amount
                                (<i class="fa-solid fa-indian-rupee-sign"></i>)
                                <span class="required">*</span>
                            </label>

                            <input type="number"
                                   name="saleAmount"
                                   value="<%= editSale != null ? editSale.getSaleAmount() : "" %>"
                            placeholder="Enter amount"
                            step="0.01"
                            min="0"
                            required>

                        </div>

                        <div class="form-group">

                            <label>
                                Booking Amount
                                (<i class="fa-solid fa-indian-rupee-sign"></i>)
                            </label>

                            <input type="number"
                                   name="bookingAmount"
                                   value="<%= editSale != null ? editSale.getBookingAmount() : "" %>"
                            placeholder="Enter booking amount"
                            step="0.01"
                            min="0">

                        </div>

                        <div class="form-group">

                            <label>
                                Payment Mode <span class="required">*</span>
                            </label>

                            <select name="paymentMode"
                                    required>

                                <option value="">
                                    Select Mode
                                </option>

                                <option value="Cash"
                                <%= editSale != null && "Cash".equals(editSale.getPaymentMode()) ? "selected" : "" %>>
                                Cash
                                </option>

                                <option value="UPI"
                                <%= editSale != null && "UPI".equals(editSale.getPaymentMode()) ? "selected" : "" %>>
                                UPI
                                </option>

                                <option value="Bank Transfer"
                                <%= editSale != null && "Bank Transfer".equals(editSale.getPaymentMode()) ? "selected" : "" %>>
                                Bank Transfer
                                </option>

                                <option value="Cheque"
                                <%= editSale != null && "Cheque".equals(editSale.getPaymentMode()) ? "selected" : "" %>>
                                Cheque
                                </option>

                            </select>

                        </div>

                        <div class="form-group full">

                            <label>
                                Remarks
                            </label>

                            <textarea name="remarka"
                                      placeholder="Enter remarks (optional)"><%= editSale != null && editSale.getRemarka() != null ? editSale.getRemarka() : "" %></textarea>

                        </div>

                    </div>

                    <div class="form-buttons">

                        <button type="submit"
                                class="save-btn">

                            <i class="fa fa-save"></i>
                            &nbsp;
                            <%= editSale == null ? "Save Sale" : "Update Sale" %>

                        </button>

                        <% if (editSale != null) { %>

                        <a href="FlatSaleEntry.jsp"
                           class="reset-btn">

                            <i class="fa fa-rotate-left"></i>
                            &nbsp; Cancel

                        </a>

                        <% } else { %>

                        <button type="reset"
                                class="reset-btn">

                            <i class="fa fa-rotate-left"></i>
                            &nbsp; Reset

                        </button>

                        <% } %>

                    </div>

                </form>

            </div>

            <div class="sale-card">

                <div class="list-header">

                    <div class="card-title">
                        Flat Sales List
                    </div>

                    <button type="button"
                            class="filter-btn"
                            onclick="toggleFilter()">

                        <i class="fa fa-filter"></i>
                        &nbsp; Filter

                    </button>

                </div>

                <div id="filterPanel"
                     class="filter-panel">

                    <form method="get"
                          action="FlatSaleEntry.jsp">

                        <input type="hidden"
                               name="search"
                               value="<%= search %>">

                        <div class="filter-grid">

                            <div class="filter-group">

                                <label>
                                    From Date
                                </label>

                                <input type="date"
                                       name="fromDate"
                                       value="<%= fromDate %>">

                            </div>

                            <div class="filter-group">

                                <label>
                                    To Date
                                </label>

                                <input type="date"
                                       name="toDate"
                                       value="<%= toDate %>">

                            </div>

                            <div class="filter-group">

                                <label>
                                    Project Name
                                </label>

                                <select name="filterBuilding">

                                    <option value="">
                                        All Projects
                                    </option>

                                    <option value="Skyline Heights"
                                    <%= "Skyline Heights".equals(filterBuilding) ? "selected" : "" %>>
                                    Skyline Heights
                                    </option>

                                    <option value="Green Valley"
                                    <%= "Green Valley".equals(filterBuilding) ? "selected" : "" %>>
                                    Green Valley
                                    </option>

                                    <option value="Sunrise Residency"
                                    <%= "Sunrise Residency".equals(filterBuilding) ? "selected" : "" %>>
                                    Sunrise Residency
                                    </option>

                                </select>

                            </div>

                            <div class="filter-group">

                                <label>
                                    Payment Mode
                                </label>

                                <select name="filterPaymentMode">

                                    <option value="">
                                        All Modes
                                    </option>

                                    <option value="Cash"
                                    <%= "Cash".equals(filterPaymentMode) ? "selected" : "" %>>
                                    Cash
                                    </option>

                                    <option value="UPI"
                                    <%= "UPI".equals(filterPaymentMode) ? "selected" : "" %>>
                                    UPI
                                    </option>

                                    <option value="Bank Transfer"
                                    <%= "Bank Transfer".equals(filterPaymentMode) ? "selected" : "" %>>
                                    Bank Transfer
                                    </option>

                                    <option value="Cheque"
                                    <%= "Cheque".equals(filterPaymentMode) ? "selected" : "" %>>
                                    Cheque
                                    </option>

                                </select>

                            </div>

                        </div>

                        <div class="filter-actions">

                            <button type="submit"
                                    class="apply-filter-btn">

                                <i class="fa fa-filter"></i>
                                &nbsp; Apply Filter

                            </button>

                            <a href="FlatSaleEntry.jsp"
                               class="clear-filter-btn">

                                <i class="fa fa-rotate-left"></i>
                                &nbsp; Clear

                            </a>

                        </div>

                    </form>

                </div>

                <div class="table-container">

                    <table class="sale-table">

                        <thead>

                        <tr>

                            <th>#</th>
                            <th>Date</th>
                            <th>Customer Name</th>
                            <th>Project Name</th>
                            <th>Flat No.</th>
                            <th>Sale Amount (<i class="fa-solid fa-indian-rupee-sign"></i>)</th>
                            <th>Booking Amount (<i class="fa-solid fa-indian-rupee-sign"></i>)</th>
                            <th>Payment Mode</th>
                            <th>Action</th>

                        </tr>

                        </thead>

                        <tbody>

                        <%
                        int count = 1;

                        if (saleList != null && !saleList.isEmpty()) {

                        for (FlatSale sale : saleList) {
                        %>

                        <tr>

                            <td>
                                <%= count %>
                            </td>

                            <td>
                                <%= sale.getSaleDate() %>
                            </td>

                            <td>
                                <%= sale.getCustomerName() %>
                            </td>

                            <td>
                                <%= sale.getBuildingName() == null || sale.getBuildingName().isEmpty()
                                ? "-"
                                : sale.getBuildingName() %>
                            </td>

                            <td>
                                <%= sale.getFaltNo() %>
                            </td>

                            <td class="sale-amount">

                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                <%= String.format("%.2f", sale.getSaleAmount()) %>

                            </td>

                            <td>

                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                <%= String.format("%.2f", sale.getBookingAmount()) %>

                            </td>

                            <td>
                                <%= sale.getPaymentMode() %>
                            </td>

                            <td>

                                <div class="action-buttons">

                                    <a href="FlatSaleEntry.jsp?editId=<%= sale.getId() %>"
                                       class="edit-btn"
                                       title="Edit">

                                        <i class="fa fa-pen"></i>

                                    </a>

                                    <form method="post"
                                          action="FlatSaleEntry.jsp"
                                          style="display:inline;"
                                          onsubmit="return confirm('Are you sure you want to delete this sale?');">

                                        <input type="hidden"
                                               name="action"
                                               value="delete">

                                        <input type="hidden"
                                               name="id"
                                               value="<%= sale.getId() %>">

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

                                No flat sale entries found.

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

                        Showing
                        <%= saleList.size() > 0 ? "1" : "0" %>
                        to
                        <%= saleList.size() %>
                        of
                        <%= saleList.size() %>
                        entries

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

        <script>
            function toggleFilter() {

                var filterPanel = document.getElementById("filterPanel");

                filterPanel.classList.toggle("show");
            }
        </script>

        </div>
        </div>
        </body>
        </html>