package com.example.Cajero.Controller;

import com.example.Cajero.Service.TransferirCuentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/trasn")
@CrossOrigin("*")
public class TransferirCuentaController {
    @Autowired
    private TransferirCuentaService transferirCuentaService;

    @PostMapping("/transferenciaCuenta/{cuentaOrigen}/{cuentaDestino}/{saldoTransaccion}")
    public ResponseEntity<String> trasnferenciaCuenta(
            @PathVariable("cuentaOrigen") String cuentaOrigen,
            @PathVariable("cuentaDestino") String cuentaDestino,
            @PathVariable("saldoTransaccion") float saldoTransaccion) {

        transferirCuentaService.tranferirPorCuenta(cuentaOrigen, cuentaDestino, saldoTransaccion);
        return ResponseEntity.ok("Transferencia realizada con éxito");
    }

    @PostMapping("/transferenciaNumero/{cuentaOrigen}/{numeroTelefono}/{saldoTransferencia}")
    public ResponseEntity<String> transferenciaNumero( @PathVariable("cuentaOrigen") String cuentaOrigen,
                                                       @PathVariable("numeroTelefono") String numeroTelefono,
                                                       @PathVariable("saldoTransferencia") float saldoTransferencia) {

        transferirCuentaService.nombre(cuentaOrigen, numeroTelefono, saldoTransferencia);
        return ResponseEntity.ok("Tranferencia realizada con éxito");
    }
}
