package com.example.projectmobile.responsity;

import com.example.projectmobile.model.Product;
import com.example.projectmobile.model.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductImageReponsity extends JpaRepository<ProductImage, Integer> {
    List<ProductImage> findByProduct(Product product);

}
