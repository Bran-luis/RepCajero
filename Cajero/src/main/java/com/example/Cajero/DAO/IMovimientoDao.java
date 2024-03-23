package com.example.Cajero.DAO;

public interface IMovimientoDao {
    void Movimiento(String noCuenta, String tipoTransaccion, float monto);

}
