package com.example.Cajero.DAO;

import com.example.Cajero.Entity.AccesAdmin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class AccesAdminDao implements IAccesAdminDao{
    @Autowired
    private JdbcTemplate jdbcTemplate;
    public AccesAdminDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    @Override
    public List<AccesAdmin> inicioSesion(String nombreCliente, String pin) {
        String SQL="exec accesAdmin ?,?";
        return jdbcTemplate.query(SQL, new Object[]{nombreCliente,pin}, new BeanPropertyRowMapper<>(AccesAdmin.class));
    }
}
