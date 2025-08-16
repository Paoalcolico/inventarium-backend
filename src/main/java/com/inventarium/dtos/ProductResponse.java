package com.inventarium.dtos;

import com.inventarium.models.Product;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ProductResponse {
    private Long id;
    private String manufacturerCode;
    private String brand;
    private String stockLocation;
    private Integer warrantyMonths;
    private String name;
    private String description;
    private BigDecimal unitPrice;
    private Integer quantity;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    public ProductResponse(Product product) {
        this.id = product.getId();
        this.manufacturerCode = product.getManufacturerCode();
        this.brand = product.getMarcaId() != null ? product.getMarcaId().toString() : null;
        this.stockLocation = product.getStockLocation();
        
        // Extrair apenas números da string de garantia
        this.warrantyMonths = null;
        if (product.getWarrantyMonths() != null) {
            try {
                String warrantyStr = product.getWarrantyMonths().replaceAll("[^0-9]", "");
                if (!warrantyStr.isEmpty()) {
                    this.warrantyMonths = Integer.parseInt(warrantyStr);
                }
            } catch (NumberFormatException e) {
                this.warrantyMonths = null;
            }
        }
        
        this.name = product.getName();
        this.description = product.getDescription();
        this.unitPrice = product.getUnitPrice();
        this.quantity = product.getQuantity();
        this.createdAt = product.getCreatedAt();
        this.updatedAt = product.getUpdatedAt();
    }
    
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getStockLocation() {
        return stockLocation;
    }

    public void setStockLocation(String stockLocation) {
        this.stockLocation = stockLocation;
    }

    public Integer getWarrantyMonths() {
        return warrantyMonths;
    }

    public void setWarrantyMonths(Integer warrantyMonths) {
        this.warrantyMonths = warrantyMonths;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public String getManufacturerCode() { return manufacturerCode; }
    public void setManufacturerCode(String manufacturerCode) { this.manufacturerCode = manufacturerCode; }
}
