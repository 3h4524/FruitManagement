package model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

@Entity
@Table(name = "Products")
@NamedQueries({
        @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p"),
        @NamedQuery(name = "Product.findByProductID", query = "SELECT p FROM Product p WHERE p.id = :productID"),
        @NamedQuery(name = "Product.findByName", query = "SELECT p FROM Product p WHERE p.name LIKE :name"),
        @NamedQuery(name = "Product.findByDescription", query = "SELECT p FROM Product p WHERE p.description = :description"),
        @NamedQuery(name = "Product.findByImageURL", query = "SELECT p FROM Product p WHERE p.imageURL = :imageURL"),
        @NamedQuery(name = "Product.findByImportDate", query = "SELECT p FROM Product p WHERE p.importDate = :importDate")
})

public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductID", nullable = false)
    private Integer id;


    @Nationalized
    @Column(name = "Name", nullable = false, length = 100)
    private String name;

    @ManyToMany
    @JoinTable(
            name = "ProductsCategories",
            joinColumns = @JoinColumn(name = "productID"),
            inverseJoinColumns = @JoinColumn(name = "categoryID")
    )

    private List<Category> categories;

    @Nationalized
    @Lob
    @Column(name = "Description")
    private String description;

    @Nationalized
    @Column(name = "ImageURL")
    private String imageURL;


    @ColumnDefault("getdate()")
    @Column(name = "ImportDate")
    private Instant importDate;


    @Transient
    private BigDecimal price;


    @ColumnDefault("0")
    @Column(name = "IsDeleted")
    private Boolean isDeleted;

    @Transient
    private BigDecimal originalPrice;

    @Transient
    private BigDecimal discountPrice;

    @Transient
    private Integer discountPercent;
    @Transient

    private String displaySize;

    public String getDisplaySize() {
        return displaySize;
    }

    public void setDisplaySize(String displaySize) {
        this.displaySize = displaySize;
    }

    // Existing getters and setters...

    // Add getters and setters for new properties
    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    public BigDecimal getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(BigDecimal discountPrice) {
        this.discountPrice = discountPrice;
    }

    public Integer getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent;
    }




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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Instant getImportDate() {
        return importDate;
    }

    public void setImportDate(Instant importDate) {
        this.importDate = importDate;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

}