package com.example.projectmobile.service;
import com.example.projectmobile.Dto.ProductsDto.*;
import com.example.projectmobile.exception.ResoutNotFoundException;
import com.example.projectmobile.model.AttributeProduct;
import com.example.projectmobile.model.Catalogproduct;
import com.example.projectmobile.model.Product;
import com.example.projectmobile.model.ProductImage;
import com.example.projectmobile.responsity.AttributeProductRepository;
import com.example.projectmobile.responsity.CatalogproductRepository;
import com.example.projectmobile.responsity.ProductImageReponsity;
import com.example.projectmobile.responsity.ProductRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class ProductService {
    @Autowired
    private CatalogproductRepository catalogproductRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private AttributeProductRepository attributeProductRepository;
    @Autowired
    private ProductImageReponsity productImageReponsity;

    //thêm loại sản phẩm
    public void Add_Catalog_Product(CatalogProductDTO catalogProductDTO){
        Catalogproduct catalogproduct = new Catalogproduct();
        catalogproduct.setLoaisp(catalogProductDTO.getLoaisp());
        catalogproduct.setNgaytao(catalogProductDTO.getNgaytao());
        catalogproductRepository.save(catalogproduct);

    }
    //xoá loại sản phẩm
    public void delete(int id){
        if(!catalogproductRepository.existsById(id)) {
            throw new ResoutNotFoundException("Loại sản phẩm này không tồn tại!");
        }
        catalogproductRepository.deleteById(id);
    }
    //update loại sản phẩm
    public void update(int id,CatalogProductDTO catalogProductDTO){
        Catalogproduct catalogproduct = catalogproductRepository.findById(id).orElseThrow(()-> new ResoutNotFoundException("Loại sản phẩm không tồn tại"));
        catalogproduct.setLoaisp(catalogProductDTO.getLoaisp());
        catalogproduct.setNgaytao(catalogProductDTO.getNgaytao());
        catalogproductRepository.save(catalogproduct);
    }
    //Hiển thị hết tất cả loại sản phẩm
    public List<CatalogReponseDto> getCatalog(){
        List<Catalogproduct> catalogproducts = catalogproductRepository.findAll();

        return catalogproducts.stream().map(catalogproduct -> {
            CatalogReponseDto dto = new CatalogReponseDto();
            dto.setId(catalogproduct.getId());
            dto.setLoaisp(catalogproduct.getLoaisp());
            return dto;
        }).toList();
    }
    //thêm sản phẩm
    public void addproduct(ProductDto productDto){
        Catalogproduct catalogproduct = catalogproductRepository.findById(productDto.getCatalogproduct_id()).orElseThrow(()-> new ResoutNotFoundException("Không tìm thấy loại sản phẩm"));
        Product product = new Product();
        product.setNamesp(productDto.getNamesp());
        product.setQuantity(productDto.getQuantity());
        product.setPrice(productDto.getPrice());
        product.setDesception(productDto.getDesception());
        product.setImage_url(productDto.getImage_url());
        product.setNgaytao(productDto.getNgaytao());
        product.setCatalogproduct(catalogproduct);

        Product savedproduct = productRepository.save(product);
        //thêm các thuộc tính
        if(productDto.getAttributeproduct() != null && !productDto.getAttributeproduct().isEmpty()){
            for(AttributeProductDto attrDto : productDto.getAttributeproduct()){
                AttributeProduct attr = new AttributeProduct();
                attr.setProduct(product);
                attr.setNameAttribute(attrDto.getNameAttribute());
                attr.setValueAttribute(attrDto.getValueAttribute());
                attributeProductRepository.save(attr);
            }
        }
        //Thêm các ảnh phụ
        if(productDto.getProductImageDto() != null){
            List<ProductImageDto> imageDtoList = productDto.getProductImageDto();
            if(imageDtoList.size() > 6){
                throw new ResoutNotFoundException("chi duoc them 6 anh");
            }
            for(ProductImageDto attrDto : imageDtoList){
                ProductImage productImage = new ProductImage();
                productImage.setProduct(product);
                productImage.setImage_url(attrDto.getImage_url());
                productImageReponsity.save(productImage);
            }
        }
    }
    //update sản phẩm
    public void updateproduct(Integer id,ProductDto productDto){
        Product product = productRepository.findById(id).orElseThrow(() -> new ResoutNotFoundException("Không tìm thấy sản phẩm"));

        product.setNamesp(productDto.getNamesp());
        product.setQuantity(productDto.getQuantity());
        product.setPrice(productDto.getPrice());
        product.setDesception(productDto.getDesception());
        product.setImage_url(productDto.getImage_url());
        product.setNgaytao(productDto.getNgaytao());
        productRepository.save(product);
        }

    //lấy sản phẩm
    public List<ProductReponseDto> getAllProducts() {
        List<Product> products = productRepository.findAll();

        return products.stream().map(product -> {
            ProductReponseDto dto = new ProductReponseDto();
            dto.setId(product.getId());
            dto.setNamesp(product.getNamesp());
            dto.setQuantity(product.getQuantity());
            dto.setPrice(product.getPrice());
            dto.setDesception(product.getDesception());
            dto.setImage_url(product.getImage_url());

            // Lấy danh sách thuộc tính
            List<AttributeProduct> attributes = attributeProductRepository.findByProduct(product);
            List<AttributeProductDto> attrDtoList = attributes.stream().map(attr -> {
                AttributeProductDto attrDto = new AttributeProductDto();
                attrDto.setNameAttribute(attr.getNameAttribute());
                attrDto.setValueAttribute(attr.getValueAttribute());
                return attrDto;
            }).toList();
            dto.setAttributeproduct(attrDtoList);

            // Lấy danh sách ảnh phụ
            List<ProductImage> images = productImageReponsity.findByProduct(product);
            List<ProductImageDto> imgDtoList = images.stream().map(img -> {
                ProductImageDto imgDto = new ProductImageDto();
                imgDto.setImage_url(img.getImage_url());
                return imgDto;
            }).toList();
            dto.setProductImageDto(imgDtoList);

            return dto;
        }).toList();
    }
    //xoá sản phẩm
    public void xoasanpham(int id) {
        Product product = productRepository.findById(id).orElseThrow(() -> new ResoutNotFoundException("Sản phẩm không tồn tại"));
        productRepository.delete(product);
    }//tìm kiếm sản phẩm
    public List<ProductReponseDto> searchByName(String namesp){
        List<Product> products = productRepository.findByNamespContainingIgnoreCase(namesp);
        if(products.isEmpty()){
            throw new ResoutNotFoundException("Không có sản phẩm nào tên "+ namesp);
        }
        return products.stream().map( product -> {
            ProductReponseDto dto = new ProductReponseDto(

            );
            dto.setId(product.getId());
            dto.setNamesp(product.getNamesp());
            dto.setQuantity(product.getQuantity());
            dto.setPrice(product.getPrice());
            dto.setDesception(product.getDesception());
            dto.setImage_url(product.getImage_url());

            // Lấy danh sách thuộc tính
            List<AttributeProduct> attributes = attributeProductRepository.findByProduct(product);
            List<AttributeProductDto> attrDtoList = attributes.stream().map(attr -> {
                AttributeProductDto attrDto = new AttributeProductDto();
                attrDto.setNameAttribute(attr.getNameAttribute());
                attrDto.setValueAttribute(attr.getValueAttribute());
                return attrDto;
            }).toList();
            dto.setAttributeproduct(attrDtoList);

            // Lấy danh sách ảnh phụ
            List<ProductImage> images = productImageReponsity.findByProduct(product);
            List<ProductImageDto> imgDtoList = images.stream().map(img -> {
                ProductImageDto imgDto = new ProductImageDto();
                imgDto.setImage_url(img.getImage_url());
                return imgDto;
            }).toList();
            dto.setProductImageDto(imgDtoList);
            return dto;
        }).toList();
    }

    //Lấy sản phẩm theo danh mục
    public List<ProductReponseDto> getProductByCatalogName(String loaisp){
        List<Product> products = productRepository.findByCatalogName(loaisp);
        if (products.isEmpty()){
            throw new ResoutNotFoundException("Không tìm thấy sản phẩm thuộc danh mục " + loaisp);
        }
        return products.stream().map(product -> {
            ProductReponseDto dto = new ProductReponseDto();
            dto.setId(product.getId());
            dto.setNamesp(product.getNamesp());
            dto.setQuantity(product.getQuantity());
            dto.setPrice(product.getPrice());
            dto.setDesception(product.getDesception());
            dto.setImage_url(product.getImage_url());

            // Map thuộc tính
            List<AttributeProduct> attributes = attributeProductRepository.findByProduct(product);
            List<AttributeProductDto> attrDtoList = attributes.stream().map(attr -> {
                AttributeProductDto attrDto = new AttributeProductDto();
                attrDto.setNameAttribute(attr.getNameAttribute());
                attrDto.setValueAttribute(attr.getValueAttribute());
                return attrDto;
            }).toList();
            dto.setAttributeproduct(attrDtoList);

            // Map ảnh phụ
            List<ProductImage> images = productImageReponsity.findByProduct(product);
            List<ProductImageDto> imgDtoList = images.stream().map(img -> {
                ProductImageDto imgDto = new ProductImageDto();
                imgDto.setImage_url(img.getImage_url());
                return imgDto;
            }).toList();
            dto.setProductImageDto(imgDtoList);

            return dto;
        }).toList();
    }
}
