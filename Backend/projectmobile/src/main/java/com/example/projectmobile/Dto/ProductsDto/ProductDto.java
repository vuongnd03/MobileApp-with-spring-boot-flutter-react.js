package com.example.projectmobile.Dto.ProductsDto;

import jakarta.persistence.Id;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class ProductDto {
    private String namesp;
    private int quantity;
    private BigDecimal price;
    private String desception;
    private String image_url;
    private LocalDateTime ngaytao;
    private int catalogproduct_id;

    private List<AttributeProductDto> attributeproduct;
    private List<ProductImageDto> productImageDto;
}
