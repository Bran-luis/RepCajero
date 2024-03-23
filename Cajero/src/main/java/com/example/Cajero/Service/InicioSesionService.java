package com.example.Cajero.Service;

import com.example.Cajero.DAO.IInicioSesionDao;
import com.example.Cajero.DAO.InicioSeccionDao;
import com.example.Cajero.Entity.AccesAdmin;
import com.example.Cajero.Entity.InicioSeccion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InicioSesionService implements IInicioSesionService{
    @Autowired
    private IInicioSesionDao iInicioSesionDao;

    @Override
    public List<InicioSeccion> inicioSeccion(String cuenta, String pin) {
        List<InicioSeccion> iniciouse;
        try {
            iniciouse = iInicioSesionDao.inicioSeccion(cuenta,pin);
        }catch (Exception ex){
            throw ex;
        }
        return iniciouse;
    }
}
