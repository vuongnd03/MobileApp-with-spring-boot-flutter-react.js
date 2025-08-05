package com.example.projectmobile.responsity;

import com.example.projectmobile.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


public interface CartReponsitory extends JpaRepository<Cart,Integer> {
    // Tìm danh sách Cart theo user_id
    List<Cart> findByUser_UserId(Integer userId);
    // Kiểm tra sản phẩm đã có trong giỏ chưa (để tăng số lượng thay vì thêm mới)
    Cart findByUser_UserIdAndProduct_Id(Integer userId, Integer productId);
    //xoá sản phẩm trong giỏ hàng
    @Modifying
    @Transactional
    int deleteByUser_UserIdAndProduct_Id(Integer userId, Integer productId);
}
