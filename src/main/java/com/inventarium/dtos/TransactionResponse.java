package com.inventarium.dtos;

import com.inventarium.models.Transaction;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class TransactionResponse {
    private Long id;
    private String type;
    private BigDecimal totalValue;
    private LocalDateTime date;
    private String description;
    private Long usuarioId;
    
    // Construtor que converte de Transaction para TransactionResponse
    public TransactionResponse(Transaction transaction) {
        this.id = transaction.getId();
        this.type = transaction.getType().toString();
        this.totalValue = transaction.getTotalValue();
        this.date = transaction.getDate();
    this.description = transaction.getObservacoes();
        this.usuarioId = transaction.getUsuarioId();
    }
    
    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public BigDecimal getTotalValue() { return totalValue; }
    public void setTotalValue(BigDecimal totalValue) { this.totalValue = totalValue; }

    public LocalDateTime getDate() { return date; }
    public void setDate(LocalDateTime date) { this.date = date; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Long getUsuarioId() { return usuarioId; }
    public void setUsuarioId(Long usuarioId) { this.usuarioId = usuarioId; }
    
    // ... todos os outros getters e setters
}
