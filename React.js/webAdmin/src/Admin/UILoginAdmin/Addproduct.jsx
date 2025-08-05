import { useState } from "react";
import axios from "axios";
import { useOutletContext } from "react-router-dom";
import styles from "./Addproduct.module.css";

export default function Addproduct({ onProductAdded }) {
  const { fetchProducts } = useOutletContext();

  const [product, setProduct] = useState({
    id: "",
    name: "",
    price: 0,
    quantity: 0,
    imageFile: "",
    description: "",
    imagePreview: null,
    subImages: [null, null, null, null, null, null],
    nameAttribute: "", // NEW
    valueAttribute: "", // NEW
  });

  const [loading, setLoading] = useState(false);
  const [successMessage, setSuccessMessage] = useState("");
  const [errorMessage, setErrorMessage] = useState("");

  const handleChange = (e) => {
    const { name, value } = e.target;
    setProduct((prev) => ({
      ...prev,
      [name]: name === "price" || name === "quantity" ? Number(value) : value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setSuccessMessage("");
    setErrorMessage("");

    try {
      const productImageDto = product.subImages
        .filter(Boolean)
        .map((file) => ({
          image_url: file.name,
        }));

      const payload = {
        namesp: product.name,
        quantity: product.quantity,
        price: product.price,
        desception: product.description,
        image_url: product.imageFile.name,
        ngaytao: new Date().toISOString(),
        catalogproduct_id: parseInt(product.id),
        attributeproduct: [
          {
            nameAttribute: product.nameAttribute,
            valueAttribute: product.valueAttribute,
          },
        ],
        productImageDto,
      };

      const response = await axios.post("/api/product/add_product", payload, {
        headers: { "Content-Type": "application/json" },
      });

      setSuccessMessage("✅ Thêm sản phẩm thành công!");
      setProduct({
        id: "",
        name: "",
        price: 0,
        quantity: 0,
        imageFile: "",
        description: "",
        imagePreview: null,
        subImages: [null, null, null, null, null, null],
        nameAttribute: "",
        valueAttribute: "",
      });
      fetchProducts();
      if (onProductAdded) onProductAdded(response.data.product);
    } catch (error) {
      console.error("❌ Lỗi khi thêm sản phẩm:", error);
      setErrorMessage(
        error.response?.data?.message ||
          "Không thể thêm sản phẩm. Vui lòng thử lại sau."
      );
    } finally {
      setLoading(false);
    }
  };

  const handleSubImageChange = (e, index) => {
    const file = e.target.files[0];
    if (file) {
      const updatedSubImages = [...product.subImages];
      updatedSubImages[index] = file;
      setProduct({ ...product, subImages: updatedSubImages });
    }
  };

  return (
    <div className={styles.addProductContainer}>
      <h2>Thêm sản phẩm mới</h2>

      {successMessage && (
        <div className={styles.successMessage}>{successMessage}</div>
      )}
      {errorMessage && (
        <div className={styles.errorMessage}>{errorMessage}</div>
      )}

      <form onSubmit={handleSubmit} className={styles.productForm}>
        {/* Các trường cũ */}
        <div className={styles.formGroup}>
          <label htmlFor="id">ID Danh mục (catalogproduct_id):</label>
          <input
            type="text"
            id="id"
            name="id"
            value={product.id}
            onChange={handleChange}
            required
          />
        </div>

        <div className={styles.formGroup}>
          <label htmlFor="name">Tên sản phẩm:</label>
          <input
            type="text"
            id="name"
            name="name"
            value={product.name}
            onChange={handleChange}
            required
          />
        </div>

        <div className={styles.formGroup}>
          <label htmlFor="price">Giá:</label>
          <input
            type="number"
            id="price"
            name="price"
            value={product.price}
            onChange={handleChange}
            min="0"
            required
          />
        </div>

        <div className={styles.formGroup}>
          <label htmlFor="quantity">Số lượng:</label>
          <input
            type="number"
            id="quantity"
            name="quantity"
            value={product.quantity}
            onChange={handleChange}
            min="0"
            required
          />
        </div>

        {/* Thêm nameAttribute và valueAttribute */}
        <div className={styles.formGroup}>
          <label htmlFor="nameAttribute">Tên thuộc tính (nameAttribute):</label>
          <input
            type="text"
            id="nameAttribute"
            name="nameAttribute"
            value={product.nameAttribute}
            onChange={handleChange}
            required
          />
        </div>

        <div className={styles.formGroup}>
          <label htmlFor="valueAttribute">Giá trị thuộc tính (valueAttribute):</label>
          <input
            type="text"
            id="valueAttribute"
            name="valueAttribute"
            value={product.valueAttribute}
            onChange={handleChange}
            required
          />
        </div>

        <div className={styles.formGroup}>
          <label htmlFor="description">Mô tả:</label>
          <textarea
            id="description"
            name="description"
            value={product.description}
            onChange={handleChange}
            rows="4"
          />
        </div>

        {/* Upload ảnh chính */}
        <div className={styles.imageUploadBox}>
          {product.imagePreview ? (
            <img
              src={product.imagePreview}
              alt="Preview"
              className={styles.previewImage}
            />
          ) : (
            <div
              className={styles.plusIcon}
              onClick={() => document.getElementById("imageInput").click()}
            >
              +
            </div>
          )}
          <input
            type="file"
            id="imageInput"
            accept="image/*"
            style={{ display: "none" }}
            onChange={(e) => {
              const file = e.target.files[0];
              if (file) {
                const imagePreview = URL.createObjectURL(file);
                setProduct((prev) => ({
                  ...prev,
                  imagePreview,
                  imageFile: file,
                }));
              }
            }}
          />
        </div>

        {/* Upload ảnh phụ */}
        <div style={{ display: "flex", flexWrap: "wrap", gap: "10px" }}>
          {product.subImages.map((img, index) => (
            <div
              key={index}
              style={{
                width: "100px",
                height: "100px",
                border: "2px dashed #ccc",
                borderRadius: "8px",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                cursor: "pointer",
                overflow: "hidden",
              }}
              onClick={() =>
                document.getElementById(`subImageInput${index}`).click()
              }
            >
              <input
                type="file"
                accept="image/*"
                id={`subImageInput${index}`}
                style={{ display: "none" }}
                onChange={(e) => handleSubImageChange(e, index)}
              />
              {img ? (
                <img
                  src={URL.createObjectURL(img)}
                  alt={`sub-${index}`}
                  style={{ width: "100%", height: "100%", objectFit: "cover" }}
                />
              ) : (
                <span style={{ fontSize: "32px", color: "#aaa" }}>+</span>
              )}
            </div>
          ))}
        </div>

        <button type="submit" className={styles.submitButton} disabled={loading}>
          {loading ? "Đang xử lý..." : "Thêm sản phẩm"}
        </button>
      </form>
    </div>
  );
}
