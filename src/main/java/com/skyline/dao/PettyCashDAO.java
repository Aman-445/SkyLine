package com.skyline.dao;

import com.skyline.model.PettyCash;
import com.skyline.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PettyCashDAO {
    public boolean addPettyCash(PettyCash pettyCash) {
        String sql = "INSERT INTO petty_cash (voucher_no, entry_date, particulars, category, payment_mode, amount, remarks) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pettyCash.getVoucherNo());
            ps.setDate(2, pettyCash.getEntryDate());
            ps.setString(3, pettyCash.getParticulars());
            ps.setString(4, pettyCash.getCategory());
            ps.setString(5, pettyCash.getPaymentMode());
            ps.setDouble(6, pettyCash.getAmount());
            ps.setString(7, pettyCash.getRemarks());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<PettyCash> getAllPettyCash() {
        List<PettyCash> list = new ArrayList<>();
        String sql = "SELECT * FROM petty_cash ORDER BY entry_date DESC, id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                PettyCash pettyCash = new PettyCash();
                pettyCash.setId(rs.getInt("id"));
                pettyCash.setVoucherNo(rs.getString("voucher_no"));
                pettyCash.setEntryDate(rs.getDate("entry_date"));
                pettyCash.setParticulars(rs.getString("particulars"));
                pettyCash.setCategory(rs.getString("category"));
                pettyCash.setPaymentMode(rs.getString("payment_mode"));
                pettyCash.setAmount(rs.getDouble("amount"));
                pettyCash.setRemarks(rs.getString("remarks"));
                list.add(pettyCash);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deletePettyCash(int id) {
        String sql = "DELETE FROM petty_cash WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public PettyCash getPettyCashById(int id) {
        PettyCash pettyCash = null;

        String sql = "SELECT * FROM petty_cash WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                pettyCash = new PettyCash();

                pettyCash.setId(rs.getInt("id"));
                pettyCash.setVoucherNo(rs.getString("voucher_no"));
                pettyCash.setEntryDate(rs.getDate("entry_date"));
                pettyCash.setParticulars(rs.getString("particulars"));
                pettyCash.setCategory(rs.getString("category"));
                pettyCash.setPaymentMode(rs.getString("payment_mode"));
                pettyCash.setAmount(rs.getDouble("amount"));
                pettyCash.setRemarks(rs.getString("remarks"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pettyCash;
    }


    public boolean updatePettyCash(PettyCash pettyCash) {

        String sql = "UPDATE petty_cash SET " + "voucher_no = ?, " + "entry_date = ?, " + "particulars = ?, "
                + "category = ?, " + "payment_mode = ?, " + "amount = ?, " + "remarks = ? " + "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, pettyCash.getVoucherNo());
            ps.setDate(2, pettyCash.getEntryDate());
            ps.setString(3, pettyCash.getParticulars());
            ps.setString(4, pettyCash.getCategory());
            ps.setString(5, pettyCash.getPaymentMode());
            ps.setDouble(6, pettyCash.getAmount());
            ps.setString(7, pettyCash.getRemarks());
            ps.setInt(8, pettyCash.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public List<PettyCash> searchPettyCash(String search) {

        List<PettyCash> list = new ArrayList<>();

        String sql = "SELECT * FROM petty_cash " + "WHERE voucher_no LIKE ? " + "OR particulars LIKE ? " + "OR category LIKE ? "
                + "OR payment_mode LIKE ? " + "OR remarks LIKE ? " + "ORDER BY entry_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String value = "%" + search + "%";

            ps.setString(1, value);
            ps.setString(2, value);
            ps.setString(3, value);
            ps.setString(4, value);
            ps.setString(5, value);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PettyCash pettyCash = new PettyCash();

                pettyCash.setId(rs.getInt("id"));
                pettyCash.setVoucherNo(rs.getString("voucher_no"));
                pettyCash.setEntryDate(rs.getDate("entry_date"));
                pettyCash.setParticulars(rs.getString("particulars"));
                pettyCash.setCategory(rs.getString("category"));
                pettyCash.setPaymentMode(rs.getString("payment_mode"));
                pettyCash.setAmount(rs.getDouble("amount"));
                pettyCash.setRemarks(rs.getString("remarks"));

                list.add(pettyCash);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}