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
        @NamedQuery(name = "InventoryLogs.findByStoreLocation", query = "SELECT i FROM InventoryLog i WHERE i.storeLocation = :storeLocation"),
        @NamedQuery(name = "InventoryLogs.findByProductVariant", query = "SELECT i FROM InventoryLog i WHERE i.productVariantID.id = :productVariantID"),
        @NamedQuery(name="InventoryLogs.listWithOffset",
                query = "SELECT i FROM InventoryLog i ORDER BY i.id")
})
public class InventoryLog {
    @Id
    @Column(name = "LogID", nullable = false)
    private Integer id;

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