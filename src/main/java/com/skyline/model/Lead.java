package com.skyline.model;

import java.sql.Date;

public class Lead {

    private String leadId;
    private String customerName;
    private String mobileNo;
    private String source;
    private String leadStatus;
    private String assignTo;
    private Date createdDate;

    public Lead() {
    }

    public Lead(String leadId, String customerName, String mobileNo,
                String source, String leadStatus, String assignTo,
                Date createdDate) {

        this.leadId = leadId;
        this.customerName = customerName;
        this.mobileNo = mobileNo;
        this.source = source;
        this.leadStatus = leadStatus;
        this.assignTo = assignTo;
        this.createdDate = createdDate;
    }

    public String getLeadId() {
        return leadId;
    }

    public void setLeadId(String leadId) {
        this.leadId = leadId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getMobileNo() {
        return mobileNo;
    }

    public void setMobileNo(String mobileNo) {
        this.mobileNo = mobileNo;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getLeadStatus() {
        return leadStatus;
    }

    public void setLeadStatus(String leadStatus) {
        this.leadStatus = leadStatus;
    }

    public String getAssignTo() {
        return assignTo;
    }

    public void setAssignTo(String assignTo) {
        this.assignTo = assignTo;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
}