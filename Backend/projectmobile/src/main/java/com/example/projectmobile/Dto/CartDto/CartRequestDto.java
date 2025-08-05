package com.example.projectmobile.Dto.CartDto;

import lombok.Data;


@Data
public class CartRequestDto {
    private int userId;
    private int productId;
    private int quantity;
}
