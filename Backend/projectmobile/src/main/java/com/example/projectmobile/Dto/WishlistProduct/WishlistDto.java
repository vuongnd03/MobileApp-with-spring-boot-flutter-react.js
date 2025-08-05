package com.example.projectmobile.Dto.WishlistProduct;

import lombok.Data;

import java.math.BigDecimal;
@Data
public class WishlistDto {
    private int product_id;
    private String namesp;
    private BigDecimal price;
    private String image_url;


    public WishlistDto(int id, String namesp, BigDecimal price, String imageUrl) {
        this.product_id = id;
        this.namesp = namesp;
        this.price = price;
        this.image_url = imageUrl;
    }
}
