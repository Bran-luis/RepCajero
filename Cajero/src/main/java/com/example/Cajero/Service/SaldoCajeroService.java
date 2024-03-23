package com.example.Cajero.Service;

import com.example.Cajero.DAO.ISaldoCajeroDao;
import com.example.Cajero.Entity.InicioSeccion;
import com.example.Cajero.Entity.SaldoCajero;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SaldoCajeroService implements ISaldoCajeroService{
    @Autowired
    private ISaldoCajeroDao iSaldoCajeroDao;
    @Override
    public List<SaldoCajero> nombre() {
        List<SaldoCajero> saldoCajero;
        try {
            saldoCajero = iSaldoCajeroDao.nombre();
        }catch (Exception ex){
            throw ex;
        }
        return saldoCajero;
    }

}
