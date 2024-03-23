package com.example.Cajero.Entity;

import lombok.Data;

@Data
public class ReporteComprobacionSaldos {
    String noCuenta;
    String pinCliente;
    int billetesDe100;
    int billetesDe50;

    String saldoCuenta;
    String saldoTransaccion;
}
