package com.example.projectmobile.responsity;


import com.example.projectmobile.model.ForgotPassword;
import com.example.projectmobile.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ForgotPasswordReponsity extends JpaRepository<ForgotPassword, Integer> {
    Optional<ForgotPassword> findByUserAndOtp(User user, String otp);
    Optional<ForgotPassword> findByUser(User user);
    void deleteByUser(User user);
}
