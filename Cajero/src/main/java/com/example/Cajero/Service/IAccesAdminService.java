package com.example.Cajero.Service;

import com.example.Cajero.Entity.AccesAdmin;

import java.util.List;

public interface IAccesAdminService {
    List<AccesAdmin> inicioSesion(String nombreCliente, String pin);
}
