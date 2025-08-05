package com.example.projectmobile.controller;
import com.example.projectmobile.Dto.WishlistProduct.WishlistDto;
import com.example.projectmobile.Dto.WishlistProduct.WishlistReponsityDto;
import com.example.projectmobile.service.WishlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/wishlist")
public class WishlistController {
    @Autowired
    private WishlistService wishlistService;

    @PostMapping("/add_wishlist")
    public ResponseEntity<?> addtowishlist(@RequestBody WishlistReponsityDto wishlistDto){
        wishlistService.addToWishlist(wishlistDto);
        return ResponseEntity.ok("đã thêm sản pẩm vào mục yêu thích thành công");
    }

    @GetMapping("/get_wishlist/{userId}")
    public ResponseEntity<List<WishlistDto>> gettowislist(@PathVariable Integer userId){
        return ResponseEntity.ok(wishlistService.getToWishlist(userId));
    }

    @DeleteMapping("/delete/{userId}/{productId}")
    public ResponseEntity<String> removewishlist(
            @PathVariable Integer userId,
            @PathVariable Integer productId) {
        String message = wishlistService.deletewishlist(userId, productId);
        return ResponseEntity.ok(message);
    }

}
