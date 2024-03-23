package com.example.Cajero.DAO;

import com.example.Cajero.Entity.ReporteComprobacionSaldos;

import java.util.List;

public interface IReporteComprobacionSaldosDao {

    List<ReporteComprobacionSaldos> reporteComprobacionSaldos( String numeroCuenta);
}
