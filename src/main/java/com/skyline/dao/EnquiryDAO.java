package com.skyline.dao;

import com.skyline.model.Enquiry;
import com.skyline.util.DBConnection;
import java.sql.*;
import java.util.*;

public class EnquiryDAO {

    public boolean addEnquiry(Enquiry enquiry) {

        String sql = "INSERT INTO enquiries "
                + "(enquiry_no, enquiry_date, customer_name, mobile, "
                + "preferred_location, no_of_bedrooms, Building_name, budget, "
                + "purpose, flat_type, source, enquiry_type) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, enquiry.getEnquiryNo());
            ps.setDate(2, enquiry.getEnquiryDate());
            ps.setString(3, enquiry.getCustomerName());
            ps.setString(4, enquiry.getMobile());
            ps.setString(5, enquiry.getPreferredLocation());
            ps.setString(6, enquiry.getNoOfBedrooms());
            ps.setString(7, enquiry.getBuildingName());
            ps.setDouble(8, enquiry.getBudget());
            ps.setString(9, enquiry.getPurpose());
            ps.setString(10, enquiry.getFlatType());
            ps.setString(11, enquiry.getSource());
            ps.setString(12, enquiry.getEnquiryType());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Enquiry> getAllEnquiries() {
        List<Enquiry> list = new ArrayList<>();

        String sql = "SELECT * FROM enquiries ORDER BY enquiry_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Enquiry enquiry = new Enquiry();

                enquiry.setEnquiryNo(rs.getString("enquiry_no"));
                enquiry.setEnquiryDate(rs.getDate("enquiry_date"));
                enquiry.setCustomerName(rs.getString("customer_name"));
                enquiry.setMobile(rs.getString("mobile"));
                enquiry.setPreferredLocation(rs.getString("preferred_location"));
                enquiry.setNoOfBedrooms(rs.getString("no_of_bedrooms"));
                enquiry.setBuildingName(rs.getString("Building_name"));
                enquiry.setBudget(rs.getDouble("budget"));
                enquiry.setPurpose(rs.getString("purpose"));
                enquiry.setFlatType(rs.getString("flat_type"));
                enquiry.setSource(rs.getString("source"));
                enquiry.setEnquiryType(rs.getString("enquiry_type"));

                list.add(enquiry);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Enquiry> searchEnquiries(String search) {
        List<Enquiry> list = new ArrayList<>();

        String sql = "SELECT * FROM enquiries "
                + "WHERE enquiry_no LIKE ? "
                + "OR customer_name LIKE ? "
                + "OR mobile LIKE ? "
                + "OR Building_name LIKE ? "
                + "OR preferred_location LIKE ? "
                + "ORDER BY enquiry_date DESC";

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
                Enquiry enquiry = new Enquiry();

                enquiry.setEnquiryNo(rs.getString("enquiry_no"));
                enquiry.setEnquiryDate(rs.getDate("enquiry_date"));
                enquiry.setCustomerName(rs.getString("customer_name"));
                enquiry.setMobile(rs.getString("mobile"));
                enquiry.setPreferredLocation(rs.getString("preferred_location"));
                enquiry.setNoOfBedrooms(rs.getString("no_of_bedrooms"));
                enquiry.setBuildingName(rs.getString("Building_name"));
                enquiry.setBudget(rs.getDouble("budget"));
                enquiry.setPurpose(rs.getString("purpose"));
                enquiry.setFlatType(rs.getString("flat_type"));
                enquiry.setSource(rs.getString("source"));
                enquiry.setEnquiryType(rs.getString("enquiry_type"));

                list.add(enquiry);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Enquiry getEnquiryByNo(String enquiryNo) {
        Enquiry enquiry = null;

        String sql = "SELECT * FROM enquiries WHERE enquiry_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, enquiryNo);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    enquiry = new Enquiry();

                    enquiry.setEnquiryNo(rs.getString("enquiry_no"));
                    enquiry.setEnquiryDate(rs.getDate("enquiry_date"));
                    enquiry.setCustomerName(rs.getString("customer_name"));
                    enquiry.setMobile(rs.getString("mobile"));
                    enquiry.setPreferredLocation(rs.getString("preferred_location"));
                    enquiry.setNoOfBedrooms(rs.getString("no_of_bedrooms"));
                    enquiry.setBuildingName(rs.getString("Building_name"));
                    enquiry.setBudget(rs.getDouble("budget"));
                    enquiry.setPurpose(rs.getString("purpose"));
                    enquiry.setFlatType(rs.getString("flat_type"));
                    enquiry.setSource(rs.getString("source"));
                    enquiry.setEnquiryType(rs.getString("enquiry_type"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return enquiry;
    }

    public boolean updateEnquiry(Enquiry enquiry, String originalEnquiryNo) {
        String sql = "UPDATE enquiries SET enquiry_no = ?, enquiry_date = ?, " +
                "customer_name = ?, mobile = ?, preferred_location = ?, " +
                "no_of_bedrooms = ?, Building_name = ?, budget = ?, " +
                "purpose = ?, flat_type = ?, source = ?, enquiry_type = ? " +
                "WHERE enquiry_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, enquiry.getEnquiryNo());
            ps.setDate(2, enquiry.getEnquiryDate());
            ps.setString(3, enquiry.getCustomerName());
            ps.setString(4, enquiry.getMobile());
            ps.setString(5, enquiry.getPreferredLocation());
            ps.setString(6, enquiry.getNoOfBedrooms());
            ps.setString(7, enquiry.getBuildingName());
            ps.setDouble(8, enquiry.getBudget());
            ps.setString(9, enquiry.getPurpose());
            ps.setString(10, enquiry.getFlatType());
            ps.setString(11, enquiry.getSource());
            ps.setString(12, enquiry.getEnquiryType());
            ps.setString(13, originalEnquiryNo);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEnquiry(String enquiryNo) {
        String sql = "DELETE FROM enquiries WHERE enquiry_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, enquiryNo);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}