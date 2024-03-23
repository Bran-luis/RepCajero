package com.example.Cajero.Service;

import com.example.Cajero.DAO.IInicioSesionDao;
import com.example.Cajero.DAO.IReporteDineroCajeroDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReporteDineroCajaService implements IReporteDineroCajaService{
    @Autowired
    private IReporteDineroCajeroDao iReporteDineroCajeroDao;
    @Override
    public void ReporteDineroCaja(String noCliente, String pin, int billetesDe100, int billetesDe50) {
        try {
            iReporteDineroCajeroDao.ReporteDineroCaja(noCliente, pin, billetesDe100, billetesDe50); ;
        }catch (Exception ex) {
            throw ex;
        }
    }
}
