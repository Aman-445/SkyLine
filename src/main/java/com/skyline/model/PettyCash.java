package com.skyline.model;

import java.sql.Date;

public class PettyCash {
    private int id;
    private String voucherNo;
    private Date entryDate;
    private String particulars;
    private String category;
    private String paymentMode;
    private double amount;
    private String remarks;

    public PettyCash() {
    }

    public PettyCash(int id, String voucherNo, Date entryDate, String particulars, String category, String paymentMode, double amount, String remarks) {
        this.id = id;
        this.voucherNo = voucherNo;
        this.entryDate = entryDate;
        this.particulars = particulars;
        this.category = category;
        this.paymentMode = paymentMode;
        this.amount = amount;
        this.remarks = remarks;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVoucherNo() {
        return voucherNo;
    }

    public void setVoucherNo(String voucherNo) {
        this.voucherNo = voucherNo;
    }

    public Date getEntryDate() {
        return entryDate;
    }

    public void setEntryDate(Date entryDate) {
        this.entryDate = entryDate;
    }

    public String getParticulars() {
        return particulars;
    }

    public void setParticulars(String particulars) {
        this.particulars = particulars;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}