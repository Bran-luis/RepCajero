package com.example.Cajero.Entity;

import lombok.Data;

@Data
public class SaldoCajero {
    String cantidad;
    int billetesDe100;
    int billetesDe50;
}
