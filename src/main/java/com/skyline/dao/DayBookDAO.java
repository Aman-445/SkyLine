package com.skyline.dao;

import com.skyline.model.DayBook;
import com.skyline.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DayBookDAO {

    public boolean addDayBook(DayBook dayBook) {
        String sql = "INSERT INTO day_book (transection_date, particulars, transaction_type, payment_mode, amount) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, dayBook.getTransactionDate());
            ps.setString(2, dayBook.getParticulars());
            ps.setString(3, dayBook.getTransactionType());
            ps.setString(4, dayBook.getPaymentMode());
            ps.setDouble(5, dayBook.getAmount());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<DayBook> getAllDayBooks() {
        List<DayBook> list = new ArrayList<>();

        String sql = "SELECT * FROM day_book ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DayBook dayBook = new DayBook();

                dayBook.setId(rs.getInt("id"));
                dayBook.setTransactionDate(rs.getDate("transection_date"));
                dayBook.setParticulars(rs.getString("particulars"));
                dayBook.setTransactionType(rs.getString("transaction_type"));
                dayBook.setPaymentMode(rs.getString("payment_mode"));
                dayBook.setAmount(rs.getDouble("amount"));

                list.add(dayBook);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public DayBook getDayBookById(int id) {
        DayBook dayBook = null;

        String sql = "SELECT * FROM day_book WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                dayBook = new DayBook();

                dayBook.setId(rs.getInt("id"));
                dayBook.setTransactionDate(rs.getDate("transection_date"));
                dayBook.setParticulars(rs.getString("particulars"));
                dayBook.setTransactionType(rs.getString("transaction_type"));
                dayBook.setPaymentMode(rs.getString("payment_mode"));
                dayBook.setAmount(rs.getDouble("amount"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return dayBook;
    }

    public boolean updateDayBook(DayBook dayBook) {
        String sql = "UPDATE day_book SET transection_date = ?, particulars = ?, transaction_type = ?, payment_mode = ?, amount = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, dayBook.getTransactionDate());
            ps.setString(2, dayBook.getParticulars());
            ps.setString(3, dayBook.getTransactionType());
            ps.setString(4, dayBook.getPaymentMode());
            ps.setDouble(5, dayBook.getAmount());
            ps.setInt(6, dayBook.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteDayBook(int id) {
        String sql = "DELETE FROM day_book WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<DayBook> getFilteredDayBooks(String fromDate, String toDate,
                                             String transactionType, String paymentMode) {

        List<DayBook> list = new ArrayList<>();

        String sql = "SELECT * FROM day_book WHERE 1=1";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND transection_date >= ?";
        }

        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND transection_date <= ?";
        }

        if (transactionType != null && !transactionType.isEmpty()) {
            sql += " AND transaction_type = ?";
        }

        if (paymentMode != null && !paymentMode.isEmpty()) {
            sql += " AND payment_mode = ?";
        }

        sql += " ORDER BY transection_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int index = 1;

            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(index++, java.sql.Date.valueOf(fromDate));
            }

            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(index++, java.sql.Date.valueOf(toDate));
            }

            if (transactionType != null && !transactionType.isEmpty()) {
                ps.setString(index++, transactionType);
            }

            if (paymentMode != null && !paymentMode.isEmpty()) {
                ps.setString(index++, paymentMode);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DayBook dayBook = new DayBook();

                dayBook.setId(rs.getInt("id"));
                dayBook.setTransactionDate(rs.getDate("transection_date"));
                dayBook.setParticulars(rs.getString("particulars"));
                dayBook.setTransactionType(rs.getString("transaction_type"));
                dayBook.setPaymentMode(rs.getString("payment_mode"));
                dayBook.setAmount(rs.getDouble("amount"));

                list.add(dayBook);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<DayBook> searchDayBooks(String search) {

        List<DayBook> list = new ArrayList<>();

        String sql = "SELECT * FROM day_book "
                + "WHERE particulars LIKE ? "
                + "OR transaction_type LIKE ? "
                + "OR payment_mode LIKE ? "
                + "OR transection_date LIKE ? "
                + "ORDER BY transection_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String value = "%" + search + "%";

            ps.setString(1, value);
            ps.setString(2, value);
            ps.setString(3, value);
            ps.setString(4, value);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                DayBook dayBook = new DayBook();

                dayBook.setId(rs.getInt("id"));
                dayBook.setTransactionDate(rs.getDate("transection_date"));
                dayBook.setParticulars(rs.getString("particulars"));
                dayBook.setTransactionType(rs.getString("transaction_type"));
                dayBook.setPaymentMode(rs.getString("payment_mode"));
                dayBook.setAmount(rs.getDouble("amount"));

                list.add(dayBook);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}