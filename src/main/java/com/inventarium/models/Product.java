package com.inventarium.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "produto")
public class Product {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "codigo_fabricante", nullable = false)
    @NotBlank(message = "Código do fabricante é obrigatório")
    private String manufacturerCode;
    
    @Column(name = "marca_id", nullable = false)
    private Long marcaId;
    
    @Column(name = "localizacao")
    private String stockLocation;
    
    @Column(name = "garantia")
    private String warrantyMonths;
    
    @Column(name = "nome", nullable = false)
    @NotBlank(message = "Nome é obrigatório")
    private String name;
    
    @Column(name = "descricao", columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "valor_unitario", precision = 10, scale = 2, nullable = false)
    @DecimalMin(value = "0.0", inclusive = false, message = "Preço deve ser maior que zero")
    private BigDecimal unitPrice;
    
    @Column(name = "quantidade", nullable = false)
    @Min(value = 0, message = "Quantidade deve ser maior ou igual a 0")
    private Integer quantity;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "edited_at")
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Construtores
    public Product() {}
    
    public Product(String manufacturerCode, Long marcaId, String stockLocation, 
                   String warrantyMonths, String name, String description, 
                   BigDecimal unitPrice, Integer quantity) {
        this.manufacturerCode = manufacturerCode;
        this.marcaId = marcaId;
        this.stockLocation = stockLocation;
        this.warrantyMonths = warrantyMonths;
        this.name = name;
        this.description = description;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }
    
    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getManufacturerCode() { return manufacturerCode; }
    public void setManufacturerCode(String manufacturerCode) { this.manufacturerCode = manufacturerCode; }
    
    public Long getMarcaId() { return marcaId; }
    public void setMarcaId(Long marcaId) { this.marcaId = marcaId; }
    
    public String getStockLocation() { return stockLocation; }
    public void setStockLocation(String stockLocation) { this.stockLocation = stockLocation; }
    
    public String getWarrantyMonths() { return warrantyMonths; }
    public void setWarrantyMonths(String warrantyMonths) { this.warrantyMonths = warrantyMonths; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}