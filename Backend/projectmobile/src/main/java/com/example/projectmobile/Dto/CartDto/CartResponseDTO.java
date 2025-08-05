package com.example.projectmobile.Dto.CartDto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
@Getter
@Setter
public class CartResponseDTO {
    private int productId;
    private String namesp;
    private BigDecimal price;
    private int quantity;
    private String image_url;
    private BigDecimal totalprice;
}
