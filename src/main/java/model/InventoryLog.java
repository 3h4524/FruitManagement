package model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;

@Entity
@Table(name = "InventoryLogs")
@NamedQueries({
        @NamedQuery(name = "InventoryLogs.findAll", query = "SELECT i FROM InventoryLog i"),
        @NamedQuery(name = "InventoryLogs.findByLogID", query = "SELECT i FROM InventoryLog i WHERE i.id = :logID"),
        @NamedQuery(name = "InventoryLogs.findByActionType", query = "SELECT i FROM InventoryLog i WHERE i.actionType = :actionType"),
        @NamedQuery(name = "InventoryLogs.findByQuantityChanged", query = "SELECT i FROM InventoryLog i WHERE i.quantityChanged = :quantityChanged"),
        @NamedQuery(name = "InventoryLogs.findByActionDate", query = "SELECT i FROM InventoryLog i WHERE i.actionDate = :actionDate"),
        @NamedQuery(name = "InventoryLogs.findByStoreLocation", query = "SELECT i FROM InventoryLog i WHERE i.storeLocation = :storeLocation")})
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