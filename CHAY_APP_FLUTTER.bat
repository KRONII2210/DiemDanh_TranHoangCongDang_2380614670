@echo off
chcp 65001 > nul
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.14.7-hotspot"
set "PATH=%JAVA_HOME%\bin;D:\flutter_windows_3.24.4-stable\flutter\bin;%PATH%"
title APP FLUTTER - TRAN HOANG CONG DANG 2380614670
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
