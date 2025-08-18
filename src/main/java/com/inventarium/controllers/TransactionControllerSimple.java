package com.inventarium.controllers;

import com.inventarium.models.Transaction;
import com.inventarium.dtos.TransactionRequest;
import com.inventarium.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/transactions")
@CrossOrigin(origins = "http://localhost:4200")
public class TransactionControllerSimple {
    
    @Autowired
    private TransactionRepository transactionRepository;
    
    @GetMapping
    public ResponseEntity<List<Transaction>> getAllTransactions() {
        List<Transaction> transactions = transactionRepository.findAllByOrderByDateDesc();
        return ResponseEntity.ok(transactions);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Transaction> getTransactionById(@PathVariable Long id) {
        return transactionRepository.findById(id)
            .map(transaction -> ResponseEntity.ok().body(transaction))
            .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    public ResponseEntity<Transaction> createTransaction(@RequestBody TransactionRequest request) {
        try {
            // Converter TransactionRequest para Transaction
            Transaction transaction = new Transaction();
            transaction.setType(request.getTransactionType());
            transaction.setTotalValue(request.getTotalValue());
            transaction.setDate(LocalDateTime.now());
            transaction.setUsuarioId(request.getUsuarioId() != null ? request.getUsuarioId() : 1L);
            transaction.setObservacoes(request.getDescription());
            
            Transaction savedTransaction = transactionRepository.save(transaction);
            return ResponseEntity.ok(savedTransaction);
        } catch (Exception e) {
            System.err.println("Erro ao criar transação: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }
}
