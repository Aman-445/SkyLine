package com.skyline.model;

import java.sql.Date;

public class VendorPayment {
    private int id;
    private Date paymentDate;
    private String vendorCompanyName;
    private double amount;
    private String paymentMode;
    private String remarks;

    public VendorPayment() {
    }

    public VendorPayment(int id, Date paymentDate, String vendorCompanyName, double amount, String paymentMode, String remarks) {
        this.id = id;
        this.paymentDate = paymentDate;
        this.vendorCompanyName = vendorCompanyName;
        this.amount = amount;
        this.paymentMode = paymentMode;
        this.remarks = remarks;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getVendorCompanyName() {
        return vendorCompanyName;
    }

    public void setVendorCompanyName(String vendorCompanyName) {
        this.vendorCompanyName = vendorCompanyName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}