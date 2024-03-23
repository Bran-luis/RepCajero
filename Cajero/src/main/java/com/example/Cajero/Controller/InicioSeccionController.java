package com.example.Cajero.Controller;

import com.example.Cajero.Entity.AccesAdmin;
import com.example.Cajero.Entity.InicioSeccion;
import com.example.Cajero.Service.InicioSesionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/inicioUser")
@CrossOrigin("*")
public class InicioSeccionController {
    @Autowired
    private InicioSesionService inicioSesionService;

    @GetMapping("/inicioAdmin/{nombreCliente},{pin}")
    public ResponseEntity<List<InicioSeccion>> inicioSeccion(@PathVariable String nombreCliente, @PathVariable String pin){
        var result = inicioSesionService.inicioSeccion(nombreCliente,pin);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
}
