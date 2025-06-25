package com.inventarium.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "transactions")
public class Transaction {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;
    
    @Column(name = "product_name", nullable = false)
    private String productName;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TransactionType type;
    
    @Column(nullable = false)
    @Min(value = 1, message = "Quantidade deve ser maior que zero")
    private Integer quantity;
    
    @Column(name = "unit_price", precision = 10, scale = 2, nullable = false)
    @DecimalMin(value = "0.0", inclusive = false, message = "Preço deve ser maior que zero")
    private BigDecimal unitPrice;
    
    @Column(name = "total_value", precision = 10, scale = 2, nullable = false)
    private BigDecimal totalValue;
    
    @Column(nullable = false)
    private LocalDateTime date;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    public enum TransactionType {
        ENTRADA, SAIDA
    }
    
    @PrePersist
    protected void onCreate() {
        if (date == null) {
            date = LocalDateTime.now();
        }
        calculateTotalValue();
    }
    
    @PreUpdate
    protected void onUpdate() {
        calculateTotalValue();
    }
    
    private void calculateTotalValue() {
        if (quantity != null && unitPrice != null) {
            totalValue = unitPrice.multiply(BigDecimal.valueOf(quantity));
        }
    }
    
    // Construtores
    public Transaction() {}
    
    public Transaction(Product product, String productName, TransactionType type, 
                      Integer quantity, BigDecimal unitPrice, String description) {
        this.product = product;
        this.productName = productName;
        this.type = type;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.description = description;
        this.date = LocalDateTime.now();
        calculateTotalValue();
    }
    
    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
    
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    
    public TransactionType getType() { return type; }
    public void setType(TransactionType type) { this.type = type; }
    
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    
    public BigDecimal getTotalValue() { return totalValue; }
    public void setTotalValue(BigDecimal totalValue) { this.totalValue = totalValue; }
    
    public LocalDateTime getDate() { return date; }
    public void setDate(LocalDateTime date) { this.date = date; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
