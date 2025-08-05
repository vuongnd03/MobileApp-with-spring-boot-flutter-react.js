package com.example.projectmobile.controller;

import com.example.projectmobile.Dto.ProductsDto.CatalogProductDTO;
import com.example.projectmobile.Dto.ProductsDto.CatalogReponseDto;
import com.example.projectmobile.Dto.ProductsDto.ProductDto;
import com.example.projectmobile.Dto.ProductsDto.ProductReponseDto;
import com.example.projectmobile.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/product")
public class productController {
    @Autowired
    private ProductService productService;

    //CRUD sản phẩm
    @PostMapping("/add_Catalog_Product")
    public ResponseEntity<?> add_catalog_product(@RequestBody CatalogProductDTO catalogProductDTO){
        productService.Add_Catalog_Product(catalogProductDTO);
        return ResponseEntity.ok("Thêm loại sản phẩm thành công");
    }
    @GetMapping("/All_Catalog")
    public ResponseEntity<List<CatalogReponseDto>> getAllCatalog(){
        return ResponseEntity.ok(productService.getCatalog());
    }
    @PostMapping("/add_product")
    public ResponseEntity<?> add_product(@RequestBody ProductDto productDto){
        productService.addproduct(productDto);
        return ResponseEntity.ok("Thêm sản phẩm thành công");
    }
    @GetMapping("/allProduct")
    public ResponseEntity<List<ProductReponseDto>> getAllProduct(){
        return ResponseEntity.ok(productService.getAllProducts());
    }
    @DeleteMapping("/Xoa_product/{id}")
    public ResponseEntity<?> delete_product(@PathVariable int id){
        productService.xoasanpham(id);
        return ResponseEntity.ok("Đã xóa sản phẩm và toàn bộ attribute, image liên quan!");
    }
    @GetMapping("/getproductBycatalog/{loaisp}")
    public ResponseEntity<List<ProductReponseDto>> getproductcatalog(@PathVariable String loaisp){
        List<ProductReponseDto> products = productService.getProductByCatalogName(loaisp);
        return ResponseEntity.ok(products);
    }
    @GetMapping("/SearchproductbyName/{namesp}")
    public ResponseEntity<List<ProductReponseDto>> getproductByname(@PathVariable String namesp){
        List<ProductReponseDto> productReponseDtos = productService.searchByName(namesp);
        return ResponseEntity.ok(productReponseDtos);
    }
}
