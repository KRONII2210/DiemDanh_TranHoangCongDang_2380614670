@echo off
chcp 65001 >nul
title DAY SOURCE CODE LEN GITHUB - NHOM TSV - TRAN HOANG CONG DANG
echo =====================================================================
echo  ĐỒ ÁN ĐIỂM DANH SINH VIÊN - NHÓM TSV - TRẦN HOÀNG CÔNG ĐĂNG (2380614670)
echo  CÔNG CỤ NỘP / ĐẨY (PUSH) SOURCE CODE LÊN GITHUB
echo =====================================================================
echo.
echo BƯỚC 1: Hãy chắc chắn bạn đã tạo 1 Repository MỚI trên https://github.com/new
echo (Lưu ý: Không tích vào 'Add a README file' khi tạo trên web)
echo.
echo BƯỚC 2: Copy link Repository dạng:
echo   https://github.com/ten-tai-khoan/DiemDanh_TranHoangCongDang_2380614670.git
echo.
set /p REPO_URL="Dán đường link GitHub của bạn vào đây và nhấn Enter: "

if "%REPO_URL%"=="" (
    echo [LỖI] Bạn chưa nhập đường link GitHub! Vui lòng chạy lại.
    pause
    exit /b
)

echo.
echo [1/3] Đặt nhánh chính thành 'main'...
git branch -M main

echo [2/3] Cấu hình remote origin...
git remote remove origin 2>nul
git remote add origin %REPO_URL%

echo [3/3] Đang đẩy toàn bộ mã nguồn lên GitHub...
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo =====================================================================
    echo  [THÀNH CÔNG] ĐÃ ĐẨY SOURCE CODE LÊN GITHUB HOÀN TẤT!
    echo  Link nộp bài của bạn: %REPO_URL%
    echo =====================================================================
) else (
    echo.
    echo =====================================================================
    echo  [LƯU Ý] Nếu gặp lỗi xác thực hoặc quyền truy cập, hãy chắc chắn rằng:
    echo  1. Bạn đã đăng nhập đúng tài khoản GitHub sở hữu Repository này.
    echo  2. Repository trên web GitHub là repository trống (chưa có commit).
    echo =====================================================================
)
echo.
pause
