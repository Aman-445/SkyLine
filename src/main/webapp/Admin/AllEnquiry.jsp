<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.skyline.model.Enquiry" %>
<%@ page import="com.skyline.dao.EnquiryDAO" %>
<%@ page import="java.util.List" %>

<%
String message = "";
String messageType = "";

EnquiryDAO enquiryDAO = new EnquiryDAO();

if ("POST".equalsIgnoreCase(request.getMethod())) {
                String action = request.getParameter("action");

                if ("delete".equals(action)) {
                        String enquiryNo = request.getParameter("enquiryNo");

                         if (enquiryNo != null && !enquiryNo.trim().isEmpty()) {
                                    if (enquiryDAO.deleteEnquiry(enquiryNo)) {
                                                message = "Enquiry deleted successfully.";
                                                messageType = "success";
                                    } else {
                                                message = "Unable to delete enquiry.";
                                                messageType = "error";
                                    }
                        } else {
                                message = "Invalid enquiry number.";
                                messageType = "error";
                        }
                } else {
                        String enquiryDate = request.getParameter("enquiryDate");
                        String enquiryNo = request.getParameter("enquiryNo");
                        String originalEnquiryNo = request.getParameter("originalEnquiryNo");
                        String buildingName = request.getParameter("buildingName");
                        String flatType = request.getParameter("flatType");
                        String customerName = request.getParameter("customerName");
                        String mobile = request.getParameter("mobile");
                        String budgetText = request.getParameter("budget");
                        String source = request.getParameter("source");
                        String preferredLocation = request.getParameter("preferredLocation");
                        String noOfBedrooms = request.getParameter("noOfBedrooms");
                        String purpose = request.getParameter("purpose");
                        String enquiryType = request.getParameter("enquiryType");

                        try {
                            double budget = budgetText == null || budgetText.trim().isEmpty() ? 0 : Double.parseDouble(budgetText);

                            Enquiry enquiry = new Enquiry(enquiryNo,Date.valueOf(enquiryDate),customerName,mobile,preferredLocation,
                                                            noOfBedrooms, buildingName, budget, purpose, flatType, source, enquiryType);

                            if ("update".equals(action)) {
                                    if (enquiryDAO.updateEnquiry(enquiry, originalEnquiryNo)) {
                                            message = "Enquiry updated successfully.";
                                            messageType = "success";
                                    } else {
                                            message = "Unable to update enquiry.";
                                            messageType = "error";
                                    }
                            } else {
                                    if (enquiryDAO.addEnquiry(enquiry)) {
                                                message = "Enquiry saved successfully.";
                                                messageType = "success";
                                    } else {
                                                message = "Unable to save enquiry.";
                                                messageType = "error";
                                    }
                            }
                        } catch (Exception e) {
                                    e.printStackTrace();
                                    message = "Please enter valid enquiry details.";
                                    messageType = "error";
                        }
                }
}
String editEnquiryNo = request.getParameter("editEnquiryNo");
Enquiry editingEnquiry = null;

if (editEnquiryNo != null && !editEnquiryNo.trim().isEmpty()) {
editingEnquiry = enquiryDAO.getEnquiryByNo(editEnquiryNo);
}

String search = request.getParameter("search");
List<Enquiry> enquiryList;

    if (search != null && !search.trim().isEmpty()) {
            enquiryList = enquiryDAO.searchEnquiries(search.trim());
    } else {
            enquiryList = enquiryDAO.getAllEnquiries();
    }
    %>

    <%@ include file="../Common.jsp" %>

    <style>

        .enquiry-card {
            background: #fff;
            border-radius: 8px;
            padding: 18px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);      /* Horozontal-offset  vertical-offset blur-radius color */
        }

        .section-title {
            color: #4b2aa5;
            font-size: 20px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 1px solid #b8a6dc;
            margin-bottom: 22px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px 22px;
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

        .required {
            color: #e63946;
        }

        .form-group input,
        .form-group select {
            height: 30px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 0 11px;
            font-size: 11px;
            color: #555;
            outline: none;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #6337bd;
        }

        .save-btn {
            margin-top: 20px;
            border: none;
            background: #6337bd;
            color: white;
            padding: 9px 16px;
            border-radius: 5px;
            font-size: 12px;
            cursor: pointer;
        }

        .save-btn:hover {
            background: #512aa5;
        }

        .cancel-btn {
            margin-top: 20px;
            margin-left: 8px;
            border: none;
            background: #777;
            color: white;
            padding: 9px 16px;
            border-radius: 5px;
            font-size: 12px;
            cursor: pointer;
            text-decoration: none;
        }

        .cancel-btn:hover {
            background: #555;
        }

        .message {
            margin-bottom: 15px;
            padding: 9px 12px;
            border-radius: 5px;
            font-size: 12px;
        }

        .success {
            background: #e8f7ed;
            color: #218838;
        }

        .error {
            background: #fdeaea;
            color: #c82333;
        }

        .enquiry-list-card {
            background: #fff;
            border-radius: 8px;
            padding: 18px;
            margin-top: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }

        .enquiry-list-title {
            color: #4b2aa5;
            font-size: 20px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 1px solid #b8a6dc;
            margin-bottom: 15px;
        }

        .enquiry-table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        .enquiry-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1150px;
        }

        .enquiry-table th {
            background: #f4f0fb;
            color: #303044;
            font-size: 10px;
            font-weight: 600;
            padding: 11px 8px;
            text-align: left;
            white-space: nowrap;
        }

        .enquiry-table td {
            padding: 11px 8px;
            border-bottom: 1px solid #eeeeee;
            font-size: 10px;
            color: #303044;
            white-space: nowrap;
        }

        .enquiry-table tbody tr:hover {
            background: #faf8ff;
        }

        .action-buttons {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .edit-btn {
            background: #6337bd;
            color: white;
            border: none;
            padding: 6px 9px;
            border-radius: 4px;
            font-size: 10px;
            cursor: pointer;
            text-decoration: none;
        }

        .edit-btn:hover {
            background: #512aa5;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 6px 9px;
            border-radius: 4px;
            font-size: 10px;
            cursor: pointer;
        }

        .delete-btn:hover {
            background: #bd2130;
        }

        @media (max-width: 900px) {
            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        .page-header {
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
            background-color: #ffffff;
        }

        .search-box input {
            border: none;
            outline: none;
            width: 100%;
            font-size: 14px;
        }

    </style>

    <div class="page-header">
        <form method="get" action="AllEnquiry.jsp" class="search-box">
            <input type="text" name="search" placeholder="Search enquiry..." value="<%= search != null ? search : "" %>">
            <i class="fa-solid fa-magnifying-glass" style="color: rgb(72, 100, 211);"></i>
        </form>
    </div>

    <div class="enquiry-card">

        <div class="section-title">
            <%= editingEnquiry != null ? "Edit Flat Enquiry" : "Flat Enquiry Entry" %>
        </div>

        <% if (!message.isEmpty()) { %>
        <div class="message <%= messageType %>"><%= message %></div>
        <% } %>

        <form method="post" action="AllEnquiry.jsp">
            <input type="hidden" name="action" value="<%= editingEnquiry != null ? "update" : "save" %>">

            <% if (editingEnquiry != null) { %>
            <input type="hidden" name="originalEnquiryNo" value="<%= editingEnquiry.getEnquiryNo() %>">
            <% } %>

            <div class="form-grid">

                <div class="form-group">
                    <label>
                        Enquiry Date
                        <span class="required">*</span>
                    </label>

                    <input type="date" name="enquiryDate" value="<%= editingEnquiry != null && editingEnquiry.getEnquiryDate() != null
                                ? editingEnquiry.getEnquiryDate() : "" %>" required>
                </div>

                <div class="form-group">
                    <label>Enquiry No.</label>
                    <input type="text" name="enquiryNo" placeholder="ENQ-001" value="<%= editingEnquiry != null
                               ? editingEnquiry.getEnquiryNo() : "" %>" required>
                </div>

                <div class="form-group">
                    <label>
                        Project / Building
                        <span class="required">*</span>
                    </label>
                    <input type="text" name="buildingName" placeholder="Select Project" value="<%= editingEnquiry != null
                               ? editingEnquiry.getBuildingName() : "" %>" required>
                </div>

                <div class="form-group">
                    <label>
                        Flat Type
                        <span class="required">*</span>
                    </label>

                    <select name="flatType" required>
                        <option value="">Select Flat Type</option>

                        <option value="1 BHK"
                        <%= editingEnquiry != null && "1 BHK".equals(editingEnquiry.getFlatType()) ? "selected" : "" %>>
                        1 BHK
                        </option>

                        <option value="2 BHK"
                        <%= editingEnquiry != null && "2 BHK".equals(editingEnquiry.getFlatType()) ? "selected" : "" %>>
                        2 BHK
                        </option>

                        <option value="3 BHK"
                        <%= editingEnquiry != null && "3 BHK".equals(editingEnquiry.getFlatType()) ? "selected" : "" %>>
                        3 BHK
                        </option>

                        <option value="4 BHK"
                        <%= editingEnquiry != null && "4 BHK".equals(editingEnquiry.getFlatType()) ? "selected" : "" %>>
                        4 BHK
                        </option>

                    </select>
                </div>

                <div class="form-group">
                    <label>
                        Customer Name
                        <span class="required">*</span>
                    </label>

                    <input type="text" name="customerName" placeholder="Enter customer name" value="<%= editingEnquiry != null
                               ? editingEnquiry.getCustomerName() : "" %>" required>
                </div>

                <div class="form-group">
                    <label>
                        Mobile
                        <span class="required">*</span>
                    </label>

                    <input type="tel" name="mobile" placeholder="Enter mobile number" value="<%= editingEnquiry != null
                               ? editingEnquiry.getMobile() : "" %>" required>
                </div>

                <div class="form-group">
                    <label>Budget (₹)</label>

                    <input type="number" name="budget" placeholder="Enter budget" step="0.01" value="<%= editingEnquiry != null
                               ? editingEnquiry.getBudget() : "" %>">
                </div>

                <div class="form-group">

                    <label>Source</label>
                    <select name="source">

                        <option value="">Select Source</option>

                        <option value="Website"
                        <%= editingEnquiry != null && "Website".equals(editingEnquiry.getSource()) ? "selected" : "" %>>
                        Website
                        </option>

                        <option value="Referral"
                        <%= editingEnquiry != null && "Referral".equals(editingEnquiry.getSource()) ? "selected" : "" %>>
                        Referral
                        </option>

                        <option value="Walk-in"
                        <%= editingEnquiry != null && "Walk-in".equals(editingEnquiry.getSource()) ? "selected" : "" %>>
                        Walk-in
                        </option>

                        <option value="Advertisement"
                        <%= editingEnquiry != null && "Advertisement".equals(editingEnquiry.getSource()) ? "selected" : "" %>>
                        Advertisement
                        </option>

                    </select>
                </div>

                <div class="form-group">
                    <label>Preferred Location</label>

                    <input type="text" name="preferredLocation" placeholder="Select Location" value="<%= editingEnquiry != null
                               ? editingEnquiry.getPreferredLocation() : "" %>">
                </div>

                <div class="form-group">
                    <label>No. of Bedrooms</label>

                    <select name="noOfBedrooms">

                        <option value="">Select Bedrooms</option>

                        <option value="1"
                        <%= editingEnquiry != null && "1".equals(editingEnquiry.getNoOfBedrooms()) ? "selected" : "" %>>
                        1
                        </option>

                        <option value="2"
                        <%= editingEnquiry != null && "2".equals(editingEnquiry.getNoOfBedrooms()) ? "selected" : "" %>>
                        2
                        </option>

                        <option value="3"
                        <%= editingEnquiry != null && "3".equals(editingEnquiry.getNoOfBedrooms()) ? "selected" : "" %>>
                        3
                        </option>

                        <option value="4"
                        <%= editingEnquiry != null && "4".equals(editingEnquiry.getNoOfBedrooms()) ? "selected" : "" %>>
                        4
                        </option>

                    </select>
                </div>

                <div class="form-group">
                    <label>Purpose</label>

                    <select name="purpose">
                        <option value="">Select Purpose</option>

                        <option value="Self Use"
                        <%= editingEnquiry != null && "Self Use".equals(editingEnquiry.getPurpose()) ? "selected" : "" %>>
                        Self Use
                        </option>

                        <option value="Investment"
                        <%= editingEnquiry != null && "Investment".equals(editingEnquiry.getPurpose()) ? "selected" : "" %>>
                        Investment
                        </option>

                        <option value="Rental"
                        <%= editingEnquiry != null && "Rental".equals(editingEnquiry.getPurpose()) ? "selected" : "" %>>
                        Rental
                        </option>

                    </select>
                </div>

                <div class="form-group">

                    <label>Enquiry Type</label>

                    <select name="enquiryType">
                        <option value="">Select Type</option>

                        <option value="New"
                        <%= editingEnquiry != null && "New".equals(editingEnquiry.getEnquiryType()) ? "selected" : "" %>>
                        New
                        </option>

                        <option value="Existing"
                        <%= editingEnquiry != null && "Existing".equals(editingEnquiry.getEnquiryType()) ? "selected" : "" %>>
                        Existing
                        </option>

                        <option value="Hot"
                        <%= editingEnquiry != null && "Hot".equals(editingEnquiry.getEnquiryType()) ? "selected" : "" %>>
                        Hot
                        </option>

                        <option value="Cold"
                        <%= editingEnquiry != null && "Cold".equals(editingEnquiry.getEnquiryType()) ? "selected" : "" %>>
                        Cold
                        </option>

                    </select>
                </div>
            </div>

            <button type="submit" class="save-btn">
                <i class="fa-solid <%= editingEnquiry != null? "fa-pen-to-square" : "fa-floppy-disk" %>"></i>
                &nbsp;
                <%= editingEnquiry != null ? "Update Enquiry" : "Save Enquiry" %>
            </button>

            <% if (editingEnquiry != null) { %>
            <a href="AllEnquiry.jsp" class="cancel-btn">
                <i class="fa-solid fa-xmark"></i>
                &nbsp; Cancel
            </a>
            <% } %>

        </form>
    </div>

    <div class="enquiry-list-card">

        <div class="enquiry-list-title">
            All Enquiries
        </div>

        <div class="enquiry-table-wrapper">
            <table class="enquiry-table">
                <thead>
                <tr>
                    <th>S No</th>
                    <th>Enquiry No.</th>
                    <th>Date</th>
                    <th>Customer Name</th>
                    <th>Mobile</th>
                    <th>Building</th>
                    <th>Flat Type</th>
                    <th>Budget (₹)</th>
                    <th>Source</th>
                    <th>Preferred Location</th>
                    <th>Purpose</th>
                    <th>Enquiry Type</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>
                <%
                int count = 1;
                if (enquiryList != null && !enquiryList.isEmpty()) {
                for (Enquiry enquiry : enquiryList) {
                %>

                <tr>
                    <td><%= count %></td>
                    <td><%= enquiry.getEnquiryNo() %></td>
                    <td><%= enquiry.getEnquiryDate() %></td>
                    <td><%= enquiry.getCustomerName() %></td>
                    <td><%= enquiry.getMobile() %></td>
                    <td><%= enquiry.getBuildingName() %></td>
                    <td><%= enquiry.getFlatType() %></td>
                    <td><%= String.format("%.2f", enquiry.getBudget()) %></td>
                    <td><%= enquiry.getSource() %></td>
                    <td><%= enquiry.getPreferredLocation() %></td>
                    <td><%= enquiry.getPurpose() %></td>
                    <td><%= enquiry.getEnquiryType() %></td>
                    <td>
                        <div class="action-buttons">

                            <a href="AllEnquiry.jsp?editEnquiryNo=<%= enquiry.getEnquiryNo() %>"
                               class="edit-btn" title="Edit">
                                <i class="fa-solid fa-pen"></i>
                            </a>

                            <form method="post" action="AllEnquiry.jsp"
                                  onsubmit="return confirm('Are you sure you want to delete this enquiry?');" style="margin:0;">

                                      <!-- ye hidden details hai jo jsp code and database mai paas hogi -->
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="enquiryNo" value="<%= enquiry.getEnquiryNo() %>">

                                <button type="submit" class="delete-btn" title="Delete">
                                    <i class="fa-solid fa-trash"></i>
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
                    <td colspan="13" style="text-align:center;padding:25px;color:#777;">
                        No enquiries found.
                    </td>
                </tr>
                <% } %>
                </tbody>

            </table>
        </div>
    </div>

    </div>
    </div>
    </body>
    </html>