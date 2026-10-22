@echo off
chcp 65001 > nul
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.14.7-hotspot"
set "PATH=%JAVA_HOME%\bin;D:\flutter_windows_3.24.4-stable\flutter\bin;%PATH%"
title APP DIEM DANH - CHAY TREN DIEN THOAI ANDROID
echo =====================================================================
echo 📱 KHỞI CHẠY APP ĐIỂM DANH TRÊN ĐIỆN THOẠI ANDROID
echo 📌 SINH VIÊN: TRẦN HOÀNG CÔNG ĐĂNG - MSSV: 2380614670
echo =====================================================================
echo.
echo [1/2] Đang chuyển tiếp cổng 5080 từ điện thoại về máy tính (adb reverse)...
adb reverse tcp:5080 tcp:5080 2>nul
echo.
echo [2/2] Đang cài đặt và khởi chạy App lên điện thoại...
cd /d "%~dp0diemdanh_tranhoangcongdang_2380614670"
call flutter pub get
call flutter run -d android
pause
