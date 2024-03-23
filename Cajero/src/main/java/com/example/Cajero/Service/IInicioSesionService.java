package com.example.Cajero.Service;

import com.example.Cajero.Entity.InicioSeccion;

import java.util.List;

public interface IInicioSesionService {
    List<InicioSeccion> inicioSeccion(String cuenta, String pin);
}
