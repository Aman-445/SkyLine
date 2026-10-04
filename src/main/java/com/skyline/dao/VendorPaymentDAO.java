package com.skyline.dao;

import com.skyline.model.VendorPayment;
import com.skyline.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VendorPaymentDAO {
    public boolean addVendorPayment(VendorPayment payment) {
        String sql = "INSERT INTO vendor_payments (payment_date, vendor_company_name, amount, payment_mode, remarks) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, payment.getPaymentDate());
            ps.setString(2, payment.getVendorCompanyName());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, payment.getPaymentMode());
            ps.setString(5, payment.getRemarks());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<VendorPayment> getAllVendorPayments() {
        List<VendorPayment> list = new ArrayList<>();
        String sql = "SELECT * FROM vendor_payments ORDER BY payment_date DESC, id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                VendorPayment payment = new VendorPayment();
                payment.setId(rs.getInt("id"));
                payment.setPaymentDate(rs.getDate("payment_date"));
                payment.setVendorCompanyName(rs.getString("vendor_company_name"));
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

    public boolean deleteVendorPayment(int id) {
        String sql = "DELETE FROM vendor_payments WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public VendorPayment getVendorPaymentById(int id) {
        VendorPayment payment = null;

        String sql = "SELECT * FROM vendor_payments WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                payment = new VendorPayment();

                payment.setId(rs.getInt("id"));
                payment.setPaymentDate(rs.getDate("payment_date"));
                payment.setVendorCompanyName(rs.getString("vendor_company_name"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentMode(rs.getString("payment_mode"));
                payment.setRemarks(rs.getString("remarks"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return payment;
    }


    public boolean updateVendorPayment(VendorPayment payment) {

        String sql = "UPDATE vendor_payments SET " + "payment_date = ?, " + "vendor_company_name = ?, " + "amount = ?, "
                + "payment_mode = ?, " + "remarks = ? " + "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, payment.getPaymentDate());
            ps.setString(2, payment.getVendorCompanyName());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, payment.getPaymentMode());
            ps.setString(5, payment.getRemarks());
            ps.setInt(6, payment.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<VendorPayment> searchVendorPayments(String search) {
        List<VendorPayment> list = new ArrayList<>();

        String sql = "SELECT * FROM vendor_payments " + "WHERE vendor_company_name LIKE ? " + "OR payment_mode LIKE ? "
                + "OR remarks LIKE ? " + "OR payment_date LIKE ? " + "ORDER BY payment_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String value = "%" + search + "%";

            ps.setString(1, value);
            ps.setString(2, value);
            ps.setString(3, value);
            ps.setString(4, value);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                VendorPayment payment = new VendorPayment();

                payment.setId(rs.getInt("id"));
                payment.setPaymentDate(rs.getDate("payment_date"));
                payment.setVendorCompanyName(rs.getString("vendor_company_name"));
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