package com.example.projectmobile.security;

import java.security.SecureRandom;

public class generateOTP {
    public static String generateOtp(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < length; i++) {
            sb.append(random.nextInt(10)); // Tạo số từ 0 đến 9
        }
        return sb.toString();
    }
    public static String generateOtp() {
        return generateOtp(6);
    }
}
