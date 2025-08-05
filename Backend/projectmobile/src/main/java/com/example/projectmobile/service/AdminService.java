package com.example.projectmobile.service;

import com.example.projectmobile.Dto.LoginAdminResponseDto;
import com.example.projectmobile.Dto.LoginDtoAdmin;
import com.example.projectmobile.Dto.RegisterDtoAdmin;
import com.example.projectmobile.exception.ResoutNotFoundException;
import com.example.projectmobile.model.Admin;
import com.example.projectmobile.responsity.AdminReponsity;
import com.example.projectmobile.security.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
    @Autowired
    private AdminReponsity adminReponsity;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    //đăng ký admin
    public String RegisterAdmin(RegisterDtoAdmin admindto){
        if(adminReponsity.findByemail(admindto.getEmail()).isPresent()){
            return "Email đã tồn tại!";
        }
        Admin admin = new Admin();
        admin.setNameAdmin(admindto.getNameAdmin());
        admin.setEmail(admindto.getEmail());
        admin.setPassword(passwordEncoder.encode(admindto.getPassword()));

        adminReponsity.save(admin);
        return "Đăng ký thành công!";
    }
    //Login Admin
    public LoginAdminResponseDto LoginAdmin(LoginDtoAdmin admindto){
        Admin admin = adminReponsity.findByemail(admindto.getEmail()).orElseThrow(()->new ResoutNotFoundException("Không tìm thấy tài khoản"));
        if(passwordEncoder.matches(admindto.getPassword(), admin.getPassword() )){
            String token = JwtUtils.generateToken(admin.getEmail());
            return new LoginAdminResponseDto("Đăng nhập thành công",token);
        }else {
            throw new ResoutNotFoundException("Sai mật khẩu");
        }
    }
}
