package com.skyline.model;

public class User {
    private int id;
    private String username;
    private String password;
    private String userType;
    private String fullName;
    private String mobile;
    private String status;

    public User() {
    }

    public User(int id, String username, String password, String userType, String fullName, String mobile, String status) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.userType = userType;
        this.fullName = fullName;
        this.mobile = mobile;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}