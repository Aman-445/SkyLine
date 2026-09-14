package com.skyline.util;

import java.sql.*;

public class DBConnection {
    // Update the password if your MySQL Workbench uses something other than "root"
    private static final String URL = "jdbc:mysql://localhost:3306/skyline_crm";
    private static final String USER = "root";
    private static final String PASSWORD = "Aman@1813";

    // A quick main method just to test the connection directly
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }


    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            if (conn != null) {
                System.out.println("Skyline CRM Database connected successfully!");
                conn.close();
            } else {
                System.out.println("Failed to connect to the database.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}