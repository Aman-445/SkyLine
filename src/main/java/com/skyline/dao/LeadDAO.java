package com.skyline.dao;

import com.skyline.model.Lead;
import com.skyline.util.DBConnection;

import java.sql.*;
import java.util.*;

public class LeadDAO {

    public List<Lead> getLeads(String source,
                               String leadStatus,
                               String assignTo,
                               String fromDate,
                               String toDate) {

        List<Lead> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM leads WHERE 1=1"
        );

        List<String> parameters = new ArrayList<>();

        if (source != null && !source.isEmpty()
                && !source.equals("All")) {

            sql.append(" AND source = ?");
            parameters.add(source);
        }

        if (leadStatus != null && !leadStatus.isEmpty()
                && !leadStatus.equals("All")) {

            sql.append(" AND lead_status = ?");
            parameters.add(leadStatus);
        }

        if (assignTo != null && !assignTo.isEmpty()
                && !assignTo.equals("All")) {

            sql.append(" AND assign_to = ?");
            parameters.add(assignTo);
        }

        if (fromDate != null && !fromDate.isEmpty()) {

            sql.append(" AND created_date >= ?");
            parameters.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {

            sql.append(" AND created_date <= ?");
            parameters.add(toDate);
        }

        sql.append(" ORDER BY created_date DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ps.setString(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Lead lead = new Lead();

                lead.setLeadId(rs.getString("lead_id"));
                lead.setCustomerName(rs.getString("customer_name"));
                lead.setMobileNo(rs.getString("mobile_no"));
                lead.setSource(rs.getString("source"));
                lead.setLeadStatus(rs.getString("lead_status"));
                lead.setAssignTo(rs.getString("assign_to"));
                lead.setCreatedDate(rs.getDate("created_date"));

                list.add(lead);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Lead> searchLeads(String search) {

        List<Lead> list = new ArrayList<>();

        String sql = "SELECT * FROM leads "
                + "WHERE lead_id LIKE ? "
                + "OR customer_name LIKE ? "
                + "OR mobile_no LIKE ? "
                + "OR source LIKE ? "
                + "OR lead_status LIKE ? "
                + "OR assign_to LIKE ? "
                + "ORDER BY created_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String value = "%" + search + "%";

            ps.setString(1, value);
            ps.setString(2, value);
            ps.setString(3, value);
            ps.setString(4, value);
            ps.setString(5, value);
            ps.setString(6, value);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Lead lead = new Lead();

                lead.setLeadId(rs.getString("lead_id"));
                lead.setCustomerName(rs.getString("customer_name"));
                lead.setMobileNo(rs.getString("mobile_no"));
                lead.setSource(rs.getString("source"));
                lead.setLeadStatus(rs.getString("lead_status"));
                lead.setAssignTo(rs.getString("assign_to"));
                lead.setCreatedDate(rs.getDate("created_date"));

                list.add(lead);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean deleteLead(String leadId) {

        String sql = "DELETE FROM leads WHERE lead_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, leadId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addLead(Lead lead) {
        String sql = "INSERT INTO leads "
                + "(lead_id, customer_name, mobile_no, source, lead_status, assign_to, created_date) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, lead.getLeadId());
            ps.setString(2, lead.getCustomerName());
            ps.setString(3, lead.getMobileNo());
            ps.setString(4, lead.getSource());
            ps.setString(5, lead.getLeadStatus());
            ps.setString(6, lead.getAssignTo());
            ps.setDate(7, lead.getCreatedDate());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Lead getLeadById(String leadId) {
        Lead lead = null;

        String sql = "SELECT * FROM leads WHERE lead_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, leadId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                lead = new Lead();

                lead.setLeadId(rs.getString("lead_id"));
                lead.setCustomerName(rs.getString("customer_name"));
                lead.setMobileNo(rs.getString("mobile_no"));
                lead.setSource(rs.getString("source"));
                lead.setLeadStatus(rs.getString("lead_status"));
                lead.setAssignTo(rs.getString("assign_to"));
                lead.setCreatedDate(rs.getDate("created_date"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lead;
    }

    public boolean updateLead(Lead lead) {
        String sql = "UPDATE leads SET "
                + "customer_name = ?, "
                + "mobile_no = ?, "
                + "source = ?, "
                + "lead_status = ?, "
                + "assign_to = ?, "
                + "created_date = ? "
                + "WHERE lead_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, lead.getCustomerName());
            ps.setString(2, lead.getMobileNo());
            ps.setString(3, lead.getSource());
            ps.setString(4, lead.getLeadStatus());
            ps.setString(5, lead.getAssignTo());
            ps.setDate(6, lead.getCreatedDate());
            ps.setString(7, lead.getLeadId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}