package com.example.Cajero.Service;

import com.example.Cajero.DAO.IReporteComprobacionSaldosDao;
import com.example.Cajero.Entity.ReporteComprobacionSaldos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReporteComprobacionSaldosService implements IReporteComprobacionSaldosService{
    @Autowired
    private IReporteComprobacionSaldosDao iReporteComprobacionSaldosDao;
    @Override
    public List<ReporteComprobacionSaldos> reporteComprobacionSaldos(String numeroCuenta) {
        try {
            iReporteComprobacionSaldosDao.reporteComprobacionSaldos(numeroCuenta); ;
        }catch (Exception ex) {
            throw ex;
        }
        return null;
    }
}
