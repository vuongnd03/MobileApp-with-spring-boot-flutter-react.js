package com.example.projectmobile.Dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class LoginUserResponseDto {
    private int id;
    private String message;
    private String token;
}
