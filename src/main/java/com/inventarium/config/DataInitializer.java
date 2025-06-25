package com.inventarium.config;

import com.inventarium.models.Product;
import com.inventarium.models.Transaction;
import com.inventarium.models.Transaction.TransactionType;
import com.inventarium.repositories.ProductRepository;
import com.inventarium.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import java.math.BigDecimal;

@Component
public class DataInitializer implements CommandLineRunner {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private TransactionRepository transactionRepository;
    
    @Override
    public void run(String... args) throws Exception {
        if (productRepository.count() == 0) {
            initializeData();
        }
    }
    
    private void initializeData() {
        // Criar produtos iniciais
        Product product1 = new Product(
            "ABC123",
            "Samsung",
            "A1-B2",
            12,
            "Smartphone Galaxy S24",
            "Smartphone Android com 256GB de armazenamento",
            new BigDecimal("1299.99"),
            50
        );
        
        Product product2 = new Product(
            "XYZ789",
            "Apple",
            "B3-C4",
            12,
            "iPhone 15 Pro",
            "iPhone com chip A17 Pro e 128GB",
            new BigDecimal("1899.99"),
            30
        );
        
        productRepository.save(product1);
        productRepository.save(product2);
        
        // Criar transação inicial
        Transaction transaction1 = new Transaction(
            product1,
            product1.getName(),
            TransactionType.ENTRADA,
            10,
            new BigDecimal("1299.99"),
            "Initial stock purchase"
        );
        
        transactionRepository.save(transaction1);
    }
}
