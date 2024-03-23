package com.example.Cajero.DAO;

import com.example.Cajero.Entity.ReporteComprobacionSaldos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReporteComprobacionSaldosDao implements IReporteComprobacionSaldosDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    public ReporteComprobacionSaldosDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<ReporteComprobacionSaldos> reporteComprobacionSaldos(String numeroCuenta) {
        String SQL = "exec ReporteComprobacionSaldos ?";
        return jdbcTemplate.query(SQL, new Object[]{numeroCuenta}, new BeanPropertyRowMapper<>(ReporteComprobacionSaldos.class));
    }
}
