package model;

import jakarta.persistence.*;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;
@NamedQueries({
        @NamedQuery(name = "ProductVariant.findAll",
                query = "SELECT p FROM ProductVariant p"),

        @NamedQuery(name = "ProductVariant.findById",
                query = "SELECT p FROM ProductVariant p WHERE p.id = :id"),

        @NamedQuery(name = "ProductVariant.findByProductID",
                query = "SELECT p FROM ProductVariant p WHERE p.productID.id = :productID"),

        @NamedQuery(name = "ProductVariant.findBySize",
                query = "SELECT p FROM ProductVariant p WHERE p.size = :size"),

        @NamedQuery(name = "ProductVariant.findByPriceRange",
                query = "SELECT p FROM ProductVariant p WHERE p.price BETWEEN :minPrice AND :maxPrice"),
        @NamedQuery(name="ProductVariant.listWithOffset",
                query = "SELECT p FROM ProductVariant p ORDER BY p.id")
})
@Entity
public class ProductVariant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductVariantID", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "ProductID", nullable = false)
    private Product productID;

    @Nationalized
    @Column(name = "\"Size\"", nullable = false, length = 50)
    private String size;

    @Column(name = "Price", nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Product getProductID() {
        return productID;
    }

    public void setProductID(Product productID) {
        this.productID = productID;
    }


    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

}