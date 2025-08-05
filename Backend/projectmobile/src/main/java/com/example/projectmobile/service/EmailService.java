package com.example.projectmobile.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender javaMailSender;

    public  void sendOtpEmail(String toEmail, String otp){
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Mã otp xác thực");
        message.setText("Mã otp của bạn là: "+otp);
        message.setFrom("vuongnguyen251203@gmail.com");
        javaMailSender.send(message);
    }
}
