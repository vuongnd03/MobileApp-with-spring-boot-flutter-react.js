package com.example.projectmobile.Dto.ResetPasswordDto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class OtpRequest {
    private String email;
    private String otp;
}
