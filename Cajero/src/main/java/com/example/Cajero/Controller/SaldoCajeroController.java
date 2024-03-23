package com.example.Cajero.Controller;

import com.example.Cajero.Entity.SaldoCajero;
import com.example.Cajero.Service.SaldoCajeroService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/saldoCajero")
@CrossOrigin("*")
public class SaldoCajeroController {
    @Autowired
    private SaldoCajeroService saldoCajeroService;

    @GetMapping("/saldoCajero")
    public ResponseEntity<List<SaldoCajero>> saldoCajero(){
        var result = saldoCajeroService.nombre();
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
}
