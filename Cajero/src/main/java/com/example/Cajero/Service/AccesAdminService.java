package com.example.Cajero.Service;

import com.example.Cajero.DAO.IAccesAdminDao;
import com.example.Cajero.Entity.AccesAdmin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccesAdminService implements IAccesAdminService {
    @Autowired
    private IAccesAdminDao iAccesAdminDao;
    @Override
    public List<AccesAdmin> inicioSesion(String nombreCliente, String pin) {
        List<AccesAdmin> inicio;
        try {
            inicio = iAccesAdminDao.inicioSesion(nombreCliente,pin);
        }catch (Exception ex){
            throw ex;
        }
        return inicio;
    }
}
