package com.example.Cajero.DAO;

import com.example.Cajero.Entity.InicioSeccion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class InicioSeccionDao implements IInicioSesionDao{
    @Autowired
    private JdbcTemplate jdbcTemplate;
    public InicioSeccionDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    @Override
    public List<InicioSeccion> inicioSeccion(String cuenta, String pin) {
        String SQL="exec inicioSeccion ?,?";
        return jdbcTemplate.query(SQL, new Object[]{cuenta,pin}, new BeanPropertyRowMapper<>(InicioSeccion.class));
    }
}
