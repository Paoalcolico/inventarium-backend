package com.inventarium.controllers;

import com.inventarium.models.Marca;
import com.inventarium.repositories.MarcaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/marcas")
@CrossOrigin(origins = "http://localhost:4200")
public class MarcaController {
    
    @Autowired
    private MarcaRepository marcaRepository;
    
    @GetMapping
    public ResponseEntity<List<Marca>> getAllMarcas() {
        List<Marca> marcas = marcaRepository.findAll();
        return ResponseEntity.ok(marcas);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Marca> getMarcaById(@PathVariable Long id) {
        return marcaRepository.findById(id)
            .map(marca -> ResponseEntity.ok().body(marca))
            .orElse(ResponseEntity.notFound().build());
    }
}
