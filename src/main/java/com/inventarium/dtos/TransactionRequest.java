package com.inventarium.dtos;

import com.inventarium.models.Transaction.TransactionType;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

public class TransactionRequest {
    
    @NotNull(message = "ID do produto é obrigatório")
    private Long productId;
    
    private String productName;
    
    @NotNull(message = "Tipo da transação é obrigatório")
    private String type; // Aceita string para facilitar frontend
    
    @NotNull(message = "Quantidade é obrigatória")
    @Min(value = 1, message = "Quantidade deve ser maior que zero")
    private Integer quantity;
    
    @NotNull(message = "Preço unitário é obrigatório")
    @DecimalMin(value = "0.0", inclusive = false, message = "Preço deve ser maior que zero")
    private BigDecimal unitPrice;
    
    private String description;
    
    // Getters e Setters
    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
    
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    // Método helper para converter string para enum
    public TransactionType getTransactionType() {
        return TransactionType.valueOf(type.toUpperCase());
    }
    
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
