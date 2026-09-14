package com.skyline.dao;

import com.skyline.model.FlatSale;
import com.skyline.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FlatSaleDAO {
    public boolean addFlatSale(FlatSale sale) {
        String sql = "INSERT INTO flat_sales (sale_date, customer_name, mobile_no, building_name, falt_no, sale_amount, booking_amount, payment_mode, remarka) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, sale.getSaleDate());
            ps.setString(2, sale.getCustomerName());
            ps.setString(3, sale.getMobileNo());
            ps.setString(4, sale.getBuildingName());
            ps.setString(5, sale.getFaltNo());
            ps.setDouble(6, sale.getSaleAmount());
            ps.setDouble(7, sale.getBookingAmount());
            ps.setString(8, sale.getPaymentMode());
            ps.setString(9, sale.getRemarka());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<FlatSale> getAllFlatSales() {
        List<FlatSale> list = new ArrayList<>();
        String sql = "SELECT * FROM flat_sales ORDER BY sale_date DESC, id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                FlatSale sale = new FlatSale();
                sale.setId(rs.getInt("id"));
                sale.setSaleDate(rs.getDate("sale_date"));
                sale.setCustomerName(rs.getString("customer_name"));
                sale.setMobileNo(rs.getString("mobile_no"));
                sale.setBuildingName(rs.getString("building_name"));
                sale.setFaltNo(rs.getString("falt_no"));
                sale.setSaleAmount(rs.getDouble("sale_amount"));
                sale.setBookingAmount(rs.getDouble("booking_amount"));
                sale.setPaymentMode(rs.getString("payment_mode"));
                sale.setRemarka(rs.getString("remarka"));
                list.add(sale);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteFlatSale(int id) {
        String sql = "DELETE FROM flat_sales WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public FlatSale getFlatSaleById(int id) {

        FlatSale sale = null;

        String sql = "SELECT * FROM flat_sales WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                sale = new FlatSale();

                sale.setId(rs.getInt("id"));
                sale.setSaleDate(rs.getDate("sale_date"));
                sale.setCustomerName(rs.getString("customer_name"));
                sale.setMobileNo(rs.getString("mobile_no"));
                sale.setBuildingName(rs.getString("building_name"));
                sale.setFaltNo(rs.getString("falt_no"));
                sale.setSaleAmount(rs.getDouble("sale_amount"));
                sale.setBookingAmount(rs.getDouble("booking_amount"));
                sale.setPaymentMode(rs.getString("payment_mode"));
                sale.setRemarka(rs.getString("remarka"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return sale;
    }

    public boolean updateFlatSale(FlatSale sale) {

        String sql = "UPDATE flat_sales SET "
                + "sale_date = ?, "
                + "customer_name = ?, "
                + "mobile_no = ?, "
                + "building_name = ?, "
                + "falt_no = ?, "
                + "sale_amount = ?, "
                + "booking_amount = ?, "
                + "payment_mode = ?, "
                + "remarka = ? "
                + "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, sale.getSaleDate());
            ps.setString(2, sale.getCustomerName());
            ps.setString(3, sale.getMobileNo());
            ps.setString(4, sale.getBuildingName());
            ps.setString(5, sale.getFaltNo());
            ps.setDouble(6, sale.getSaleAmount());
            ps.setDouble(7, sale.getBookingAmount());
            ps.setString(8, sale.getPaymentMode());
            ps.setString(9, sale.getRemarka());
            ps.setInt(10, sale.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}