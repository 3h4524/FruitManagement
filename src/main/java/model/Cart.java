package model;

import java.util.List;
import java.util.Map;

public class Cart {
    private Map<Integer,CartItem> items;

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void setItems(Map<Integer, CartItem> items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "items=" + items +
                '}';
    }
}
