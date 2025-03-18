package service;

import dao.GenericDAO;
import jakarta.mail.Session;
import model.Cart;
import model.CartItem;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class CartService {
    public void addCartItem(Cart cart, CartItem cartItem) {
        if(cart.getItems() == null){
            cart.setItems(new HashMap<>());
        }

        Map<Integer, CartItem> items = cart.getItems();

        int productVariantId = cartItem.getProductVariant().getId();
        if(items.containsKey(productVariantId)){
            CartItem item = items.get(productVariantId);
            item.setQuantity(item.getQuantity() + cartItem.getQuantity());
        } else {
            items.put(productVariantId, cartItem);
        }
    }

    public void removeCartItem(Cart cart, int productVariantId) {
        if (cart == null || cart.getItems() == null) {
            System.out.println("⚠ Giỏ hàng hoặc danh sách sản phẩm đang null!");
            return;
        }

        if (cart.getItems().containsKey(productVariantId)) {
            cart.getItems().remove(productVariantId);
            System.out.println("✅ Đã xóa sản phẩm " + productVariantId + " khỏi giỏ hàng.");
        } else {
            System.out.println("❌ Sản phẩm " + productVariantId + " không có trong giỏ hàng!");
        }
    }

    public void updateCartItemQuantity(Cart cart, int productVariantId, int quantity) {
        if(cart.getItems() != null && cart.getItems().containsKey(productVariantId)){
            if(quantity > 0){
                 cart.getItems().get(productVariantId).setQuantity(quantity);
            } else {
                cart.getItems().remove(productVariantId);
            }
        }
    }

    public void clearCart(Cart cart){
        if(cart.getItems() != null){
            cart.getItems().clear();
        }
    }

    public int getTotalQuantity(Cart cart){
        int totalQuantity  = 0;
        if(cart != null && cart.getItems() != null){
            for(CartItem item : cart.getItems().values()){
                totalQuantity += item.getQuantity();
            }
        }
        return totalQuantity;
    }
}
