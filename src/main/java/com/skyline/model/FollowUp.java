package com.skyline.model;

import java.sql.Date;

public class FollowUp {

    private int id;
    private String enquiryId;
    private String customerName;
    private String mobileNo;
    private String followUpType;
    private Date followUpDate;
    private String status;
    private Date nextFollowUp;

    public FollowUp() {
    }

    public FollowUp(int id, String enquiryId, String customerName,
                    String mobileNo, String followUpType,
                    Date followUpDate, String status,
                    Date nextFollowUp) {

        this.id = id;
        this.enquiryId = enquiryId;
        this.customerName = customerName;
        this.mobileNo = mobileNo;
        this.followUpType = followUpType;
        this.followUpDate = followUpDate;
        this.status = status;
        this.nextFollowUp = nextFollowUp;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEnquiryId() {
        return enquiryId;
    }

    public void setEnquiryId(String enquiryId) {
        this.enquiryId = enquiryId;
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

    public String getFollowUpType() {
        return followUpType;
    }

    public void setFollowUpType(String followUpType) {
        this.followUpType = followUpType;
    }

    public Date getFollowUpDate() {
        return followUpDate;
    }

    public void setFollowUpDate(Date followUpDate) {
        this.followUpDate = followUpDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getNextFollowUp() {
        return nextFollowUp;
    }

    public void setNextFollowUp(Date nextFollowUp) {
        this.nextFollowUp = nextFollowUp;
    }
}