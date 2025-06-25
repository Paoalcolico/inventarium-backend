package com.inventarium.controllers;

import com.inventarium.dtos.TransactionRequest;
import com.inventarium.dtos.TransactionResponse;
import com.inventarium.models.Product;
import com.inventarium.models.Transaction;
import com.inventarium.models.Transaction.TransactionType;
import com.inventarium.services.ProductService;
import com.inventarium.services.TransactionService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/transactions")
@CrossOrigin(origins = "http://localhost:4200")
public class TransactionController {
    
    @Autowired
    private TransactionService transactionService;
    
    @Autowired
    private ProductService productService;
    
    @GetMapping
    public ResponseEntity<List<TransactionResponse>> getAllTransactions() {
        List<Transaction> transactions = transactionService.getAllTransactions();
        List<TransactionResponse> response = transactions.stream()
            .map(TransactionResponse::new)
            .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<TransactionResponse> getTransactionById(@PathVariable Long id) {
        Optional<Transaction> transaction = transactionService.getTransactionById(id);
        return transaction.map(t -> ResponseEntity.ok(new TransactionResponse(t)))
                         .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    public ResponseEntity<?> createTransaction(@Valid @RequestBody TransactionRequest request) {
        try {
            Optional<Product> productOpt = productService.getProductById(request.getProductId());
            if (productOpt.isEmpty()) {
                Map<String, String> error = Map.of(
                    "error", "PRODUCT_NOT_FOUND",
                    "message", "Produto não encontrado"
                );
                return ResponseEntity.badRequest().body(error);
            }
            
            Product product = productOpt.get();
            
            // Verificar estoque para saída
            if (request.getType() == TransactionType.SAIDA && 
                product.getQuantity() < request.getQuantity()) {
                Map<String, Object> error = Map.of(
                    "error", "INSUFFICIENT_STOCK",
                    "message", "Estoque insuficiente",
                    "available", product.getQuantity(),
                    "requested", request.getQuantity()
                );
                return ResponseEntity.badRequest().body(error);
            }
            
            Transaction transaction = new Transaction(
                product,
                request.getProductName() != null ? request.getProductName() : product.getName(),
                request.getType(),
                request.getQuantity(),
                request.getUnitPrice(),
                request.getDescription()
            );
            
            Transaction savedTransaction = transactionService.saveTransaction(transaction);
            TransactionResponse response = new TransactionResponse(savedTransaction);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (RuntimeException e) {
            Map<String, String> error = Map.of(
                "error", "TRANSACTION_FAILED",
                "message", e.getMessage()
            );
            return ResponseEntity.badRequest().body(error);
        }
    }
    
    @GetMapping("/product/{productId}")
    public ResponseEntity<List<TransactionResponse>> getTransactionsByProduct(@PathVariable Long productId) {
        List<Transaction> transactions = transactionService.getTransactionsByProductId(productId);
        List<TransactionResponse> response = transactions.stream()
            .map(TransactionResponse::new)
            .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/type/{type}")
    public ResponseEntity<List<TransactionResponse>> getTransactionsByType(@PathVariable TransactionType type) {
        List<Transaction> transactions = transactionService.getTransactionsByType(type);
        List<TransactionResponse> response = transactions.stream()
            .map(TransactionResponse::new)
            .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/date-range")
    public ResponseEntity<List<TransactionResponse>> getTransactionsByDateRange(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {
        List<Transaction> transactions = transactionService.getTransactionsByDateRange(startDate, endDate);
        List<TransactionResponse> response = transactions.stream()
            .map(TransactionResponse::new)
            .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }
}
