
/*
package com.inventarium.services;

import com.inventarium.models.Product;
import com.inventarium.models.Transaction;
import com.inventarium.models.Transaction.TransactionType;
import com.inventarium.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import jakarta.persistence.EntityNotFoundException;
import org.hibernate.Hibernate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
public class TransactionService {
    
    @Autowired
    private TransactionRepository transactionRepository;
    
    @Autowired
    private ProductService productService;
    
    public List<Transaction> getAllTransactions() {
        List<Transaction> transactions = transactionRepository.findAllByOrderByDateDesc();
        
        return transactions.stream()
            .filter(this::isProductValid)
            .collect(Collectors.toList());
    }
    
    public Optional<Transaction> getTransactionById(Long id) {
        Optional<Transaction> transaction = transactionRepository.findById(id);
        
        if (transaction.isPresent() && !isProductValid(transaction.get())) {
            System.err.println("Transação " + id + " referencia um produto que não existe mais");
            return Optional.empty();
        }
        
        return transaction;
    }
    
    public Transaction saveTransaction(Transaction transaction) {
        Product product = transaction.getProduct();
        if (product == null || product.getId() == null) {
            throw new RuntimeException("Produto é obrigatório para a transação");
        }
        
        Product existingProduct = productService.getProductById(product.getId())
            .orElseThrow(() -> new RuntimeException("Produto não encontrado com id: " + product.getId()));
        
        transaction.setProduct(existingProduct);
        
        Integer currentQuantity = existingProduct.getQuantity();
        Integer transactionQuantity = transaction.getQuantity();
        
        if (transaction.getType() == TransactionType.ENTRADA) {
            existingProduct.setQuantity(currentQuantity + transactionQuantity);
        } else if (transaction.getType() == TransactionType.SAIDA) {
            if (currentQuantity < transactionQuantity) {
                throw new RuntimeException("Estoque insuficiente. Disponível: " + currentQuantity);
            }
            existingProduct.setQuantity(currentQuantity - transactionQuantity);
        }
        
        productService.saveProduct(existingProduct);
        return transactionRepository.save(transaction);
    }
    
    public List<Transaction> getTransactionsByProductId(Long productId) {
        productService.getProductById(productId)
            .orElseThrow(() -> new RuntimeException("Produto não encontrado com id: " + productId));
        
        return transactionRepository.findByProductIdOrderByDateDesc(productId);
    }
    
    public List<Transaction> getTransactionsByType(TransactionType type) {
        List<Transaction> transactions = transactionRepository.findByTypeOrderByDateDesc(type);
        
        return transactions.stream()
            .filter(this::isProductValid)
            .collect(Collectors.toList());
    }
    
    public List<Transaction> getTransactionsByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        List<Transaction> transactions = transactionRepository.findByDateBetween(startDate, endDate);
        
        return transactions.stream()
            .filter(this::isProductValid)
            .collect(Collectors.toList());
    }
    
    private boolean isProductValid(Transaction transaction) {
        try {
            Product product = transaction.getProduct();
            if (product == null) {
                return false;
            }
            
            Hibernate.initialize(product);
            return product.getId() != null;
            
        } catch (EntityNotFoundException e) {
            return false;
        } catch (Exception e) {
            System.err.println("Erro ao verificar produto da transação " + 
                transaction.getId() + ": " + e.getMessage());
            return false;
        }
    }
    
    @Transactional
    public int cleanOrphanTransactions() {
        List<Transaction> allTransactions = transactionRepository.findAll();
        List<Transaction> orphanTransactions = allTransactions.stream()
            .filter(t -> !isProductValid(t))
            .collect(Collectors.toList());
        
        if (!orphanTransactions.isEmpty()) {
            transactionRepository.deleteAll(orphanTransactions);
            System.out.println("Removidas " + orphanTransactions.size() + " transações órfãs");
        }
        
        return orphanTransactions.size();
    }
}
*/