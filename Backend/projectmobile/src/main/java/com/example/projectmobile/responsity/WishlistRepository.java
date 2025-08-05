package com.example.projectmobile.responsity;

import com.example.projectmobile.model.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface WishlistRepository extends JpaRepository<Wishlist, Integer> {
    //lấy ht tất cả wishlist của 1 user
    List<Wishlist> findByUser_UserId(Integer userId);
    //kiểm tra sản phẩm đã có trong wishlist hay chưa
    boolean existsByUser_UserIdAndProduct_Id(Integer userId, Integer productId);
    //xoá sản phẩm trong wishlist
    @Modifying
    @Transactional
    int deleteByUser_UserIdAndProduct_Id(Integer userId, Integer productId);
}
