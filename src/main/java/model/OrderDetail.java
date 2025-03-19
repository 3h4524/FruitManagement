package model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;

@Entity
@Table(name = "OrderDetails")
@NamedQueries({
        @NamedQuery(name = "OrderDetails.findAll", query = "SELECT o FROM OrderDetail o"),
        @NamedQuery(name = "OrderDetails.findByOrderID", query = "SELECT o FROM OrderDetail o WHERE o.orderID.id = :orderDetailID"),
        @NamedQuery(name = "OrderDetails.findByQuantity", query = "SELECT o FROM OrderDetail o WHERE o.quantity = :quantity"),
        @NamedQuery(name = "OrderDetails.findByPrice", query = "SELECT o FROM OrderDetail o WHERE o.price = :price"),
        @NamedQuery(name = "OrderDetails.findByProductVariantID", query = "SELECT o FROM OrderDetail o WHERE o.productVariantID.id = :productVariantID"),
        @NamedQuery(name="OrderDetails.listWithOffset",
                query = "SELECT o FROM OrderDetail o ORDER BY o.id")
})
public class OrderDetail {
    @Id
    @Column(name = "OrderDetailID", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Tự động tăng ID
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "OrderID", nullable = false)
    private model.Order orderID;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity;

    @Column(name = "Price", nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ProductVariantID")
    private ProductVariant productVariantID;

    public ProductVariant getProductVariantID() {
        return productVariantID;
    }

    public void setProductVariantID(ProductVariant productVariantID) {
        this.productVariantID = productVariantID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public model.Order getOrderID() {
        return orderID;
    }

    public void setOrderID(model.Order orderID) {
        this.orderID = orderID;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

}