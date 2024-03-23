package com.example.Cajero.DAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TransferirCuentaDao implements ITransferirCuentaDao{
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void nombre(String noCuenta, String noTelefono, float saldo) {
        String SQL="TransferirPorTelefono, ?,?,?";
        jdbcTemplate.update(SQL,noCuenta,noTelefono,saldo);

    }

    @Override
    public void tranferirPorCuenta(String noCuenta, String cuentDestino, float saldo) {
        String SQL="TransferirPorCuenta, ?,?,?";
        jdbcTemplate.update(SQL,noCuenta,cuentDestino,saldo);
    }
}
