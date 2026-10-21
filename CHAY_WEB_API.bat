@echo off
chcp 65001 > nul
echo =====================================================================
echo 🚀 KHỞI CHẠY WEB API ĐIỂM DANH SINH VIÊN
echo 📌 SINH VIÊN: TRẦN HOÀNG CÔNG ĐĂNG - MSSV: 2380614670
echo 📌 DỰ ÁN: DiemDanh_TranHoangCongDang_2380614670_API
echo 📌 CƠ SỞ DỮ LIỆU: DiemDanhDB_TranHoangCongDang_2380614670
echo =====================================================================
echo.
cd /d "%~dp0DiemDanh_TranHoangCongDang_2380614670_API"
dotnet run --launch-profile "http"
pause
