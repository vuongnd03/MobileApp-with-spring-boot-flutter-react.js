package com.example.projectmobile.Dto.ProductsDto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

import java.util.List;
@Getter
@Setter
public class ProductReponseDto {
    private int id;
    private String namesp;
    private int quantity;
    private BigDecimal price;
    private String desception;
    private String image_url;
    private List<AttributeProductDto> attributeproduct;
    private List<ProductImageDto> productImageDto;
}
