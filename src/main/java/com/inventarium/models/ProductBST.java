package com.inventarium.models;

import java.util.ArrayList;
import java.util.List;

public class ProductBST {
    private ProductNode root;

    public void insert(Product product) {
        root = insertRecursive(root, product);
    }

    private ProductNode insertRecursive(ProductNode current, Product product) {
        if (current == null) return new ProductNode(product);
        if (product.getName().compareToIgnoreCase(current.product.getName()) < 0) {
            current.left = insertRecursive(current.left, product);
        } else {
            current.right = insertRecursive(current.right, product);
        }
        return current;
    }

    public Product search(String name) {
        return searchRecursive(root, name);
    }

    private Product searchRecursive(ProductNode current, String name) {
        if (current == null) return null;
        int cmp = name.compareToIgnoreCase(current.product.getName());
        if (cmp == 0) return current.product;
        return (cmp < 0)
            ? searchRecursive(current.left, name)
            : searchRecursive(current.right, name);
    }

    public List<Product> inOrderTraversal() {
        List<Product> result = new ArrayList<>();
        inOrderTraversalRecursive(root, result);
        return result;
    }

    private void inOrderTraversalRecursive(ProductNode node, List<Product> result) {
        if (node != null) {
            inOrderTraversalRecursive(node.left, result);
            result.add(node.product);
            inOrderTraversalRecursive(node.right, result);
        }
    }
}
