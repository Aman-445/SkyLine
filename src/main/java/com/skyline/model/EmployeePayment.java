package com.skyline.model;

import java.sql.Date;

public class  EmployeePayment{
    private int id;
    private Date paymentDate;
    private String employeeName;
    private double amount;
    private String paymentMode;
    private String remarks;

    public EmployeePayment() {
    }

    public EmployeePayment(int id, Date paymentDate, String employeeName, double amount, String paymentMode, String remarks) {
        this.id = id;
        this.paymentDate = paymentDate;
        this.employeeName = employeeName;
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

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
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