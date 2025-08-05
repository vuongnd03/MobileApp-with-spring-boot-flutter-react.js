import { useState } from "react";
import styles from "../CssAdmin/Addcatalog.module.css";

export default function Addcatalog({ onCatalogAdded }) {
  const [loaiSP, setLoaiSP] = useState("");
  const [status, setStatus] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();

    const data = {
      loaisp: loaiSP,
      ngaytao: new Date().toISOString(),
    };

    try {
      const response = await fetch("/api/product/add_Catalog_Product", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      });

      if (response.ok) {
        setStatus("✅ Thêm loại sản phẩm thành công!");
        setLoaiSP("");
        if (onCatalogAdded) {
          onCatalogAdded(); // callback để reload danh sách nếu cần
        }
      } else {
        setStatus("❌ Thêm không thành công.");
      }
    } catch (error) {
      console.error("Lỗi:", error);
      setStatus("❌ Lỗi khi kết nối API.");
    }
  };

  return (
    <div className={styles.container}>
      <h2 className={styles.title}>Thêm Loại Sản Phẩm</h2>
      <form onSubmit={handleSubmit} className={styles.form}>
        <input
          type="text"
          placeholder="Nhập loại sản phẩm"
          value={loaiSP}
          onChange={(e) => setLoaiSP(e.target.value)}
          className={styles.input}
          required
        />
        <button type="submit" className={styles.button}>
          Thêm sản phẩm
        </button>
        {status && <p className={styles.status}>{status}</p>}
      </form>
    </div>
  );
}
