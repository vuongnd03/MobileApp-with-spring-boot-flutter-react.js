package com.example.projectmobile.controller;

import com.example.projectmobile.Dto.LoginDtoUser;
import com.example.projectmobile.Dto.LoginUserResponseDto;
import com.example.projectmobile.Dto.RegisterDtoUser;
import com.example.projectmobile.Dto.ResetPasswordDto.ForgotPasswordDto;
import com.example.projectmobile.Dto.ResetPasswordDto.OtpRequest;
import com.example.projectmobile.Dto.ResetPasswordDto.ResetPasswordRequest;
import com.example.projectmobile.exception.ResoutNotFoundException;
import com.example.projectmobile.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping("/registerUser")
    public ResponseEntity<?> register(@RequestBody RegisterDtoUser userdto){
        String result =userService.registerUser(userdto);
        return ResponseEntity.ok(result);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginDtoUser userdto){
        try {
            LoginUserResponseDto result = userService.LoginUser(userdto);
            return ResponseEntity.ok(result);
        }catch (ResoutNotFoundException e){
            return ResponseEntity.status(401).body(new LoginUserResponseDto(0,e.getMessage(),null));
        }
    }

    @PostMapping("/forgotpassword")
    public ResponseEntity<?> sendotp(@RequestBody ForgotPasswordDto forgotPasswordDto) {
        try {
            String result = userService.sendotp(forgotPasswordDto);
            return ResponseEntity.ok(result);
        }catch (ResoutNotFoundException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    @PostMapping("/reset-password")
    public ResponseEntity<String> resetPassword(@RequestBody ResetPasswordRequest request) {
        String result = userService.resetPassword(request);
        return ResponseEntity.ok(result);
    }


}
