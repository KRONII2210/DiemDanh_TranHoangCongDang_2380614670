# Hệ Thống Điểm Danh Sinh Viên Thông Minh

> **Đồ án môn học:** Lập Trình Ứng Dụng Di Động  
> **Sinh viên thực hiện:** Trần Hoàng Công Đăng  
> **Mã số sinh viên (MSSV):** 2380614670  
> **Nhóm thực hiện:** Nhóm TSV  

---

## 1. Giới Thiệu Đề Tài
Hệ thống điểm danh sinh viên thông minh kết hợp nền tảng **Web** và **Ứng dụng di động (Mobile App)**, cung cấp quy trình điểm danh bảo mật đa lớp:
- **Mã QR động (Dynamic QR Code):** Mã QR tự động làm mới mỗi 30 giây để chống việc chụp màn hình điểm danh hộ.
- **Xác thực GPS:** Đối soát tọa độ vị trí thực tế của sinh viên trong bán kính khuôn viên phòng học.
- **Xác thực sinh trắc học:** Tích hợp kiểm tra khuôn mặt (Face ID) khi xác nhận điểm danh.
- **Phân quyền người dùng (Role-based Authorization):** Quản trị viên (Admin), Giảng viên (Teacher), Sinh viên (Student).

---

## 2. Công Nghệ Sử Dụng
- **Backend / Web API:**
  - ASP.NET Core Web API (.NET 8.0)
  - Entity Framework Core, SQL Server LocalDB / SQL Server Express
  - JWT (JSON Web Token) Authentication & Identity
  - Swagger UI / OpenAPI Spec (`/swagger`)
  - Server-Side Static Hosting (Web Client tích hợp sẵn tại `/`)
- **Frontend / Client:**
  - Flutter Framework (hỗ trợ đa nền tảng: Web & Android)
  - Thư viện quét mã chuẩn: `mobile_scanner` (Google ML Kit)
  - Thư viện phát mã QR chuẩn ISO: `qr_flutter`
  - Giao diện Material 3 trực quan, phản hồi thời gian thực.

---

## 3. Cấu Trúc Thư Mục Dự Án
```text
DiemDanh_TranHoangCongDang_2380614670/
├── DiemDanh_TranHoangCongDang_2380614670.sln     # File Solution mở trực tiếp bằng Visual Studio
├── DiemDanh_TranHoangCongDang_2380614670_API/    # Dự án ASP.NET Core Web API & Web Client
│   ├── Controllers/                             # RESTful API Endpoints (Auth, Attendance, Courses,...)
│   ├── Data/                                    # DbContext & Database Seeder mẫu
│   ├── wwwroot/                                 # Giao diện Web App đã đóng gói sẵn
│   └── Program.cs                               # Cấu hình máy chủ & định tuyến
├── diemdanh_tranhoangcongdang_2380614670/        # Dự án ứng dụng Flutter đa nền tảng
│   ├── lib/                                     # Mã nguồn Flutter (Screens, Widgets, Services, Models)
│   └── pubspec.yaml                             # Cấu hình thư viện phụ thuộc
├── KET_NOI_DIEN_THOAI_SCRCPY.bat                 # Tiện ích kết nối USB dùng chung API & chiếu màn hình
└── DAY_LEN_GITHUB.bat                           # Tiện ích đẩy source code lên GitHub tự động
```

---

## 4. Hướng Dẫn Cài Đặt & Chạy Ứng Dụng

### Cách 1: Chạy trực tiếp qua Visual Studio (Khuyên dùng)
1. Mở file `DiemDanh_TranHoangCongDang_2380614670.sln` bằng **Visual Studio 2022**.
2. Nhấn phím **F5** (hoặc nút **Play / Start**).
3. Trình duyệt sẽ tự động mở thẳng giao diện Web ứng dụng tại địa chỉ: `http://localhost:5080/`.

### Cách 2: Kết nối thiết bị di động (Android) & Chiếu màn hình
1. Cắm cáp USB nối điện thoại vào PC (đã bật *Gỡ lỗi USB / USB Debugging*).
2. Chạy file `KET_NOI_DIEN_THOAI_SCRCPY.bat`:
   - Thiết lập cổng chuyển tiếp `adb reverse tcp:5080 tcp:5080` (điện thoại gọi chung API qua USB).
   - Tự động chiếu màn hình điện thoại lên cạnh trình duyệt Web trên PC để thuận tiện thuyết trình.

---

## 5. Tài Khoản Trải Nghiệm Mẫu

| Vai trò | Email đăng nhập | Mật khẩu | Chức năng chính |
| :--- | :--- | :--- | :--- |
| **Quản trị viên (Admin)** | `admin@tsv.edu.vn` | `Admin@123456` | Quản trị tài khoản, phân quyền, duyệt đơn nghỉ phép |
| **Giảng viên (Teacher)** | `giangvien@tsv.edu.vn` | `Gv@123456` | Quản lý lớp, phát mã QR điểm danh động, xem thống kê |
| **Sinh viên (Student)** | `congdang@tsv.edu.vn` | `Sv@123456` | Quét QR bằng camera, nhận diện vị trí, gửi đơn xin nghỉ |

## 6.  Chấm Điểm Bản Thân
Sau khi kiểm thử và xem xét thì bản thân em chấm 7/10đ
