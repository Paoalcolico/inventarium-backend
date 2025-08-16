package com.inventarium.config;

import com.inventarium.models.Product;
import com.inventarium.models.Transaction;
import com.inventarium.models.Marca;
import com.inventarium.repositories.ProductRepository;
import com.inventarium.repositories.TransactionRepository;
import com.inventarium.repositories.MarcaRepository;
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
    
    @Autowired
    private MarcaRepository marcaRepository;
    
    @Override
    public void run(String... args) throws Exception {
        // Só executa se não houver muitos produtos (evita duplicação com data.sql)
        if (productRepository.count() < 17) {
            initializeAdditionalData();
        }
    }
    
    private void initializeAdditionalData() {
        try {
            // Buscar marcas existentes
            Marca samsung = marcaRepository.findById(1L).orElse(null);
            Marca apple = marcaRepository.findById(2L).orElse(null);
            
            if (samsung != null && apple != null) {
                // Criar produtos adicionais usando a nova estrutura
                Product product1 = new Product(
                    "DI-SAMSUNG-001",
                    samsung.getId(),
                    "Estoque E-01", 
                    "24",
                    "Galaxy Tab S9 Ultra",
                    "Tablet Samsung Galaxy Tab S9 Ultra 12.4 polegadas",
                    new BigDecimal("2499.99"),
                    15
                );
                
                Product product2 = new Product(
                    "DI-APPLE-001",
                    apple.getId(),
                    "Estoque E-02",
                    "12", 
                    "iPad Pro 12.9",
                    "iPad Pro 12.9 polegadas M2 256GB WiFi",
                    new BigDecimal("3199.99"),
                    8
                );
                
                productRepository.save(product1);
                productRepository.save(product2);
                
                // Criar transação usando nova estrutura
                Transaction transaction1 = new Transaction(
                    Transaction.TransactionType.ENTRADA,
                    new BigDecimal("37499.85"),
                    2L,
                    "Compra inicial DataInitializer - Tablets"
                );
                
                transactionRepository.save(transaction1);
                
                System.out.println("DataInitializer: Produtos e transações adicionais criados");
            }
        } catch (Exception e) {
            System.err.println("Erro no DataInitializer: " + e.getMessage());
        }
    }
}
