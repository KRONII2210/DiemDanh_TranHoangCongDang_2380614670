@echo off
chcp 65001 > nul
echo =====================================================================
echo 📱 KHỞI CHẠY APP FLUTTER ĐIỂM DANH SINH VIÊN
echo 📌 SINH VIÊN: TRẦN HOÀNG CÔNG ĐĂNG - MSSV: 2380614670
echo 📌 PROJECT: diemdanh_tranhoangcongdang_2380614670
echo =====================================================================
echo.
cd /d "%~dp0diemdanh_tranhoangcongdang_2380614670"
call flutter pub get
call flutter run
pause
