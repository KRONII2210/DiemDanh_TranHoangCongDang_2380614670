@echo off
chcp 65001 >nul
title KET NOI DIEN THOAI (DUNG CHUNG API & CHIEU MAN HINH) - NHOM TSV
echo =====================================================================
echo  DO AN DIEM DANH - NHOM TSV - TRAN HOANG CONG DANG (2380614670)
echo  KET NOI DIEN THOAI THUC QUA CAP USB + CHIEU MAN HINH SCRCPY
echo =====================================================================
echo.

set SCRCPY_DIR=d:\scrcpy-win64-v5.0.1
if not exist "%SCRCPY_DIR%\adb.exe" (
    echo [LOI] Khong tim thay thu muc scrcpy tai: %SCRCPY_DIR%
    pause
    exit /b
)

echo [1/3] Kiem tra ket noi thiet bi qua cong USB...
"%SCRCPY_DIR%\adb.exe" devices
echo.

echo [2/3] Thiet lap cau noi API dung chung (adb reverse port 5080)...
"%SCRCPY_DIR%\adb.exe" reverse tcp:5080 tcp:5080
if %ERRORLEVEL% EQU 0 (
    echo   -> [THANH CONG] Dien thoai gio day ket noi truc tiep vao http://localhost:5080/api qua cap USB!
) else (
    echo   -> [LƯU Ý] Chua nhan dien thoai. Hay kiem tra cap USB va bat 'Go loi USB' (USB Debugging) tren may.
)
echo.

echo [3/3] Mo cua so chieu man hinh dien thoai len PC (scrcpy)...
start "" "%SCRCPY_DIR%\scrcpy.exe" --window-title "Dien Thoai Sinh Vien - Tran Hoang Cong Dang" --window-x 960 --window-y 60 --window-width 420
echo.
echo =====================================================================
echo  HOAN TAT!
echo  1. Mo Visual Studio va nhan F5 de mo Web Diem Danh (Giang vien / Admin).
echo  2. Thao tac tren man hinh dien thoai de Quet QR / Diem danh.
echo =====================================================================
echo.
pause
