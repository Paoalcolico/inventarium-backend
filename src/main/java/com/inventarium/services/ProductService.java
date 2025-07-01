
package com.inventarium.services;

import com.inventarium.models.Product;
import com.inventarium.models.Transaction;
import com.inventarium.repositories.ProductRepository;
import com.inventarium.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProductService {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private TransactionRepository transactionRepository;
    
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }
    
    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }
    
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }
    
    public Product updateProduct(Long id, Product productDetails) {
        Product product = productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Produto não encontrado com id: " + id));
        
        product.setManufacturerCode(productDetails.getManufacturerCode());
        product.setBrand(productDetails.getBrand());
        product.setStockLocation(productDetails.getStockLocation());
        product.setWarrantyMonths(productDetails.getWarrantyMonths());
        product.setName(productDetails.getName());
        product.setDescription(productDetails.getDescription());
        product.setUnitPrice(productDetails.getUnitPrice());
        product.setQuantity(productDetails.getQuantity());
        
        return productRepository.save(product);
    }
    
    public void deleteProduct(Long id) {
        Product product = productRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Produto não encontrado com id: " + id));
        
        List<Transaction> associatedTransactions = transactionRepository.findByProductId(id);
        if (!associatedTransactions.isEmpty()) {
            transactionRepository.deleteAll(associatedTransactions);
        }
        
        productRepository.delete(product);
    }
    
    public List<Product> searchProducts(String searchTerm) {
        return productRepository.searchProducts(searchTerm);
    }
    
    public Optional<Product> findByManufacturerCode(String manufacturerCode) {
        return productRepository.findByManufacturerCode(manufacturerCode);
    }
    
    public List<Product> getLowStockProducts(Integer threshold) {
        return productRepository.findByQuantityLessThan(threshold);
    }
    
    public void updateStock(Long productId, Integer newQuantity) {
        Product product = productRepository.findById(productId)
            .orElseThrow(() -> new RuntimeException("Produto não encontrado com id: " + productId));
        product.setQuantity(newQuantity);
        productRepository.save(product);
    }
}