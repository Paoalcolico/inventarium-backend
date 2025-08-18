
//
package com.inventarium.services;

// import com.inventarium.models.Product;
import com.inventarium.models.Transaction;
import com.inventarium.models.Transaction.TransactionType;
import com.inventarium.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
// import jakarta.persistence.EntityNotFoundException;
// import org.hibernate.Hibernate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
// import java.util.stream.Collectors;

@Service
@Transactional
public class TransactionService {
    
    @Autowired
    private TransactionRepository transactionRepository;
    
    // @Autowired
    // private ProductService productService;
    
    public List<Transaction> getAllTransactions() {
        return transactionRepository.findAllByOrderByDateDesc();
    }
    
    public Optional<Transaction> getTransactionById(Long id) {
        return transactionRepository.findById(id);
    }
    
    public Transaction saveTransaction(Transaction transaction) {
        // Ajuste: não há mais relação direta com produto
        return transactionRepository.save(transaction);
    }
    
    // public List<Transaction> getTransactionsByProductId(Long productId) {
    //     // Não há mais productId em Transaction
    //     return List.of();
    // }
    
    public List<Transaction> getTransactionsByType(TransactionType type) {
        return transactionRepository.findByTypeOrderByDateDesc(type);
    }
    
    public List<Transaction> getTransactionsByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return transactionRepository.findByDateBetween(startDate, endDate);
    }
    
    // Não há mais validação de produto órfão
}
