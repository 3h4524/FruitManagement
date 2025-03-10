package model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "Inventory")
@NamedQueries({@NamedQuery(name = "Inventory.findAll", query = "SELECT i FROM Inventory i"),
        @NamedQuery(name = "Inventory.findByInventoryID", query = "SELECT i FROM Inventory i WHERE i.id = :inventoryID"),
        @NamedQuery(name = "Inventory.findByStoreLocation", query = "SELECT i FROM Inventory i WHERE i.storeLocation = :storeLocation")})
public class Inventory {
    @Id
    @Column(name = "InventoryID", nullable = false)
    private Integer id;

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


    public String getStoreLocation() {
        return storeLocation;
    }

    public void setStoreLocation(String storeLocation) {
        this.storeLocation = storeLocation;
    }

}