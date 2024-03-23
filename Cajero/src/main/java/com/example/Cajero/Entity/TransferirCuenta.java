package com.example.Cajero.Entity;

import lombok.Data;

@Data
public class TransferirCuenta {
     String cuentaOrigen;
     String cuentaDestino;
     double saldoTransferencia;
}
