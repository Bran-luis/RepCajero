package com.example.Cajero.Service;

import com.example.Cajero.Entity.ReporteComprobacionSaldos;

import java.util.List;

public interface IReporteComprobacionSaldosService {
    List<ReporteComprobacionSaldos> reporteComprobacionSaldos(String numeroCuenta);
}
