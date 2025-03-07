package model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;

@Entity
@Table(name = "InventoryLogs")
public class InventoryLog {
    @Id
    @Column(name = "LogID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "ProductID", nullable = false)
    private model.Product productID;

    @Nationalized
    @Column(name = "ActionType", nullable = false, length = 10)
    private String actionType;

    @Column(name = "QuantityChanged", nullable = false)
    private Integer quantityChanged;

    @ColumnDefault("getdate()")
    @Column(name = "ActionDate")
    private Instant actionDate;

    @Nationalized
    @ColumnDefault("'Main WareHouse'")
    @Column(name = "StoreLocation", length = 100)
    private String storeLocation;

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

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public Integer getQuantityChanged() {
        return quantityChanged;
    }

    public void setQuantityChanged(Integer quantityChanged) {
        this.quantityChanged = quantityChanged;
    }

    public Instant getActionDate() {
        return actionDate;
    }

    public void setActionDate(Instant actionDate) {
        this.actionDate = actionDate;
    }

    public String getStoreLocation() {
        return storeLocation;
    }

    public void setStoreLocation(String storeLocation) {
        this.storeLocation = storeLocation;
    }

}