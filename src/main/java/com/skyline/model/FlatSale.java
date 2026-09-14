package com.skyline.model;

import java.sql.Date;

public class FlatSale {
    private int id;
    private Date saleDate;
    private String customerName;
    private String mobileNo;
    private String buildingName;
    private String faltNo;
    private double saleAmount;
    private double bookingAmount;
    private String paymentMode;
    private String remarka;

    public FlatSale() {
    }

    public FlatSale(int id, Date saleDate, String customerName, String mobileNo, String buildingName, String faltNo, double saleAmount, double bookingAmount, String paymentMode, String remarka) {
        this.id = id;
        this.saleDate = saleDate;
        this.customerName = customerName;
        this.mobileNo = mobileNo;
        this.buildingName = buildingName;
        this.faltNo = faltNo;
        this.saleAmount = saleAmount;
        this.bookingAmount = bookingAmount;
        this.paymentMode = paymentMode;
        this.remarka = remarka;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
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

    public String getBuildingName() {
        return buildingName;
    }

    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    public String getFaltNo() {
        return faltNo;
    }

    public void setFaltNo(String faltNo) {
        this.faltNo = faltNo;
    }

    public double getSaleAmount() {
        return saleAmount;
    }

    public void setSaleAmount(double saleAmount) {
        this.saleAmount = saleAmount;
    }

    public double getBookingAmount() {
        return bookingAmount;
    }

    public void setBookingAmount(double bookingAmount) {
        this.bookingAmount = bookingAmount;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public String getRemarka() {
        return remarka;
    }

    public void setRemarka(String remarka) {
        this.remarka = remarka;
    }
}