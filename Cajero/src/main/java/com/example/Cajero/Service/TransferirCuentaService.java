package com.example.Cajero.Service;

import com.example.Cajero.DAO.ITransferirCuentaDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TransferirCuentaService implements ITransferirCuentaService{
    @Autowired
    private ITransferirCuentaDao iTransferirCuentaDao;


    @Override
    public void nombre(String noCuenta, String noTelefono, float saldo) {
        try {
            iTransferirCuentaDao.nombre(noCuenta, noTelefono, saldo); ;
        }catch (Exception ex) {
            throw ex;
        }
    }

    @Override
    public void tranferirPorCuenta(String noCuenta, String cuentDestino, float saldo) {
        try {
            iTransferirCuentaDao.tranferirPorCuenta(noCuenta, cuentDestino, saldo); ;
        }catch (Exception ex) {
            throw ex;
        }
    }
}
