package com.inventarium.models;

public class ProductNode {
    public Product product;
    public ProductNode left;
    public ProductNode right;

    public ProductNode(Product product) {
        this.product = product;
    }
}
