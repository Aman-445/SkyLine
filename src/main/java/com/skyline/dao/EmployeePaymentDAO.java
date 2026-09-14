package com.skyline.dao;

import com.skyline.model.EmployeePayment;
import com.skyline.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EmployeePaymentDAO {
    public boolean addEmployeePayment(EmployeePayment payment) {
        String sql = "INSERT INTO employee_payments (payment_date, employee_name, amount, payment_mode, remarks) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, payment.getPaymentDate());
            ps.setString(2, payment.getEmployeeName());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, payment.getPaymentMode());
            ps.setString(5, payment.getRemarks());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<EmployeePayment> getAllEmployeePayments() {
        List<EmployeePayment> list = new ArrayList<>();
        String sql = "SELECT * FROM employee_payments ORDER BY payment_date DESC, id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                EmployeePayment payment = new EmployeePayment();
                payment.setId(rs.getInt("id"));
                payment.setPaymentDate(rs.getDate("payment_date"));
                payment.setEmployeeName(rs.getString("employee_name"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentMode(rs.getString("payment_mode"));
                payment.setRemarks(rs.getString("remarks"));
                list.add(payment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteEmployeePayment(int id) {
        String sql = "DELETE FROM employee_payments WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public EmployeePayment getEmployeePaymentById(int id) {
        EmployeePayment payment = null;

        String sql = "SELECT * FROM employee_payments WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                payment = new EmployeePayment();

                payment.setId(rs.getInt("id"));
                payment.setPaymentDate(rs.getDate("payment_date"));
                payment.setEmployeeName(rs.getString("employee_name"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentMode(rs.getString("payment_mode"));
                payment.setRemarks(rs.getString("remarks"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return payment;
    }

    public boolean updateEmployeePayment(EmployeePayment payment) {

        String sql = "UPDATE employee_payments SET "
                + "payment_date = ?, "
                + "employee_name = ?, "
                + "amount = ?, "
                + "payment_mode = ?, "
                + "remarks = ? "
                + "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, payment.getPaymentDate());
            ps.setString(2, payment.getEmployeeName());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, payment.getPaymentMode());
            ps.setString(5, payment.getRemarks());
            ps.setInt(6, payment.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<EmployeePayment> searchEmployeePayments(String search) {

        List<EmployeePayment> list = new ArrayList<>();

        String sql = "SELECT * FROM employee_payments "
                + "WHERE employee_name LIKE ? "
                + "OR payment_mode LIKE ? "
                + "OR remarks LIKE ? "
                + "OR payment_date LIKE ? "
                + "ORDER BY payment_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String value = "%" + search + "%";

            ps.setString(1, value);
            ps.setString(2, value);
            ps.setString(3, value);
            ps.setString(4, value);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                EmployeePayment payment = new EmployeePayment();

                payment.setId(rs.getInt("id"));
                payment.setPaymentDate(rs.getDate("payment_date"));
                payment.setEmployeeName(rs.getString("employee_name"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentMode(rs.getString("payment_mode"));
                payment.setRemarks(rs.getString("remarks"));

                list.add(payment);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}