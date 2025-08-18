package com.inventarium.dtos;

import com.inventarium.models.Transaction.TransactionType;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

public class TransactionRequest {
    
    @NotNull(message = "Tipo da transação é obrigatório")
    private String type;

    @NotNull(message = "Valor total é obrigatório")
    @DecimalMin(value = "0.0", inclusive = false, message = "Valor deve ser maior que zero")
    private BigDecimal totalValue;

    @NotNull(message = "ID do usuário é obrigatório")
    private Long usuarioId;

    private String description;
    
    // Getters e Setters
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public TransactionType getTransactionType() {
        return TransactionType.valueOf(type.toUpperCase());
    }

    public BigDecimal getTotalValue() { return totalValue; }
    public void setTotalValue(BigDecimal totalValue) { this.totalValue = totalValue; }

    public Long getUsuarioId() { return usuarioId; }
    public void setUsuarioId(Long usuarioId) { this.usuarioId = usuarioId; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
