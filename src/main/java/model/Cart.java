package model;

import java.util.List;

public class Cart {
    private List<Product> products;
    public Cart() {}
    public Cart(List<Product> products) {}

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "products=" + products +
                '}';
    }
}
