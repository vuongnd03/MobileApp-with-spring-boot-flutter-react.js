import { BrowserRouter as Router, Routes, Route, useLocation } from "react-router-dom";
import LoginAdmin from "./Admin/components/LoginAdmin";
import UIAdmin from "./Admin/UILoginAdmin/UIAdmin";
import Addproduct from "./Admin/UILoginAdmin/Addproduct";
import Deleteproduct from "./Admin/UILoginAdmin/Deleteproduct";
import Addcatalog from "./Admin/UILoginAdmin/Addcatalog";

function AppContent() {
  const location = useLocation();

  // Nếu muốn ẩn hiện layout, ví dụ:
  const hideLayout = location.pathname.startsWith("/admin/Uiadmin");

  return (
    <>
      <Routes>
        <Route path="/admin" element={<LoginAdmin />} />
        <Route path="/admin/Uiadmin" element={<UIAdmin />}>
          <Route path="Addcatalog" element={<Addcatalog />} />
          <Route path="Addproduct" element={<Addproduct />} />
          <Route path="Deleteproduct" element={<Deleteproduct />} />
        </Route>
      </Routes>
    </>
  );
}

function App() {
  return (
    <Router>
      <AppContent />
    </Router>
  );
}

export default App;
