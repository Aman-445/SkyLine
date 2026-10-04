package com.skyline.model;

import java.sql.Date;

public class Enquiry {

    private String enquiryNo;
    private Date enquiryDate;
    private String customerName;
    private String mobile;
    private String preferredLocation;
    private String noOfBedrooms;
    private String buildingName;
    private double budget;
    private String purpose;
    private String flatType;
    private String source;
    private String enquiryType;

    public Enquiry() {
    }

    public Enquiry(String enquiryNo, Date enquiryDate, String customerName, String mobile, String preferredLocation,
                   String noOfBedrooms, String buildingName, double budget, String purpose, String flatType,
                   String source, String enquiryType) {

        this.enquiryNo = enquiryNo;
        this.enquiryDate = enquiryDate;
        this.customerName = customerName;
        this.mobile = mobile;
        this.preferredLocation = preferredLocation;
        this.noOfBedrooms = noOfBedrooms;
        this.buildingName = buildingName;
        this.budget = budget;
        this.purpose = purpose;
        this.flatType = flatType;
        this.source = source;
        this.enquiryType = enquiryType;
    }

    public String getEnquiryNo() {
        return enquiryNo;
    }

    public void setEnquiryNo(String enquiryNo) {
        this.enquiryNo = enquiryNo;
    }

    public Date getEnquiryDate() {
        return enquiryDate;
    }

    public void setEnquiryDate(Date enquiryDate) {
        this.enquiryDate = enquiryDate;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPreferredLocation() {
        return preferredLocation;
    }

    public void setPreferredLocation(String preferredLocation) {
        this.preferredLocation = preferredLocation;
    }

    public String getNoOfBedrooms() {
        return noOfBedrooms;
    }

    public void setNoOfBedrooms(String noOfBedrooms) {
        this.noOfBedrooms = noOfBedrooms;
    }

    public String getBuildingName() {
        return buildingName;
    }

    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    public double getBudget() {
        return budget;
    }

    public void setBudget(double budget) {
        this.budget = budget;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public String getFlatType() {
        return flatType;
    }

    public void setFlatType(String flatType) {
        this.flatType = flatType;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getEnquiryType() {
        return enquiryType;
    }

    public void setEnquiryType(String enquiryType) {
        this.enquiryType = enquiryType;
    }
}