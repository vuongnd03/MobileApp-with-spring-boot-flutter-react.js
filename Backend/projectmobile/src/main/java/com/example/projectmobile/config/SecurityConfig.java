package com.example.projectmobile.config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.config.http.SessionCreationPolicy;

@Configuration
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(
                                "/api/user/registerUser", "/api/user/login", "/api/user/forgotpassword", "/api/user/reset-password",
                                "/api/admin/RegisterAdmin", "/api/admin/LoginAdmin",
                                "/api/product/add_Catalog_Product", "/api/product/add_product",
                                "/api/product/allProduct", "/api/product/Xoa_product/{id}" ,
                                "/api/product/All_Catalog",
                                "/api/wishlist/add_wishlist", "/api/wishlist/get_wishlist/{userId}",
                                "/api/wishlist/delete/{userId}/{productId}",
                                "/api/product/getproductBycatalog/{loaisp}",
                                "/api/product/SearchproductbyName/{namesp}",
                                "/api/cart/addcart",
                                "/api/cart/getcart/{userId}",
                                "/api/cart/delete/{userId}/{productId}",
                                "/images/**",
                                "/swagger-ui/**", "/v3/api-docs/**"
                        ).permitAll()
                        .anyRequest().authenticated()
                )
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .build();
    }
}
