package com.example.Cajero.Service;

public interface ITransferirCuentaService {
    void nombre(String noCuenta, String noTelefono, float saldo);

    void tranferirPorCuenta(String noCuenta, String cuentDestino, float saldo);
}
