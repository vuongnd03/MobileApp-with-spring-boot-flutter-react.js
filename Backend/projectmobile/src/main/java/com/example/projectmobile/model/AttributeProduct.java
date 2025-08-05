package com.example.projectmobile.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "attribute_product")
public class AttributeProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "NameAttribute")
    private String nameAttribute;

    @Column(name = "value_attribute")
    private String valueAttribute;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
}
