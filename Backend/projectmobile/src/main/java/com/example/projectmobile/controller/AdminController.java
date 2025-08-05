package com.example.projectmobile.controller;

import com.example.projectmobile.Dto.LoginAdminResponseDto;
import com.example.projectmobile.Dto.LoginDtoAdmin;
import com.example.projectmobile.Dto.RegisterDtoAdmin;
import com.example.projectmobile.exception.ResoutNotFoundException;
import com.example.projectmobile.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin")
@CrossOrigin(origins = "http://localhost:5173")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @PostMapping("/RegisterAdmin")
    public ResponseEntity<?> registeradmin(@RequestBody RegisterDtoAdmin admindto){
        String result = adminService.RegisterAdmin(admindto);
        return ResponseEntity.ok(result);
    }

    @PostMapping("/LoginAdmin")
    public  ResponseEntity<?> loginadmin(@RequestBody LoginDtoAdmin admindto){
        try {
            LoginAdminResponseDto result = adminService.LoginAdmin(admindto);
            return ResponseEntity.ok(result);
        }catch (ResoutNotFoundException e){
            return ResponseEntity.status(401).body(new LoginAdminResponseDto(e.getMessage(),null));
        }
    }
}
