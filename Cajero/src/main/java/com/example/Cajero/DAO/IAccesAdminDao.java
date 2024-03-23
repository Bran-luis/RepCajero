package com.example.Cajero.DAO;

import com.example.Cajero.Entity.AccesAdmin;
import org.aspectj.weaver.ast.Literal;

import java.util.List;

public interface IAccesAdminDao {
    List<AccesAdmin> inicioSesion(String nombreCliente, String pin);
}
