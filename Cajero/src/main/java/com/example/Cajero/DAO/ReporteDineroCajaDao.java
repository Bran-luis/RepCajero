package com.example.Cajero.DAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReporteDineroCajaDao implements IReporteDineroCajeroDao{
    @Autowired
    private JdbcTemplate jdbcTemplate;
    public ReporteDineroCajaDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    @Override
    public void ReporteDineroCaja(String noCliente, String pin, int billetesDe100, int billetesDe50) {
        String SQL="exec ReponerDineroCajero ?,?,?,?";
        jdbcTemplate.update(SQL, noCliente, pin, billetesDe100, billetesDe50);
    }
}
