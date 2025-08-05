package com.example.projectmobile.responsity;

import com.example.projectmobile.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Integer> {
    Optional<Product> findById(Integer id);
    @Query("SELECT p FROM Product p JOIN p.catalogproduct c WHERE LOWER(c.loaisp) = LOWER(:loaisp)")
    List<Product> findByCatalogName(@Param("loaisp") String loaisp);
    List<Product> findByNamespContainingIgnoreCase(String namesp);
}
