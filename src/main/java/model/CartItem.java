package model;

public class CartItem {
    private int quantity;
    private ProductVariant productVariant;

    public CartItem(int quantity, ProductVariant productVariant) {
        this.quantity = quantity;
        this.productVariant = productVariant;
    }

    public CartItem() {
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public ProductVariant getProductVariant() {
        return productVariant;
    }

    public void setProductVariant(ProductVariant productVariant) {
        this.productVariant = productVariant;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "quantity=" + quantity +
                ", product=" + productVariant +
                '}';
    }
}
