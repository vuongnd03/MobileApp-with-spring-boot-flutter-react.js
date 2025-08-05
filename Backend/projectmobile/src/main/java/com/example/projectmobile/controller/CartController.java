package com.example.projectmobile.controller;

import com.example.projectmobile.Dto.CartDto.CartRequestDto;
import com.example.projectmobile.Dto.CartDto.CartResponseDTO;
import com.example.projectmobile.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cart")
public class CartController {
    @Autowired
    private CartService cartService;

    @PostMapping("/addcart")
    public ResponseEntity<String> addToCart(@RequestBody CartRequestDto cartRequestDto){
        System.out.println("Received request: " + cartRequestDto);
        cartService.addToCart(cartRequestDto);
        return ResponseEntity.ok("Đã thêm vào giỏ hàng");
    }

    @GetMapping("/getcart/{userId}")
    public ResponseEntity<List<CartResponseDTO>> gettocart(@PathVariable Integer userId){
        return ResponseEntity.ok(cartService.getCart(userId));
    }

    @DeleteMapping("/delete/{userId}/{productId}")
    public ResponseEntity<String> deletecart(@PathVariable Integer userId,@PathVariable Integer productId){
        String check =cartService.DeleteProductCart(userId,productId);
        return ResponseEntity.ok(check);
    }
}
