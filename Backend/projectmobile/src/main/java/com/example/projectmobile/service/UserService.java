package com.example.projectmobile.service;

import com.example.projectmobile.Dto.LoginDtoUser;
import com.example.projectmobile.Dto.LoginUserResponseDto;
import com.example.projectmobile.Dto.RegisterDtoUser;
import com.example.projectmobile.Dto.ResetPasswordDto.ForgotPasswordDto;
import com.example.projectmobile.Dto.ResetPasswordDto.OtpRequest;
import com.example.projectmobile.Dto.ResetPasswordDto.ResetPasswordRequest;
import com.example.projectmobile.exception.ResoutNotFoundException;
import com.example.projectmobile.model.ForgotPassword;
import com.example.projectmobile.model.User;
import com.example.projectmobile.responsity.ForgotPasswordReponsity;
import com.example.projectmobile.responsity.UserReponsity;
import com.example.projectmobile.security.JwtUtils;
import com.example.projectmobile.security.generateOTP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserReponsity userReponsity;
    @Autowired
    private JavaMailSender javaMailSender;
    @Autowired
    private ForgotPasswordReponsity forgotPasswordReponsity;
    @Autowired
    private EmailService emailService;

    private final BCryptPasswordEncoder passwordEncoder= new BCryptPasswordEncoder();

    //đăng ký User
    public String registerUser(RegisterDtoUser userdto){
        if(!userdto.getPassword().equals(userdto.getConfirm_password())){
            throw new ResoutNotFoundException("Mật khẩu vaf xác nhận mật khẩu không khơp");
        }
        if(userReponsity.findByemail(userdto.getEmail()).isPresent()){
            throw new ResoutNotFoundException("Email đã tồn tại!");
        }

        User user = new User();
        user.setName(userdto.getName());
        user.setNumberphone(userdto.getNumberphone());
        user.setEmail(userdto.getEmail());
        user.setPassword(passwordEncoder.encode(userdto.getPassword()));

        userReponsity.save(user);
        return "Đăng ký thành công";
    }

    //login User
    public LoginUserResponseDto LoginUser(LoginDtoUser userdto){
        User user = userReponsity.findByemail(userdto.getEmail()).orElseThrow(() -> new ResoutNotFoundException("Không tìm thấy tài khoản!"));
        if (passwordEncoder.matches(userdto.getPassword(), user.getPassword())){
            String token = JwtUtils.generateToken(user.getEmail());
            return new LoginUserResponseDto(user.getUserId(), "Đăng nhập thành công", token);
        }else {
            throw new ResoutNotFoundException("sai mật khẩu");
        }
    }
    //forgot password
    public String sendotp(ForgotPasswordDto forgotpassdto) {
        try {
            // Tìm user từ email
            User user = userReponsity.findByemail(forgotpassdto.getEmail())
                    .orElseThrow(() -> new ResoutNotFoundException("Email không tồn tại!"));

            String otp = generateOTP.generateOtp();

            // Xoá mã OTP cũ nếu có
            forgotPasswordReponsity.deleteByUser(user);
            // Tạo bản ghi mới
            ForgotPassword forgot = new ForgotPassword();
            forgot.setOtp(otp);
            forgot.setRealtime(LocalDateTime.now());
            forgot.setUser(user);

            forgotPasswordReponsity.save(forgot);
            // Gửi email
            emailService.sendOtpEmail(user.getEmail(), otp);
            return "OTP đã được gửi đến email của bạn.";
        } catch (ResoutNotFoundException ex) {
            throw ex;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException("Đã xảy ra lỗi khi gửi OTP. Vui lòng thử lại sau.", ex);

        }
    }
    //kiểm tra otp và đổi mật khẩu
    public String resetPassword(ResetPasswordRequest request) {
        User user = userReponsity.findByemail(request.getEmail())
                .orElseThrow(() -> new ResoutNotFoundException("Email không tồn tại!"));

        ForgotPassword forgot = forgotPasswordReponsity.findByUserAndOtp(user, request.getOtp())
                .orElseThrow(() -> new ResoutNotFoundException("Mã OTP không chính xác!"));

        // Đổi mật khẩu (mã hoá nếu có dùng BCrypt)
        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userReponsity.save(user);

        // Xoá OTP sau khi dùng (tuỳ logic)
        forgotPasswordReponsity.delete(forgot);

        return "Đổi mật khẩu thành công!";
    }




}
