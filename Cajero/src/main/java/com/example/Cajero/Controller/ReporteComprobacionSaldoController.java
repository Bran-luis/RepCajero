package com.example.Cajero.Controller;

import com.example.Cajero.Entity.ReporteComprobacionSaldos;
import com.example.Cajero.Service.ReporteComprobacionSaldosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/reporte")
@CrossOrigin("*")
public class ReporteComprobacionSaldoController {
    @Autowired
    private ReporteComprobacionSaldosService reporteComprobacionSaldosService;

    @GetMapping("/saldos/{numeroCuenta}")
    public ResponseEntity<List<ReporteComprobacionSaldos>> reporte(@PathVariable String numeroCuenta){
        var result = reporteComprobacionSaldosService.reporteComprobacionSaldos(numeroCuenta);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

}
