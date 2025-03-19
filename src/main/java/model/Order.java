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
        @NamedQuery(name = "Order.findAll",
                query = "SELECT o FROM Order o"),
        @NamedQuery(name = "Order.findByUserId",
                query = "SELECT o FROM Order o WHERE o.userID.id = :userId"),
        @NamedQuery(name = "Order.findByStatus",
                query = "SELECT o FROM Order o WHERE o.status = :status"),
        @NamedQuery(name = "Order.findByOrderDate",
                query = "SELECT o FROM Order o WHERE o.orderDate = :orderDate"),
        @NamedQuery(name = "Order.findByTotalAmountGreaterThan",
                query = "SELECT o FROM Order o WHERE o.totalAmount > :amount"),
        @NamedQuery(name = "Order.findAllSortedByDate",
                query = "SELECT o FROM Order o ORDER BY o.orderDate DESC")
})
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "UserID", nullable = false, referencedColumnName = "UserID")
    private User userID;

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

    public User getUserID() {
        return userID;
    }

    public void setUserID(User userID) {
        this.userID = userID;
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