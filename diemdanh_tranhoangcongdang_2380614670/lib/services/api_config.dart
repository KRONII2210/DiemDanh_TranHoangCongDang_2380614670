/**
 * =====================================================================
 * CẤU HÌNH ĐƯỜNG DẪN WEB API DÙNG CHUNG CỦA NHÓM TSV
 * (KẾT NỐI API DiemDanh_DoDangKhoa_2380614683_API TỪ GITHUB)
 * SINH VIÊN: TRẦN HOÀNG CÔNG ĐĂNG (2380614670)
 * =====================================================================
 */
class ApiConfig {
  // 📍 LINK API CHUNG CỦA NHÓM TRÊN GITHUB (Cổng 5080 của ASP.NET Core):
  // - Máy ảo Android: "http://10.0.2.2:5080/api"
  // - Máy tính / Trình duyệt: "http://localhost:5080/api"
  // - Chạy qua Conveyor Cloud: "https://your-conveyor-url.conveyor.cloud/api"
  static String sharedApiUrl = "http://10.0.2.2:5080/api";

  // URL hiện tại (có thể đổi trực tiếp trong app qua nút Cài đặt)
  static String currentBaseUrl = sharedApiUrl;

  // Lưu trữ Token JWT sau khi đăng nhập thành công
  static String? jwtToken;

  static void setCustomUrl(String newUrl) {
    if (newUrl.endsWith("/")) {
      currentBaseUrl = newUrl.substring(0, newUrl.length - 1);
    } else {
      currentBaseUrl = newUrl;
    }
  }

  static Map<String, String> get authHeaders {
    final headers = {'Content-Type': 'application/json'};
    if (jwtToken != null && jwtToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }
    return headers;
  }
}
