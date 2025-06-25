package com.inventarium.dtos;

import jakarta.validation.constraints.*;
import java.math.BigDecimal;

import com.inventarium.models.Product;

public class ProductRequest {
    
    @NotBlank(message = "Código do fabricante é obrigatório")
    private String manufacturerCode;
    
    @NotBlank(message = "Marca é obrigatória")
    private String brand;
    
    private String stockLocation;
    
    @Min(value = 0, message = "Garantia deve ser maior ou igual a 0")
    private Integer warrantyMonths;
    
    @NotBlank(message = "Nome é obrigatório")
    private String name;
    
    private String description;
    
    @NotNull(message = "Preço unitário é obrigatório")
    @DecimalMin(value = "0.0", inclusive = false, message = "Preço deve ser maior que zero")
    private BigDecimal unitPrice;
    
    @NotNull(message = "Quantidade é obrigatória")
    @Min(value = 0, message = "Quantidade deve ser maior ou igual a 0")
    private Integer quantity;
    
    // Construtores
    public ProductRequest() {}
    
    public ProductRequest(String manufacturerCode, String brand, String stockLocation, 
                         Integer warrantyMonths, String name, String description, 
                         BigDecimal unitPrice, Integer quantity) {
        this.manufacturerCode = manufacturerCode;
        this.brand = brand;
        this.stockLocation = stockLocation;
        this.warrantyMonths = warrantyMonths;
        this.name = name;
        this.description = description;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }
    
    // Getters e Setters
    public String getManufacturerCode() {
        return manufacturerCode;
    }
    
    public void setManufacturerCode(String manufacturerCode) {
        this.manufacturerCode = manufacturerCode;
    }
    
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
    
    // Método para converter para entidade Product
    public Product toProduct() {
        return new Product(
            this.manufacturerCode,
            this.brand,
            this.stockLocation,
            this.warrantyMonths,
            this.name,
            this.description,
            this.unitPrice,
            this.quantity
        );
    }
}
