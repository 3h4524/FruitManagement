package model;

import java.util.List;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> cart;
    public Cart() {}

    public Cart(Map<Integer,CartItem> cart) {
        this.cart = cart;
    }

    public Map<Integer, CartItem> getCart() {
        return cart;
    }

    public void addCartItem(CartItem cartItem) {
        Integer productId = cartItem.getProduct().getId();
        cart.compute(productId, (key, existingItems) -> {
            if (existingItems == null) {
                existingItems = cartItem;
            } else {
                existingItems.setQuantity(existingItems.getQuantity() + cartItem.getQuantity());
            }
            return existingItems;
        });
    }
}
