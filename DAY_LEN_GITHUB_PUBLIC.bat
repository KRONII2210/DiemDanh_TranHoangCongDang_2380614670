@echo off
chcp 65001 > nul
title DAY PROJECT LEN GITHUB PUBLIC - TRAN HOANG CONG DANG 2380614670
echo =====================================================================
echo 🚀 ĐẨY ĐỒ ÁN LÊN GITHUB PUBLIC - NHÓM TSV - 2380614670
echo 📌 SINH VIÊN: TRẦN HOÀNG CÔNG ĐĂNG - MSSV: 2380614670
echo =====================================================================
echo.
echo Bước 1: Hãy vào https://github.com/new và tạo Repository MỚI với tên:
echo         DiemDanh_TranHoangCongDang_2380614670
echo         (Chọn chế độ PUBLIC)
echo.
echo Bước 2: Dán đường link repo GitHub của bạn vào bên dưới:
echo (Ví dụ: https://github.com/username/DiemDanh_TranHoangCongDang_2380614670.git)
echo.
set /p REPO_URL="Nhập link GitHub repo: "

if "%REPO_URL%"=="" (
    echo Bạn chưa nhập link repo! Hủy thao tác.
    pause
    exit /b
)

git remote remove origin 2>nul
git remote add origin %REPO_URL%
git branch -M main
git push -u origin main

echo.
echo =====================================================================
echo ✅ ĐÃ ĐẨY SOURCE CODE LÊN GITHUB PUBLIC THÀNH CÔNG!
echo Link bài của bạn: %REPO_URL%
echo =====================================================================
pause
