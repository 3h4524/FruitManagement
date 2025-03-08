package model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;
import java.time.Instant;

@Entity
@Table(name = "Orders")
@NamedQueries({
        @NamedQuery(name = "Orders.findAll", query = "SELECT o FROM Order o"),
        @NamedQuery(name = "Orders.findByOrderID", query = "SELECT o FROM Order o WHERE o.id = :orderID"),
        @NamedQuery(name = "Orders.findByOrderDate", query = "SELECT o FROM Order o WHERE o.orderDate = :orderDate"),
        @NamedQuery(name = "Orders.findByTotalAmount", query = "SELECT o FROM Order o WHERE o.totalAmount = :totalAmount"),
        @NamedQuery(name = "Orders.findByStatus", query = "SELECT o FROM Order o WHERE o.status = :status")})
public class Order {
    @Id
    @Column(name = "OrderID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "CustomerID", nullable = false)
    private Customer customerID;

    @ColumnDefault("getdate()")
    @Column(name = "OrderDate")
    private Instant orderDate;

    @Column(name = "TotalAmount", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalAmount;

    @Nationalized
    @ColumnDefault("'Pending'")
    @Column(name = "Status", length = 50)
    private String status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Customer getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Customer customerID) {
        this.customerID = customerID;
    }

    public Instant getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Instant orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}