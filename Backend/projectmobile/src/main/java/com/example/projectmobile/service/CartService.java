package com.example.projectmobile.service;

import com.example.projectmobile.Dto.CartDto.CartRequestDto;
import com.example.projectmobile.Dto.CartDto.CartResponseDTO;
import com.example.projectmobile.exception.ResoutNotFoundException;
import com.example.projectmobile.model.Cart;
import com.example.projectmobile.model.Product;
import com.example.projectmobile.model.User;
import com.example.projectmobile.responsity.CartReponsitory;
import com.example.projectmobile.responsity.ProductRepository;
import com.example.projectmobile.responsity.UserReponsity;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class CartService {
    @Autowired
    private CartReponsitory cartReponsitory;
    @Autowired
    private UserReponsity userReponsity;
    @Autowired
    private ProductRepository productRepository;

    public void addToCart(CartRequestDto cartRequestDto) {
        try {
            User user = userReponsity.findById(cartRequestDto.getUserId())
                    .orElseThrow(() -> new ResoutNotFoundException("User không tồn tại!"));
            Product product = productRepository.findById(cartRequestDto.getProductId())
                    .orElseThrow(() -> new ResoutNotFoundException("Sản phẩm không tồn tại!"));

            // Kiểm tra số lượng yêu cầu hợp lệ
            if (cartRequestDto.getQuantity() <= 0) {
                throw new IllegalArgumentException("Số lượng thêm vào giỏ phải lớn hơn 0.");
            }

            // Lấy giỏ hàng hiện có nếu tồn tại
            Cart existingCart = cartReponsitory.findByUser_UserIdAndProduct_Id(
                    cartRequestDto.getUserId(), cartRequestDto.getProductId());

            if (existingCart != null) {
                int tongSoLuong = existingCart.getQuantity() + cartRequestDto.getQuantity();

                if (tongSoLuong > product.getQuantity()) {
                    throw new ResoutNotFoundException("Tổng số lượng vượt quá tồn kho hiện có ("
                            + product.getQuantity() + ")");
                }
                existingCart.setQuantity(tongSoLuong);
                existingCart.setNgaytao(LocalDateTime.now());
                cartReponsitory.save(existingCart);
            } else {
                if (cartRequestDto.getQuantity() > product.getQuantity()) {
                    throw new ResoutNotFoundException("Số lượng trong kho không đủ. Hiện có: "
                            + product.getQuantity());
                }
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setProduct(product);
                newCart.setQuantity(cartRequestDto.getQuantity());
                newCart.setNgaytao(LocalDateTime.now());
                cartReponsitory.save(newCart);
            }
        } catch (ResoutNotFoundException ex) {
            System.err.println("Lỗi dữ liệu không hợp lệ: " + ex.getMessage());
            throw ex;
        } catch (IllegalArgumentException ex) {
            System.err.println("Lỗi tham số: " + ex.getMessage());
            throw ex;
        } catch (Exception ex) {
            System.err.println("Lỗi không xác định khi thêm vào giỏ hàng: " + ex.getMessage());
            ex.printStackTrace();
            throw new RuntimeException("Đã xảy ra lỗi khi thêm vào giỏ hàng.");
        }
    }

    public List<CartResponseDTO> getCart(Integer userId){
        try {
            List<Cart> carts = cartReponsitory.findByUser_UserId(userId);
            if (carts == null || carts.isEmpty()) {
                throw new ResoutNotFoundException("Không tìm thấy giỏ hàng cho user có ID: " + userId);
            }
            return carts.stream().map(cart -> {
                CartResponseDTO Dto = new CartResponseDTO();
                Dto.setProductId(cart.getProduct().getId());
                Dto.setNamesp(cart.getProduct().getNamesp());
                Dto.setPrice(cart.getProduct().getPrice());
                Dto.setImage_url(cart.getProduct().getImage_url());
                Dto.setQuantity(cart.getQuantity());
                // Giải thích: tổng giá = giá * số lượng
                Dto.setTotalprice(
                        cart.getProduct().getPrice()
                                .multiply(BigDecimal.valueOf(cart.getQuantity()))
                );
                return Dto;
            }).toList();
        }catch (Exception e){
            System.err.println("Lỗi khi lấy giỏ hàng: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    //xoá sản phẩm trong giỏ hàng
    public String DeleteProductCart(int userId,int productId){
        try {
            int deletecount = cartReponsitory.deleteByUser_UserIdAndProduct_Id(userId, productId);
            if (deletecount == 0){
                throw new ResoutNotFoundException("Không tìm thấy sản phẩm tgrong giỏ hàng để xoá");
            }
            return "Đã xoá thành công";
        }catch (Exception e){
            throw new ResoutNotFoundException("Lỗi: "+e.getMessage());
        }
    }

}
