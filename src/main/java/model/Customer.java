package model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;

@Entity
@Table(name = "Customers")
@NamedQueries({
        @NamedQuery(name = "Customers.findAll", query = "SELECT c FROM Customer c"),
        @NamedQuery(name = "Customers.findByCustomerID", query = "SELECT c FROM Customer c WHERE c.id = :customerID"),
        @NamedQuery(name = "Customers.findByName", query = "SELECT c FROM Customer c WHERE c.name = :name"),
        @NamedQuery(name = "Customers.findByEmail", query = "SELECT c FROM Customer c WHERE c.email = :email"),
        @NamedQuery(name = "Customers.findByPasswordHash", query = "SELECT c FROM Customer c WHERE c.passwordHash = :passwordHash"),
        @NamedQuery(name = "Customers.findByPhone", query = "SELECT c FROM Customer c WHERE c.phone = :phone"),
        @NamedQuery(name = "Customers.findByAddress", query = "SELECT c FROM Customer c WHERE c.address = :address"),
        @NamedQuery(name = "Customers.findByRegistrationDate", query = "SELECT c FROM Customer c WHERE c.registrationDate = :registrationDate")})
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CustomerID", nullable = false)
    private Integer id;

    @Nationalized
    @Column(name = "Name", nullable = false, length = 100)
    private String name;

    @Nationalized
    @Column(name = "Email", nullable = false, length = 100)
    private String email;

    @Nationalized
    @Column(name = "PasswordHash", nullable = false)
    private String passwordHash;

    @Nationalized
    @Column(name = "Phone", length = 15)
    private String phone;

    @Nationalized
    @Lob
    @Column(name = "Address")
    private String address;

    @ColumnDefault("getdate()")
    @Column(name = "RegistrationDate")
    private Instant registrationDate;

    @ColumnDefault("'ACTIVE'")
    @Column(name = "Status", nullable = false, length = 10)
    private String status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Instant getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Instant registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}