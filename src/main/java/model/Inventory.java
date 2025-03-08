package model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "Inventory")
@NamedQueries({
        @NamedQuery(name = "Inventory.findAll", query = "SELECT i FROM Inventory i"),
        @NamedQuery(name = "Inventory.findByInventoryID", query = "SELECT i FROM Inventory i WHERE i.id = :inventoryID"),
        @NamedQuery(name = "Inventory.findByStoreLocation", query = "SELECT i FROM Inventory i WHERE i.storeLocation = :storeLocation"),
        @NamedQuery(name = "Inventory.findByQuantity", query = "SELECT i FROM Inventory i WHERE i.quantity = :quantity")})
public class Inventory {
    @Id
    @Column(name = "InventoryID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "ProductID", nullable = false)
    private model.Product productID;

    @Nationalized
    @ColumnDefault("'Main WareHouse'")
    @Column(name = "StoreLocation", length = 100)
    private String storeLocation;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public model.Product getProductID() {
        return productID;
    }

    public void setProductID(model.Product productID) {
        this.productID = productID;
    }

    public String getStoreLocation() {
        return storeLocation;
    }

    public void setStoreLocation(String storeLocation) {
        this.storeLocation = storeLocation;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

}