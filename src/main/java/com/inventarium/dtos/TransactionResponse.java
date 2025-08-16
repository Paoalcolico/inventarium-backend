package com.inventarium.dtos;

import com.inventarium.models.Transaction;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class TransactionResponse {
    private Long id;
    private Long productId;
    private String productName;
    private String productBrand; // Campo adicional que pode ser útil
    private String type;
    private Integer quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalValue;
    private LocalDateTime date;
    private String description;
    
    // Construtor que converte de Transaction para TransactionResponse
    public TransactionResponse(Transaction transaction) {
        this.id = transaction.getId();
        this.productId = transaction.getUsuarioId(); // Para enquanto, vou usar usuarioId como referência
        this.productName = "Produto"; // Temporário
        this.productBrand = "Marca"; // Temporário
        this.type = transaction.getType().toString();
        this.quantity = 1; // Temporário - não temos quantity na nova Transaction
        this.unitPrice = transaction.getTotalValue();
        this.totalValue = transaction.getTotalValue();
        this.date = transaction.getDate();
        this.description = transaction.getDescription();
    }
    
    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductBrand() {
        return productBrand;
    }

    public void setProductBrand(String productBrand) {
        this.productBrand = productBrand;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getTotalValue() {
        return totalValue;
    }

    public void setTotalValue(BigDecimal totalValue) {
        this.totalValue = totalValue;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
    
    // ... todos os outros getters e setters
}
