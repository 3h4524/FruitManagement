package model;

import jakarta.persistence.*;
import org.hibernate.annotations.Nationalized;

import java.util.List;

@Entity
@Table(name = "Categories")
@NamedQueries({
        @NamedQuery(name = "Categories.findAll", query = "SELECT c FROM Category c"),
        @NamedQuery(name = "Categories.findByCategoryID", query = "SELECT c FROM Category c WHERE c.id = :categoryID"),
        @NamedQuery(name = "Categories.findByName", query = "SELECT c FROM Category c WHERE c.name LIKE :name"),
        @NamedQuery(name = "Categories.findByDescription", query = "SELECT c FROM Category c WHERE c.description = :description")})
public class Category {
    @Id
    @Column(name = "CategoryID", nullable = false)
    private Integer id;

    @Nationalized
    @Column(name = "Name", nullable = false, length = 100)
    private String name;


    @ManyToMany(mappedBy = "categories")
    private List<Product> products;

    @Nationalized
    @Lob
    @Column(name = "Description")
    private String description;

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

}