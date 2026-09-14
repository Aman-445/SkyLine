package com.skyline.model;

import java.sql.Date;

public class DayBook {
    private int id;
    private Date transactionDate;
    private String particulars;
    private String transactionType;
    private String paymentMode;
    private double amount;

    public DayBook() {
    }

    public DayBook(int id, Date transactionDate, String particulars, String transactionType, String paymentMode, double amount) {
        this.id = id;
        this.transactionDate = transactionDate;
        this.particulars = particulars;
        this.transactionType = transactionType;
        this.paymentMode = paymentMode;
        this.amount = amount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getParticulars() {
        return particulars;
    }

    public void setParticulars(String particulars) {
        this.particulars = particulars;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
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
}