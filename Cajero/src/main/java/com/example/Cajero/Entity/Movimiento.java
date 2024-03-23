package com.example.Cajero.Entity;

import lombok.Data;

@Data
public class Movimiento {
String cuenta;
String tipoTransaccion;
Double valor;
String fecha;
}
