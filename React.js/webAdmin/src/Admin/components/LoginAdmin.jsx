import { useState } from "react";
import axios from 'axios'; 
import { useNavigate } from "react-router-dom";

export default function LoginAdmin() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const navigate = useNavigate();

  const handleLogin = async (event) => {
    event.preventDefault();

    const loginData = {
      email: email,
      password: password
    };

    try {
      const response = await axios.post('http://localhost:8282/api/admin/LoginAdmin', loginData);

      // Giả sử API trả về token
      const token = response.data.token; 
      
      // Lưu token vào localStorage (tuỳ bạn có dùng không)
      localStorage.setItem("token", token);

      // Chuyển hướng sang UIAdmin
      navigate("/admin/Uiadmin");

    } catch (error) {
      setError("Sai tài khoản hoặc mật khẩu");
      console.error(error);
    }
  };

  return (
    <div style={{
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      height: "100vh",
      backgroundColor: "#f0f2f5"
    }}>
      <form onSubmit={handleLogin} style={{
        background: "white",
        padding: "40px",
        borderRadius: "8px",
        boxShadow: "0 0 10px rgba(0,0,0,0.1)",
        display: "flex",
        flexDirection: "column",
        width: "300px"
      }}>
        <h2 style={{ textAlign: "center" }}>Admin Login</h2>

        {error && (
          <div style={{
            backgroundColor: "#ffebee",
            color: "#d32f2f",
            padding: "10px",
            borderRadius: "4px",
            marginBottom: "10px",
            fontSize: "14px",
            textAlign: "center"
          }}>
            {error}
          </div>
        )}

        <input
          type="text"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          style={{ padding: "10px", margin: "10px 0" }}
          required
        />
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          style={{ padding: "10px", margin: "10px 0" }}
          required
        />
        <button type="submit" style={{
          padding: "10px",
          backgroundColor: "#007bff",
          color: "white",
          border: "none",
          borderRadius: "4px",
          cursor: "pointer"
        }}>
          Đăng nhập
        </button>
      </form>
    </div>
  );
}
