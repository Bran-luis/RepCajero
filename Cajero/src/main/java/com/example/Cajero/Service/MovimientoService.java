package com.example.Cajero.Service;

import com.example.Cajero.DAO.IMovimientoDao;
import com.example.Cajero.Entity.InicioSeccion;
import com.example.Cajero.Entity.Movimiento;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class MovimientoService implements IMovimientoDao{
    @Autowired
    private IMovimientoDao iMovimientoDao;

    @Override
    public void Movimiento(String noCuenta, String tipoTransaccion, float monto) {
        try {
            iMovimientoDao.Movimiento(noCuenta, tipoTransaccion, monto) ;
        }catch (Exception ex){
            throw ex;
        }
    }
}
