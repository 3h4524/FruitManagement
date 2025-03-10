package model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
@NamedQueries({
        @NamedQuery(name = "ProductStock.findAll",
                query = "SELECT p FROM ProductStock p"),

        @NamedQuery(name = "ProductStock.findById",
                query = "SELECT p FROM ProductStock p WHERE p.id = :id"),

        @NamedQuery(name = "ProductStock.findByProductVariantID",
                query = "SELECT p FROM ProductStock p WHERE p.productVariantID.id = :productVariantID"),

        @NamedQuery(name = "ProductStock.findByInventoryID",
                query = "SELECT p FROM ProductStock p WHERE p.inventoryID.id = :inventoryID"),

        @NamedQuery(name = "ProductStock.findByAmountGreaterThan",
                query = "SELECT p FROM ProductStock p WHERE p.amount > :amount"),

        @NamedQuery(name = "ProductStock.findByAmountLessThan",
                query = "SELECT p FROM ProductStock p WHERE p.amount < :amount"),
        @NamedQuery(name="ProductStock.listWithOffset",
                query = "SELECT p FROM ProductStock p ORDER BY p.id")
})
@Entity
public class ProductStock {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "ProductVariantID", nullable = false)
    private model.ProductVariant productVariantID;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "InventoryID", nullable = false)
    private Inventory inventoryID;

    @ColumnDefault("0")
    @Column(name = "Amount", nullable = false)
    private Integer amount;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public model.ProductVariant getProductVariantID() {
        return productVariantID;
    }

    public void setProductVariantID(model.ProductVariant productVariantID) {
        this.productVariantID = productVariantID;
    }

    public Inventory getInventoryID() {
        return inventoryID;
    }

    public void setInventoryID(Inventory inventoryID) {
        this.inventoryID = inventoryID;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

}