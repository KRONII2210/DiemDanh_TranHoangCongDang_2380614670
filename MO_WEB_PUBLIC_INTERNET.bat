@echo off
chcp 65001 > nul
title MO PUBLIC WEB API RA INTERNET - TRAN HOANG CONG DANG 2380614670
echo =====================================================================
echo 🌐 MỞ WEB API RA TOÀN BỘ INTERNET CHO GIẢNG VIÊN VÀ NHÓM KIỂM TRA
echo 📌 SINH VIÊN: TRẦN HOÀNG CÔNG ĐĂNG - MSSV: 2380614670
echo 📌 NHÓM: TSV
echo 📌 CỔNG DỊCH VỤ WEB API: 5080
echo =====================================================================
echo.
echo 1. Hãy đảm bảo bạn ĐANG BẬT file "CHAY_WEB_API.bat" ở cửa sổ khác!
echo 2. Đang tạo link Public HTTPS ra toàn thế giới qua LocalTunnel...
echo.
echo [MẸO KHI MỞ TRÌNH DUYỆT]: Nếu trang web yêu cầu "Endpoint IP",
echo bạn có thể truy cập https://loca.lt/mytunnelpassword để lấy mã và dán vào.
echo =====================================================================
echo.
call npx.cmd --yes localtunnel --port 5080 --subdomain diemdanh-dang2380614670
pause
