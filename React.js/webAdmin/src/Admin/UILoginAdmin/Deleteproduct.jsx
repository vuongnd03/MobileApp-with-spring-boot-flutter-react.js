import { useEffect, useState } from "react";
import axios from "axios";
import { Link } from 'react-router-dom';
import icons1 from '../Icons/icons8-add-50.png';
import styles from "../CssAdmin/Deleteproduct.module.css";
import icons_delete from "../Icons/icons8-delete-100.png";

export default function Deleteproduct(){
    const [products, setProducts] = useState([]);
    const [selectedType, setSelectedType] = useState("");
    const [keyword, setKeyword] = useState('');

    // Hàm load tất cả sản phẩm
    const fetchAllProducts = async () => {
        try {
            const response = await axios.get("/api/product/allProduct");
            setProducts(response.data);
        } catch (error) {
            console.error("Lỗi khi tải sản phẩm:", error);
        }
    };

    // Hàm xoá sản phẩm
    const handleDelete = async (productId) => {
        if (!window.confirm("Bạn có chắc chắn muốn xoá sản phẩm này không?")) return;
        try {
            await axios.delete(`/api/product/Xoa_product/${productId}`);
            alert("Đã xóa sản phẩm thành công!");
            setProducts((prev) => prev.filter((p) => p.id !== productId));
        } catch (error) {
            console.error("Lỗi khi xoá sản phẩm:", error);
        }
    };

    // Lọc sản phẩm theo loại
    const handleTypeChange = (e) => {
        setSelectedType(e.target.value);
    };

    useEffect(() => {
        fetchAllProducts();
    }, []);

    return (
        <div>
            <div className={styles.searchContainer}>
                <div className={styles.Combobox}>
                    <select value={selectedType} onChange={handleTypeChange}>
                        <option value="">-- Chọn loại sản phẩm --</option>
                        <option value="Sản Phẩm được yêu thích">Sản phẩm được yêu thích</option>
                        <option value="Điện Thoại">Điện Thoại</option>
                        <option value="Giày">Giày</option>
                        <option value="Dép">Dép</option>
                        <option value="Laptop">Laptop</option>
                    </select>
                </div>
                <div className={styles.searchBox}>
                    <input
                        type="text"
                        placeholder="Tìm kiếm (API sẽ thêm sau)"
                        value={keyword}
                        onChange={(e) => setKeyword(e.target.value)}
                    />
                </div>
            </div>

            <div className={styles.sanpham}>
                <div className={styles.sanphamyeuthich}>
                    {products.map((product) => (
                        <div className={styles.yeuthich} key={product.id}>
                            <img
                                src={icons_delete}
                                alt="delete icon"
                                className={styles.deleteIcon}
                                onClick={() => handleDelete(product.id)}
                            />
                            <Link to={`/product/${product.id}`} style={{ textDecoration: 'none', color: 'inherit' }}>
                                {product.image_url && (
                                    <img
                                        src={`http://localhost:8282/images/${product.image_url}`}
                                         alt={product.namesp}
                                    />
                                )}
                                <h1>{product.namesp}</h1>
                            </Link>
                            <div className={styles["price-add"]}>
                                <h2>{product.price}</h2>
                                <button><img src={icons1} alt="add icon" /></button>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
}
