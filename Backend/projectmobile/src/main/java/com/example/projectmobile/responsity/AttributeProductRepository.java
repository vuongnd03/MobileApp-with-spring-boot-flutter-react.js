package com.example.projectmobile.responsity;

import com.example.projectmobile.model.AttributeProduct;
import com.example.projectmobile.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AttributeProductRepository extends JpaRepository<AttributeProduct, Integer> {
    List<AttributeProduct> findByProduct(Product product);
}
