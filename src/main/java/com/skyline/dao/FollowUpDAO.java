package com.skyline.dao;

import com.skyline.model.FollowUp;
import com.skyline.util.DBConnection;

import java.sql.*;
import java.util.*;

public class FollowUpDAO {

    public boolean addFollowUp(FollowUp followUp) {

        String sql = "INSERT INTO follow_ups "
                + "(enquiry_id, customer_name, mobile_no, follow_up_type, "
                + "follow_up_date, status, next_follow_up) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, followUp.getEnquiryId());
            ps.setString(2, followUp.getCustomerName());
            ps.setString(3, followUp.getMobileNo());
            ps.setString(4, followUp.getFollowUpType());
            ps.setDate(5, followUp.getFollowUpDate());
            ps.setString(6, followUp.getStatus());

            if (followUp.getNextFollowUp() != null) {
                ps.setDate(7, followUp.getNextFollowUp());
            } else {
                ps.setNull(7, Types.DATE);
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<FollowUp> getFollowUps(String status,
                                       String followUpType,
                                       String fromDate,
                                       String toDate) {

        List<FollowUp> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM follow_ups WHERE 1=1"
        );

        List<String> parameters = new ArrayList<>();

        if (status != null
                && !status.isEmpty()
                && !status.equals("All")) {

            sql.append(" AND status = ?");
            parameters.add(status);
        }

        if (followUpType != null
                && !followUpType.isEmpty()
                && !followUpType.equals("All")) {

            sql.append(" AND follow_up_type = ?");
            parameters.add(followUpType);
        }

        if (fromDate != null && !fromDate.isEmpty()) {

            sql.append(" AND follow_up_date >= ?");
            parameters.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {

            sql.append(" AND follow_up_date <= ?");
            parameters.add(toDate);
        }

        sql.append(" ORDER BY follow_up_date DESC, id DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ps.setString(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                FollowUp followUp = new FollowUp();

                followUp.setId(rs.getInt("id"));
                followUp.setEnquiryId(rs.getString("enquiry_id"));
                followUp.setCustomerName(rs.getString("customer_name"));
                followUp.setMobileNo(rs.getString("mobile_no"));
                followUp.setFollowUpType(rs.getString("follow_up_type"));
                followUp.setFollowUpDate(
                        rs.getDate("follow_up_date")
                );
                followUp.setStatus(rs.getString("status"));
                followUp.setNextFollowUp(
                        rs.getDate("next_follow_up")
                );

                list.add(followUp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public FollowUp getFollowUpById(int id) {

        String sql = "SELECT * FROM follow_ups WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                FollowUp followUp = new FollowUp();

                followUp.setId(rs.getInt("id"));
                followUp.setEnquiryId(rs.getString("enquiry_id"));
                followUp.setCustomerName(rs.getString("customer_name"));
                followUp.setMobileNo(rs.getString("mobile_no"));
                followUp.setFollowUpType(rs.getString("follow_up_type"));
                followUp.setFollowUpDate(
                        rs.getDate("follow_up_date")
                );
                followUp.setStatus(rs.getString("status"));
                followUp.setNextFollowUp(
                        rs.getDate("next_follow_up")
                );

                return followUp;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean updateFollowUp(FollowUp followUp) {

        String sql = "UPDATE follow_ups SET "
                + "enquiry_id = ?, "
                + "customer_name = ?, "
                + "mobile_no = ?, "
                + "follow_up_type = ?, "
                + "follow_up_date = ?, "
                + "status = ?, "
                + "next_follow_up = ? "
                + "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, followUp.getEnquiryId());
            ps.setString(2, followUp.getCustomerName());
            ps.setString(3, followUp.getMobileNo());
            ps.setString(4, followUp.getFollowUpType());
            ps.setDate(5, followUp.getFollowUpDate());
            ps.setString(6, followUp.getStatus());

            if (followUp.getNextFollowUp() != null) {
                ps.setDate(7, followUp.getNextFollowUp());
            } else {
                ps.setNull(7, Types.DATE);
            }

            ps.setInt(8, followUp.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteFollowUp(int id) {

        String sql = "DELETE FROM follow_ups WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<FollowUp> searchFollowUps(String search) {

        List<FollowUp> list = new ArrayList<>();

        String sql = "SELECT * FROM follow_ups "
                + "WHERE enquiry_id LIKE ? "
                + "OR customer_name LIKE ? "
                + "OR mobile_no LIKE ? "
                + "OR follow_up_type LIKE ? "
                + "OR status LIKE ? "
                + "OR CAST(follow_up_date AS CHAR) LIKE ? "
                + "OR CAST(next_follow_up AS CHAR) LIKE ? "
                + "ORDER BY follow_up_date DESC, id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String value = "%" + search + "%";

            ps.setString(1, value);
            ps.setString(2, value);
            ps.setString(3, value);
            ps.setString(4, value);
            ps.setString(5, value);
            ps.setString(6, value);
            ps.setString(7, value);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                FollowUp followUp = new FollowUp();

                followUp.setId(rs.getInt("id"));
                followUp.setEnquiryId(rs.getString("enquiry_id"));
                followUp.setCustomerName(rs.getString("customer_name"));
                followUp.setMobileNo(rs.getString("mobile_no"));
                followUp.setFollowUpType(rs.getString("follow_up_type"));
                followUp.setFollowUpDate(
                        rs.getDate("follow_up_date")
                );
                followUp.setStatus(rs.getString("status"));
                followUp.setNextFollowUp(
                        rs.getDate("next_follow_up")
                );

                list.add(followUp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}