<%@ page import="java.sql.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="com.skyline.model.PettyCash" %>
<%@ page import="com.skyline.dao.PettyCashDAO" %>

<%
String message = "";
String messageType = "";

String search = request.getParameter("search");

if (search == null) {
search = "";
}

PettyCashDAO dao = new PettyCashDAO();

PettyCash editPettyCash = null;

String editId = request.getParameter("editId");

if (editId != null && !editId.isEmpty()) {
try {
editPettyCash = dao.getPettyCashById(Integer.parseInt(editId));
} catch (Exception e) {
e.printStackTrace();
}
}

if ("POST".equalsIgnoreCase(request.getMethod())) {

String action = request.getParameter("action");

if ("delete".equals(action)) {

try {
int id = Integer.parseInt(request.getParameter("id"));

if (dao.deletePettyCash(id)) {
response.sendRedirect("PettyCashEntry.jsp");
return;
}

} catch (Exception e) {
e.printStackTrace();
}
}

if ("save".equals(action) || "update".equals(action)) {

String entryDate = request.getParameter("entryDate");
String voucherNo = request.getParameter("voucherNo");
String particulars = request.getParameter("particulars");
String category = request.getParameter("category");
String paymentMode = request.getParameter("paymentMode");
String amountText = request.getParameter("amount");
String remarks = request.getParameter("remarks");

try {

PettyCash pettyCash = new PettyCash();

if ("update".equals(action)) {
pettyCash.setId(Integer.parseInt(request.getParameter("id")));
}

pettyCash.setEntryDate(Date.valueOf(entryDate));
pettyCash.setVoucherNo(voucherNo);
pettyCash.setParticulars(particulars);
pettyCash.setCategory(category);
pettyCash.setPaymentMode(paymentMode);
pettyCash.setAmount(Double.parseDouble(amountText));
pettyCash.setRemarks(remarks);

if ("save".equals(action)) {

if (dao.addPettyCash(pettyCash)) {
response.sendRedirect("PettyCashEntry.jsp");
return;
} else {
message = "Unable to save petty cash entry.";
messageType = "error";
}

} else {

if (dao.updatePettyCash(pettyCash)) {
response.sendRedirect("PettyCashEntry.jsp");
return;
} else {
message = "Unable to update petty cash entry.";
messageType = "error";
}
}

} catch (Exception e) {
e.printStackTrace();
message = "Please enter valid petty cash details.";
messageType = "error";
}
}
}

List<PettyCash> pettyCashList;

    if (!search.trim().isEmpty()) {
    pettyCashList = dao.searchPettyCash(search.trim());
    } else {
    pettyCashList = dao.getAllPettyCash();
    }
    %>

    <%@ page pageEncoding="UTF-8" %>

    <%@ include file="../Common.jsp" %>

    <style>
        .pettycash-layout {
            display: grid;
            grid-template-columns: 295px 1fr;
            gap: 18px;
        }

        .pettycash-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }

        .card-title {
            color: #176b35;
            font-size: 15px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 1px solid #cfe5d3;
            margin-bottom: 16px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
            gap: 14px 12px;
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
            border: 1px solid #dddddd;
            border-radius: 5px;
            padding: 8px 9px;
            font-size: 11px;
            color: #555555;
            outline: none;
            background: #ffffff;
            box-sizing: border-box;
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
            border-color: #299447;
        }

        .form-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 8px;
            margin-top: 18px;
        }

        .save-btn,
        .reset-btn {
            border-radius: 5px;
            padding: 8px 14px;
            font-size: 11px;
            cursor: pointer;
        }

        .save-btn {
            border: none;
            background: #299447;
            color: #ffffff;
        }

        .reset-btn {
            border: 1px solid #dddddd;
            background: #ffffff;
            color: #555555;
            text-decoration: none;
        }

        .save-btn:hover {
            background: #217c3a;
        }

        .list-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
        }

        .pettycash-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 720px;
        }

        .pettycash-table th {
            background: #edf8ef;
            color: #303044;
            font-size: 10px;
            font-weight: 600;
            padding: 11px 8px;
            text-align: left;
            white-space: nowrap;
        }

        .pettycash-table td {
            padding: 12px 8px;
            border-bottom: 1px solid #eeeeee;
            font-size: 10px;
            color: #303044;
            white-space: nowrap;
        }

        .pettycash-table tbody tr:hover {
            background: #fafafa;
        }

        .action-buttons {
            display: flex;
            gap: 6px;
        }

        .view-btn,
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
            box-sizing: border-box;
        }

        .view-btn {
            background: #edf8ef;
            color: #299447;
        }

        .edit-btn {
            background: #fff5df;
            color: #e39a00;
        }

        .delete-btn {
            background: #fff0f0;
            color: #e63946;
        }

        .message {
            margin-bottom: 12px;
            padding: 8px 10px;
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
            background: #299447;
            color: #ffffff;
            border-color: #299447;
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
            .pettycash-layout {
                grid-template-columns: 1fr;
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
                align-items: flex-start;
                gap: 12px;
            }

            .search-box {
                width: 100%;
                box-sizing: border-box;
            }
        }
    </style>

    <div class="page-header">

        <h2>Petty Cash Entry</h2>

        <form method="get"
              action="PettyCashEntry.jsp"
              class="search-box">

            <i class="fa fa-search"></i>

            <input type="text"
                   name="search"
                   value="<%= search %>"
                   placeholder="Search petty cash...">

        </form>

    </div>

    <% if (!message.isEmpty()) { %>

    <div class="message <%= messageType %>">
        <%= message %>
    </div>

    <% } %>

    <div class="pettycash-layout">

        <div class="pettycash-card">

            <div class="card-title">
                <%= editPettyCash == null
                ? "Add Petty Cash Entry"
                : "Edit Petty Cash Entry" %>
            </div>

            <form method="post"
                  action="PettyCashEntry.jsp">

                <input type="hidden"
                       name="action"
                       value="<%= editPettyCash == null ? "save" : "update" %>">

                <% if (editPettyCash != null) { %>

                <input type="hidden"
                       name="id"
                       value="<%= editPettyCash.getId() %>">

                <% } %>

                <div class="form-grid">

                    <div class="form-group">

                        <label>
                            Date <span class="required">*</span>
                        </label>

                        <input type="date"
                               name="entryDate"
                               value="<%= editPettyCash != null
                                   ? editPettyCash.getEntryDate()
                                   : "" %>"
                        required>

                    </div>

                    <div class="form-group">

                        <label>
                            Voucher No. <span class="required">*</span>
                        </label>

                        <input type="text"
                               name="voucherNo"
                               value="<%= editPettyCash != null
                                   ? editPettyCash.getVoucherNo()
                                   : "" %>"
                        placeholder="PC-001"
                        required>

                    </div>

                    <div class="form-group full">

                        <label>
                            Particulars <span class="required">*</span>
                        </label>

                        <textarea name="particulars"
                                  placeholder="Enter particulars"
                                  required><%= editPettyCash != null
                                      ? editPettyCash.getParticulars()
                                      : "" %></textarea>

                    </div>

                    <div class="form-group">

                        <label>
                            Category <span class="required">*</span>
                        </label>

                        <select name="category"
                                required>

                            <option value="">
                                Select Category
                            </option>

                            <option value="Office Expense"
                            <%= editPettyCash != null
                            && "Office Expense".equals(editPettyCash.getCategory())
                            ? "selected"
                            : "" %>>
                            Office Expense
                            </option>

                            <option value="Traveling Expense"
                            <%= editPettyCash != null
                            && "Traveling Expense".equals(editPettyCash.getCategory())
                            ? "selected"
                            : "" %>>
                            Traveling Expense
                            </option>

                            <option value="Printing & Stationery"
                            <%= editPettyCash != null
                            && "Printing & Stationery".equals(editPettyCash.getCategory())
                            ? "selected"
                            : "" %>>
                            Printing & Stationery
                            </option>

                            <option value="Courier Expense"
                            <%= editPettyCash != null
                            && "Courier Expense".equals(editPettyCash.getCategory())
                            ? "selected"
                            : "" %>>
                            Courier Expense
                            </option>

                            <option value="Other Expense"
                            <%= editPettyCash != null
                            && "Other Expense".equals(editPettyCash.getCategory())
                            ? "selected"
                            : "" %>>
                            Other Expense
                            </option>

                        </select>

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
                            <%= editPettyCash != null
                            && "Cash".equals(editPettyCash.getPaymentMode())
                            ? "selected"
                            : "" %>>
                            Cash
                            </option>

                            <option value="UPI"
                            <%= editPettyCash != null
                            && "UPI".equals(editPettyCash.getPaymentMode())
                            ? "selected"
                            : "" %>>
                            UPI
                            </option>

                            <option value="Bank"
                            <%= editPettyCash != null
                            && "Bank".equals(editPettyCash.getPaymentMode())
                            ? "selected"
                            : "" %>>
                            Bank
                            </option>

                        </select>

                    </div>

                    <div class="form-group">

                        <label>
                            Amount (₹) <span class="required">*</span>
                        </label>

                        <input type="number"
                               name="amount"
                               value="<%= editPettyCash != null
                                   ? editPettyCash.getAmount()
                                   : "" %>"
                        placeholder="Enter amount"
                        step="0.01"
                        required>

                    </div>

                    <div class="form-group">

                        <label>
                            Remarks
                        </label>

                        <input type="text"
                               name="remarks"
                               value="<%= editPettyCash != null
                                   ? editPettyCash.getRemarks()
                                   : "" %>"
                        placeholder="Enter remarks (optional)">

                    </div>

                </div>

                <div class="form-buttons">

                    <button type="submit"
                            class="save-btn">

                        <i class="fa fa-save"></i>

                        &nbsp;

                        <%= editPettyCash == null
                        ? "Save Entry"
                        : "Update Entry" %>

                    </button>

                    <% if (editPettyCash != null) { %>

                    <a href="PettyCashEntry.jsp"
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

        <div class="pettycash-card">

            <div class="list-header">

                <div class="card-title">
                    Petty Cash Entry List
                </div>

            </div>

            <div class="table-container">

                <table class="pettycash-table">

                    <thead>

                    <tr>

                        <th>S No</th>
                        <th>Date</th>
                        <th>Voucher No.</th>
                        <th>Particulars</th>
                        <th>Category</th>
                        <th>Mode</th>
                        <th>Amount (₹)</th>
                        <th>Action</th>

                    </tr>

                    </thead>

                    <tbody>

                    <%
                    int count = 1;

                    if (pettyCashList != null && !pettyCashList.isEmpty()) {

                    for (int i = 0; i < pettyCashList.size(); i++) {

                    PettyCash pettyCash = pettyCashList.get(i);
                    %>

                    <tr>

                        <td>
                            <%= count %>
                        </td>

                        <td>
                            <%= pettyCash.getEntryDate() %>
                        </td>

                        <td>
                            <%= pettyCash.getVoucherNo() %>
                        </td>

                        <td>
                            <%= pettyCash.getParticulars() %>
                        </td>

                        <td>
                            <%= pettyCash.getCategory() %>
                        </td>

                        <td>
                            <%= pettyCash.getPaymentMode() %>
                        </td>

                        <td>
                            <%= String.format("%.2f", pettyCash.getAmount()) %>
                        </td>

                        <td>

                            <div class="action-buttons">

                                <a href="PettyCashEntry.jsp?editId=<%= pettyCash.getId() %>"
                                   class="edit-btn"
                                   title="Edit">

                                    <i class="fa fa-pen"></i>

                                </a>

                                <form method="post"
                                      action="PettyCashEntry.jsp"
                                      style="display:inline;"
                                      onsubmit="return confirm('Are you sure you want to delete this entry?');">

                                    <input type="hidden"
                                           name="action"
                                           value="delete">

                                    <input type="hidden"
                                           name="id"
                                           value="<%= pettyCash.getId() %>">

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

                        <td colspan="8"
                            style="text-align:center;padding:25px;color:#777777;">

                            No petty cash entries found.

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

                    <% if (pettyCashList != null && !pettyCashList.isEmpty()) { %>

                    Showing 1 to <%= pettyCashList.size() %>
                    of <%= pettyCashList.size() %> entries

                    <% } else { %>

                    Showing 0 to 0 of 0 entries

                    <% } %>

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
    </div>
    </body>
    </html>