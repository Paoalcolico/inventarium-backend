package com.inventarium.models;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "transacao")
public class Transaction {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "tipo", nullable = false, length = 10)
    @Convert(converter = TransactionTypeConverter.class)
    private TransactionType type;
    
    @Column(name = "valor_total", precision = 12, scale = 2, nullable = false)
    private BigDecimal totalValue;
    
    @Column(name = "data_transacao", nullable = false)
    private LocalDateTime date;
    
    @Column(name = "usuario_id", nullable = false)
    private Long usuarioId;
    
    @Column(name = "observacoes", columnDefinition = "TEXT")
    private String observacoes;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    public enum TransactionType {
        ENTRADA("entrada"), SAIDA("saida");
        private final String value;
        TransactionType(String value) { this.value = value; }
        public String getValue() { return value; }
        public static TransactionType fromValue(String value) {
            for (TransactionType t : values()) {
                if (t.value.equalsIgnoreCase(value)) return t;
            }
            throw new IllegalArgumentException("Tipo inválido: " + value);
        }
    }

    @jakarta.persistence.Converter(autoApply = true)
    public static class TransactionTypeConverter implements jakarta.persistence.AttributeConverter<TransactionType, String> {
        @Override
        public String convertToDatabaseColumn(TransactionType attribute) {
            return attribute != null ? attribute.getValue() : null;
        }
        @Override
        public TransactionType convertToEntityAttribute(String dbData) {
            return dbData != null ? TransactionType.fromValue(dbData) : null;
        }
    }
    
    @PrePersist
    protected void onCreate() {
        if (date == null) {
            date = LocalDateTime.now();
        }
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
    
    // Construtores
    public Transaction() {}
    
    public Transaction(TransactionType type, BigDecimal totalValue, Long usuarioId, String observacoes) {
        this.type = type;
        this.totalValue = totalValue;
        this.usuarioId = usuarioId;
        this.observacoes = observacoes;
        this.date = LocalDateTime.now();
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public TransactionType getType() { return type; }
    public void setType(TransactionType type) { this.type = type; }
    
    public BigDecimal getTotalValue() { return totalValue; }
    public void setTotalValue(BigDecimal totalValue) { this.totalValue = totalValue; }
    
    public LocalDateTime getDate() { return date; }
    public void setDate(LocalDateTime date) { this.date = date; }
    
    public Long getUsuarioId() { return usuarioId; }
    public void setUsuarioId(Long usuarioId) { this.usuarioId = usuarioId; }
    
    public String getObservacoes() { return observacoes; }
    public void setObservacoes(String observacoes) { this.observacoes = observacoes; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
