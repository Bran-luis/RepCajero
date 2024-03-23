package com.example.Cajero.DAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MovimientoDao implements IMovimientoDao{
    @Autowired
    private JdbcTemplate jdbcTemplate;
    public MovimientoDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    @Override
    public void Movimiento(String noCuenta, String tipoTransaccion, float monto) {
        String SQL="exec Movimiento ?,?,?";
        jdbcTemplate.update(SQL, noCuenta, tipoTransaccion, monto);


    }
}
