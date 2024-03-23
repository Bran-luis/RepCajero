package com.example.Cajero.Controller;

import com.example.Cajero.Entity.ReponerDineroCajero;
import com.example.Cajero.Service.ReporteDineroCajaService;
import org.hibernate.mapping.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/reponerCajero")
@CrossOrigin("*")
public class ReponerDineroCajeroController {
    @Autowired
    private ReporteDineroCajaService reporteDineroCajaService;

    @PostMapping("/reponer/{cuenta}/{pinCliente}/{billetesDe100}/{billetesDe50}")
    public ResponseEntity<String> reponerDinero(@PathVariable("cuenta") String cuenta,
                                                @PathVariable("pinCliente") String pinCliente,
                                                @PathVariable("billetesDe100") int billetesDe100,
                                                @PathVariable("billetesDe50") int billetesDe50) {

        reporteDineroCajaService.ReporteDineroCaja(cuenta, pinCliente, billetesDe100, billetesDe50);

        return ResponseEntity.ok("Transacción realizada con éxito");
    }

}
