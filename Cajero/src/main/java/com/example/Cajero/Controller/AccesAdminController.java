package com.example.Cajero.Controller;

import com.example.Cajero.Entity.AccesAdmin;
import com.example.Cajero.Service.AccesAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/accesAdmin")
@CrossOrigin("*")
public class AccesAdminController {
    @Autowired
    private AccesAdminService accesAdminService;
    @GetMapping("/inicioAdmin/{nombreUsuario},{pin}")
    public ResponseEntity<List<AccesAdmin>> inicioSeccion(@PathVariable String nombreUusario, @PathVariable String pin){
        var result = accesAdminService.inicioSesion(nombreUusario,pin);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
}
