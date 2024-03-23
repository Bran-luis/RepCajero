package com.example.Cajero.DAO;

public interface IReporteDineroCajeroDao {
    void ReporteDineroCaja(String noCliente, String pin, int billetesDe100, int billetesDe50);
}
