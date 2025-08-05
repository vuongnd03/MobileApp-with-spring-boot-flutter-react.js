package com.example.projectmobile.service;

import com.example.projectmobile.Dto.WishlistProduct.WishlistDto;
import com.example.projectmobile.Dto.WishlistProduct.WishlistReponsityDto;
import com.example.projectmobile.exception.ResoutNotFoundException;
import com.example.projectmobile.model.Product;
import com.example.projectmobile.model.User;
import com.example.projectmobile.model.Wishlist;
import com.example.projectmobile.responsity.ProductRepository;
import com.example.projectmobile.responsity.UserReponsity;
import com.example.projectmobile.responsity.WishlistRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class WishlistService {
    @Autowired
    private WishlistRepository wishlistRepository;
    @Autowired
    private UserReponsity userReponsity;
    @Autowired
    private ProductRepository productRepository;
    //Thêm sản phẩm yêu thích
    public void addToWishlist(WishlistReponsityDto wishlistDto){
        if(wishlistRepository.existsByUser_UserIdAndProduct_Id(wishlistDto.getUser_id(),wishlistDto.getProduct_id())){
            throw new ResoutNotFoundException("Sản phẩm này đã nằm trong mục yêu thích");
        }

        User user = userReponsity.findById(wishlistDto.getUser_id()).orElseThrow(() -> new ResoutNotFoundException("User không tồn tại"));
        Product product = productRepository.findById(wishlistDto.getProduct_id()).orElseThrow(() -> new ResoutNotFoundException("Product không tồn tại"));

        Wishlist wishlist = new Wishlist();
        wishlist.setUser(user);
        wishlist.setProduct(product);
        wishlistRepository.save(wishlist);
    }
    //lấy sản phẩm yêu thích
    public List<WishlistDto> getToWishlist(Integer userId){
        return wishlistRepository.findByUser_UserId(userId).stream()
                .map(w -> new WishlistDto(
                        w.getProduct().getId(),
                        w.getProduct().getNamesp(),
                        w.getProduct().getPrice(),
                        w.getProduct().getImage_url()
                )).toList();
    }
    //xoá sản phẩm yêu thích
    public String deletewishlist(Integer userId,Integer productId) {
        try {
            int check = wishlistRepository.deleteByUser_UserIdAndProduct_Id(userId,productId);
            if (check == 0){
                throw new ResoutNotFoundException("Sản phẩm không tồn tại trong giỏ hàng");
            }
            return "Đã xoá thành công";
        } catch (Exception e) {
            throw new ResoutNotFoundException("Lỗi: "+e.getMessage());
        }

    }
}
