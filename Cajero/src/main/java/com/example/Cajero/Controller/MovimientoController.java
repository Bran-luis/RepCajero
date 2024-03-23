package com.example.Cajero.Controller;

import com.example.Cajero.Service.MovimientoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/transaction")
@CrossOrigin("*")
public class MovimientoController {
    @Autowired
    private MovimientoService movimientoService;

    @PostMapping("/movimiento/{cuenta}/{transTipo}/{transValor}")
    public ResponseEntity<String> realizarTransaccion(@PathVariable("cuenta") String cuenta,
                                                      @PathVariable("transTipo") String tipo,
                                                      @PathVariable("transValor") float monto) {

        movimientoService.Movimiento(cuenta, tipo, monto);
        return ResponseEntity.ok("Transacción realizada con éxito");
    }
}
