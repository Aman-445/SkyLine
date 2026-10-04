<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.skyline.model.Enquiry" %>
<%@ page import="com.skyline.model.FollowUp" %>
<%@ page import="com.skyline.model.Lead" %>
<%@ page import="com.skyline.model.DayBook" %>
<%@ page import="com.skyline.model.PettyCash" %>
<%@ page import="com.skyline.model.EmployeePayment" %>
<%@ page import="com.skyline.model.VendorPayment" %>
<%@ page import="com.skyline.dao.EnquiryDAO" %>
<%@ page import="com.skyline.dao.FollowUpDAO" %>
<%@ page import="com.skyline.dao.LeadDAO" %>
<%@ page import="com.skyline.dao.DayBookDAO" %>
<%@ page import="com.skyline.dao.PettyCashDAO" %>
<%@ page import="com.skyline.dao.EmployeePaymentDAO" %>
<%@ page import="com.skyline.dao.VendorPaymentDAO" %>

<%
if (!"Admin".equals(session.getAttribute("user_type"))) {
response.sendRedirect(request.getContextPath() + "/login.jsp");
return;
}

EnquiryDAO enquiryDAO = new EnquiryDAO();
FollowUpDAO followUpDAO = new FollowUpDAO();
LeadDAO leadDAO = new LeadDAO();
DayBookDAO dayBookDAO = new DayBookDAO();
PettyCashDAO pettyCashDAO = new PettyCashDAO();
EmployeePaymentDAO employeePaymentDAO = new EmployeePaymentDAO();
VendorPaymentDAO vendorPaymentDAO = new VendorPaymentDAO();

//these lists are used to get data from the database and store it in memory
List<Enquiry> enquiries = enquiryDAO.getAllEnquiries();
    List<FollowUp> followUps = followUpDAO.getFollowUps("All", "All", "", "");
        List<Lead> leads = leadDAO.getLeads("All", "All", "All", "", "");
            List<DayBook> dayBooks = dayBookDAO.getAllDayBooks();
                List<PettyCash> pettyCashList = pettyCashDAO.getAllPettyCash();
                    List<EmployeePayment> employeePaymentList = employeePaymentDAO.getAllEmployeePayments();
                        List<VendorPayment> vendorPaymentList = vendorPaymentDAO.getAllVendorPayments();

                            int totalEnquiries = enquiries.size();
                            int totalFollowUps = followUps.size();
                            int totalLeads = leads.size();
                            int totalDayBookEntries = dayBooks.size();
                            int totalPettyCashEntries = pettyCashList.size();

                            double totalDayBookAmount = 0;
                            double totalPettyCashAmount = 0;
                            double totalEmployeePayment = 0;
                            double totalVendorPayment = 0;

                            for (DayBook dayBook : dayBooks) {
                            totalDayBookAmount += dayBook.getAmount();
                            }

                            for (PettyCash pettyCash : pettyCashList) {
                            totalPettyCashAmount += pettyCash.getAmount();
                            }

                            for (EmployeePayment payment : employeePaymentList) {
                            totalEmployeePayment += payment.getAmount();
                            }

                            for (VendorPayment payment : vendorPaymentList) {
                            totalVendorPayment += payment.getAmount();
                            }
                            %>

                            <%@ include file="../Common.jsp" %>

                            <style>
                                .dashboard-header {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    margin-bottom: 25px;
                                }

                                .dashboard-title h2 {
                                    color: #24056f;
                                    font-size: 25px;
                                    font-weight: 600;
                                    margin-bottom: 5px;
                                }

                                .dashboard-title p {
                                    color: #718096;
                                    font-size: 13px;
                                }

                                .dashboard-date {
                                    background: #ffffff;
                                    border: 1px solid #e5e7eb;
                                    border-radius: 8px;
                                    padding: 9px 14px;
                                    color: #6b0b7a;
                                    font-size: 12px;
                                    font-weight: 600;
                                }

                                .dashboard-cards {
                                    display: grid;
                                    grid-template-columns: repeat(4, 1fr); /*4 columns/cards take equal fraction of space */
                                    gap: 15px;
                                    margin-bottom: 25px;
                                }

                                .dashboard-card {
                                    background: #ffffff;
                                    border-radius: 10px;
                                    padding: 18px;
                                    box-shadow: 0 2px 10px rgba(0,0,0,0.06);
                                    border: 1px solid #f0f0f0;
                                    position: relative; /* it makes dashboard card reference for any position: absolute element inside it*/
                                    /* overflow: hidden; makes the content hidden which will go outside the card */
                                }

                                .card-top {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                }

                                .card-icon {
                                    width: 40px;
                                    height: 40px;
                                    color: #24056f;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-size: 18px;
                                }

                                .card-label {
                                    color: #718096;
                                    font-size: 15px;
                                    font-weight: 500;
                                    margin: 5px 0px;
                                }

                                .card-value {
                                    color: #24056f;
                                    font-size: 24px;
                                    font-weight: 700;
                                    margin : 5px 0px;
                                }

                                .card-subtitle {
                                    color: #808fa2;
                                    font-size: 10px;
                                    margin-top: 5px;
                                }

                                .dashboard-main {
                                    gap: 15px;
                                }

                                .dashboard-section {
                                    background: #ffffff;
                                    border-radius: 10px;
                                    padding: 18px;
                                    box-shadow: 0 2px 10px rgba(0,0,0,0.06);
                                }

                                .section-header {
                                    margin-bottom: 18px;
                                }

                                .section-header h3 {
                                    color: #24056f;
                                    font-size: 18px;
                                    font-weight: 600;
                                }

                                .quick-actions {
                                    display: grid;
                                    grid-template-columns: repeat(3,1fr);
                                    gap: 10px;
                                }

                                .quick-action {
                                    display: flex;
                                    align-items: center;
                                    gap: 10px;
                                    padding: 12px;
                                    border: 2px solid #eeeeee;
                                    border-radius: 8px;
                                    text-decoration: none;
                                    color: #303044;
                                    transition: all 0.2s ease;
                                }

                                .quick-action:hover {
                                    border-color: #d62d70;
                                    background: #fff8fb;
                                }

                                .quick-action-icon {
                                    width: 32px;
                                    height: 32px;
                                    border-radius: 7px;
                                    background: #f8eefc;
                                    color: #24056f;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-size: 14px;
                                }

                                .quick-action span {
                                    font-size: 16px;
                                    font-weight: 400;
                                }



                                @media (max-width: 1400px) {
                                    .dashboard-cards {
                                        grid-template-columns: repeat(3, 1fr);
                                    }

                                    .dashboard-main {
                                        grid-template-columns: 1fr;
                                    }
                                }

                                @media (max-width: 700px) {
                                    .dashboard-header {
                                        flex-direction: column;
                                        align-items: flex-start;
                                        gap: 12px;
                                    }

                                    .dashboard-cards {
                                        grid-template-columns: repeat(2, 1fr);
                                    }

                                    .quick-actions {
                                        grid-template-columns: repeat(2, 1fr);
                                    }
                                }

                                @media (max-width: 450px) {
                                    .dashboard-cards {
                                        grid-template-columns: 1fr;
                                    }

                                    .quick-actions {
                                        grid-template-columns: 1fr;
                                    }
                                }
                            </style>

                            <div class="dashboard-header">
                                <div class="dashboard-title">
                                    <h2>Admin Dashboard</h2>
                                </div>

                                <div class="dashboard-date">
                                    <i class="fa fa-calendar"></i>
                                    <%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %>
                                    <!--new java.util.Date(): gets the current date and time-->
                                </div>
                            </div>

                            <div class="dashboard-cards">

                                <div class="dashboard-card">
                                    <div class="card-top">

                                        <div>
                                            <div class="card-label">
                                                Total Enquiries
                                            </div>
                                            <div class="card-value">
                                                <%= totalEnquiries %>
                                            </div>
                                            <div class="card-subtitle">
                                                All enquiry records
                                            </div>
                                        </div>

                                        <div class="card-icon">
                                            <i class="fa fa-bars"></i>
                                        </div>

                                    </div>
                                </div>

                                <div class="dashboard-card">
                                    <div class="card-top">

                                        <div>
                                            <div class="card-label">
                                                Follow Ups
                                            </div>
                                            <div class="card-value">
                                                <%= totalFollowUps %>
                                            </div>
                                            <div class="card-subtitle">
                                                Total follow up records
                                            </div>
                                        </div>

                                        <div class="card-icon">
                                            <i class="fa fa-volume-control-phone"></i>
                                        </div>

                                    </div>
                                </div>

                                <div class="dashboard-card">
                                    <div class="card-top">

                                        <div>
                                            <div class="card-label">
                                                Total Leads
                                            </div>
                                            <div class="card-value">
                                                <%= totalLeads %>
                                            </div>
                                            <div class="card-subtitle">
                                                All lead records
                                            </div>
                                        </div>

                                        <div class="card-icon">
                                            <i class="fa fa-line-chart"></i>
                                        </div>

                                    </div>
                                </div>

                                <div class="dashboard-card">
                                    <div class="card-top">

                                        <div>
                                            <div class="card-label">
                                                Day Book
                                            </div>
                                            <div class="card-value">
                                                <%= totalDayBookEntries %>
                                            </div>
                                            <div class="card-subtitle">
                                                Total transactions
                                            </div>
                                        </div>

                                        <div class="card-icon">
                                            <i class="fa fa-book"></i>
                                        </div>

                                    </div>
                                </div>

                                <div class="dashboard-card">
                                    <div class="card-top">

                                        <div>
                                            <div class="card-label">
                                                Petty Cash
                                            </div>
                                            <div class="card-value">
                                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                                <%= String.format("%.2f", totalPettyCashAmount) %>
                                            </div>
                                            <div class="card-subtitle">
                                                Total petty cash
                                            </div>
                                        </div>

                                        <div class="card-icon">
                                            <i class="fa fa-briefcase"></i>
                                        </div>

                                    </div>
                                </div>

                                <div class="dashboard-card">
                                    <div class="card-top">

                                        <div>
                                            <div class="card-label">
                                                Vendor Payment
                                            </div>
                                            <div class="card-value">
                                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                                <%= String.format("%.2f", totalVendorPayment) %>
                                            </div>
                                            <div class="card-subtitle">
                                                Total vendor payments
                                            </div>
                                        </div>

                                        <div class="card-icon">
                                            <i class="fa fa-credit-card"></i>
                                        </div>

                                    </div>
                                </div>

                                <div class="dashboard-card">
                                    <div class="card-top">

                                        <div>
                                            <div class="card-label">
                                                Employee Payment
                                            </div>
                                            <div class="card-value">
                                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                                <%= String.format("%.2f", totalEmployeePayment) %>
                                            </div>
                                            <div class="card-subtitle">
                                                Total employee payments
                                            </div>
                                        </div>

                                        <div class="card-icon">
                                            <i class="fa fa-users"></i>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="dashboard-main">
                                <div class="dashboard-section">

                                    <div class="section-header">
                                        <h3>Quick Actions</h3>
                                    </div>

                                    <div class="quick-actions">

                                        <a href="<%=request.getContextPath()%>/Admin/AddUser.jsp" class="quick-action">
                                            <div class="quick-action-icon">
                                                <i class="fa fa-user-plus"></i>
                                            </div>
                                            <span>Add User</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/DisplayUser.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-users"></i>
                                            </div>
                                            <span>Display User</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/UpdateUser.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-pencil-square"></i>
                                            </div>
                                            <span>Update User</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/RemoveUser.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-user-minus"></i>
                                            </div>
                                            <span>Remove User</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/AllEnquiry.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-bars"></i>
                                            </div>
                                            <span>All Enquiry</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/FollowUp.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-volume-control-phone"></i>
                                            </div>
                                            <span>Follow Up</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/Lead.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-line-chart"></i>
                                            </div>
                                            <span>Lead</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/DayBook.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-book"></i>
                                            </div>
                                            <span>Day Book</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/PettyCash.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-briefcase"></i>
                                            </div>
                                            <span>Petty Cash</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/VendorPayment.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-credit-card"></i>
                                            </div>
                                            <span>Vendor Payment</span>
                                        </a>

                                        <a href="<%=request.getContextPath()%>/Admin/EmployeePayment.jsp" class="quick-action">

                                            <div class="quick-action-icon">
                                                <i class="fa fa-inr"></i>
                                            </div>
                                            <span>Employee Payment</span>
                                        </a>

                                    </div>
                                </div>


                            </div>

                            </div>
                            </div>
                            </body>
                            </html>