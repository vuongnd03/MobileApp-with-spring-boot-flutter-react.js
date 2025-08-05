package com.example.projectmobile.Dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterDtoUser {
    private int user_id;
    private String name;
    private String numberphone;
    private String email;
    private String password;
    private String confirm_password;
}
