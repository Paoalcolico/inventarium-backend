package com.inventarium.controllers;

import com.inventarium.dtos.ProductRequest;
import com.inventarium.dtos.ProductResponse;
import com.inventarium.models.Product;
import com.inventarium.services.ProductService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/products")
@CrossOrigin(origins = "http://localhost:4200")
public class ProductController {
    
    @Autowired
    private ProductService productService;
    
    @GetMapping
    public ResponseEntity<List<ProductResponse>> getAllProducts() {
        List<Product> products = productService.getAllProducts();
        List<ProductResponse> response = products.stream()
            .map(ProductResponse::new)
            .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<ProductResponse> getProductById(@PathVariable Long id) {
        Optional<Product> product = productService.getProductById(id);
        return product.map(p -> ResponseEntity.ok(new ProductResponse(p)))
                     .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    public ResponseEntity<?> createProduct(@Valid @RequestBody ProductRequest productRequest) {
        try {
            // Verificar se já existe produto com o mesmo código do fabricante
            Optional<Product> existingProduct = productService.findByManufacturerCode(
                productRequest.getManufacturerCode());
            
            if (existingProduct.isPresent()) {
                // Retornar JSON estruturado em vez de string simples
                Map<String, String> error = Map.of(
                    "error", "DUPLICATE_MANUFACTURER_CODE",
                    "message", "Já existe um produto com o código do fabricante: " + 
                              productRequest.getManufacturerCode()
                );
                return ResponseEntity.badRequest().body(error);
            }
            
            Product product = productRequest.toProduct();
            Product savedProduct = productService.saveProduct(product);
            ProductResponse response = new ProductResponse(savedProduct);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            Map<String, String> error = Map.of(
                "error", "CREATION_FAILED",
                "message", "Erro ao criar produto: " + e.getMessage()
            );
            return ResponseEntity.badRequest().body(error);
        }
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<?> updateProduct(@PathVariable Long id, 
                                        @Valid @RequestBody ProductRequest productRequest) {
        try {
            // Verificar se existe outro produto com o mesmo código do fabricante
            Optional<Product> existingProduct = productService.findByManufacturerCode(
                productRequest.getManufacturerCode());
            
            if (existingProduct.isPresent() && !existingProduct.get().getId().equals(id)) {
                Map<String, String> error = Map.of(
                    "error", "DUPLICATE_MANUFACTURER_CODE",
                    "message", "Já existe outro produto com o código do fabricante: " + 
                            productRequest.getManufacturerCode()
                );
                return ResponseEntity.badRequest().body(error);
            }
            
            Product productDetails = productRequest.toProduct();
            Product updatedProduct = productService.updateProduct(id, productDetails);
            ProductResponse response = new ProductResponse(updatedProduct);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("não encontrado")) {
                Map<String, String> error = Map.of(
                    "error", "PRODUCT_NOT_FOUND",
                    "message", e.getMessage()
                );
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
            }
            Map<String, String> error = Map.of(
                "error", "UPDATE_FAILED",
                "message", "Erro ao atualizar produto: " + e.getMessage()
            );
            return ResponseEntity.badRequest().body(error);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long id) {
        try {
            productService.deleteProduct(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
    
    @GetMapping("/search")
    public ResponseEntity<List<ProductResponse>> searchProducts(@RequestParam String term) {
        List<Product> products = productService.searchProducts(term);
        List<ProductResponse> response = products.stream()
            .map(ProductResponse::new)
            .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/low-stock")
    public ResponseEntity<List<ProductResponse>> getLowStockProducts(@RequestParam(defaultValue = "10") Integer threshold) {
        List<Product> products = productService.getLowStockProducts(threshold);
        List<ProductResponse> response = products.stream()
            .map(ProductResponse::new)
            .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }
}
