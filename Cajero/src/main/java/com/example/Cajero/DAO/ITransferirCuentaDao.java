package com.example.Cajero.DAO;

public interface ITransferirCuentaDao {
    void nombre(String noCuenta, String noTelefono, float saldo);
    void tranferirPorCuenta(String noCuenta, String cuentDestino, float saldo);
}
