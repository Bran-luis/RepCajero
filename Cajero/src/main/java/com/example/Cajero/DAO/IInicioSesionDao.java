package com.example.Cajero.DAO;

import com.example.Cajero.Entity.InicioSeccion;

import java.util.List;


public interface IInicioSesionDao {
    List<InicioSeccion> inicioSeccion(String cuenta, String pin);

}
