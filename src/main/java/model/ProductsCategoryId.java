package model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.util.Objects;

@Embeddable
public class ProductsCategoryId implements java.io.Serializable {
    private static final long serialVersionUID = -129903848673458314L;
    @Column(name = "ProductID", nullable = false)
    private Integer productID;

    @Column(name = "CategoryID", nullable = false)
    private Integer categoryID;

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public Integer getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Integer categoryID) {
        this.categoryID = categoryID;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        ProductsCategoryId entity = (ProductsCategoryId) o;
        return Objects.equals(this.productID, entity.productID) &&
                Objects.equals(this.categoryID, entity.categoryID);
    }

    @Override
    public int hashCode() {
        return Objects.hash(productID, categoryID);
    }

}