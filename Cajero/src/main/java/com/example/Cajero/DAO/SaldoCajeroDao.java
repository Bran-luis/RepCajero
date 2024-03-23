package com.example.Cajero.DAO;

import com.example.Cajero.Entity.SaldoCajero;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SaldoCajeroDao implements ISaldoCajeroDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    public SaldoCajeroDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    @Override
    public List<SaldoCajero> nombre() {
        String SQL="exec SaldoCajero";
        return jdbcTemplate.query(SQL, BeanPropertyRowMapper.newInstance(SaldoCajero.class));
    }
}
