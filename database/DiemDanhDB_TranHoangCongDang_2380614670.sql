-- =====================================================================
-- BÀI TẬP LỚN LẬP TRÌNH DI ĐỘNG: APP ĐIỂM DANH SINH VIÊN
-- NHÓM: TSV
-- SINH VIÊN THỰC HIỆN: TRẦN HOÀNG CÔNG ĐĂNG
-- MSSV: 2380614670
-- TÊN CƠ SỞ DỮ LIỆU BẮT BUỘC: DiemDanhDB_TranHoangCongDang_2380614670
-- =====================================================================

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'DiemDanhDB_TranHoangCongDang_2380614670')
BEGIN
    CREATE DATABASE [DiemDanhDB_TranHoangCongDang_2380614670];
END
GO

USE [DiemDanhDB_TranHoangCongDang_2380614670];
GO

-- 1. Bảng Môn học / Lớp học (Courses)
IF OBJECT_ID('Attendances', 'U') IS NOT NULL DROP TABLE Attendances;
IF OBJECT_ID('LeaveRequests', 'U') IS NOT NULL DROP TABLE LeaveRequests;
IF OBJECT_ID('Enrollments', 'U') IS NOT NULL DROP TABLE Enrollments;
IF OBJECT_ID('ClassSessions', 'U') IS NOT NULL DROP TABLE ClassSessions;
IF OBJECT_ID('Courses', 'U') IS NOT NULL DROP TABLE Courses;
IF OBJECT_ID('AppUsers', 'U') IS NOT NULL DROP TABLE AppUsers;
GO

CREATE TABLE AppUsers (
    Id NVARCHAR(450) PRIMARY KEY,
    UserName NVARCHAR(256) NOT NULL UNIQUE,
    Email NVARCHAR(256) NOT NULL UNIQUE,
    FullName NVARCHAR(256) NOT NULL,
    Code NVARCHAR(50) NULL, -- MSSV (2380614670)
    Role NVARCHAR(50) NOT NULL DEFAULT 'Student',
    PasswordHash NVARCHAR(MAX) NOT NULL,
    EmailConfirmed BIT NOT NULL DEFAULT 1,
    FaceTemplate NVARCHAR(MAX) NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Courses (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Code NVARCHAR(50) NOT NULL UNIQUE,
    Name NVARCHAR(256) NOT NULL,
    Room NVARCHAR(100) DEFAULT N'E1-02.05',
    TotalSessions INT DEFAULT 15,
    MaxAbsentPercent INT DEFAULT 20,
    LecturerId NVARCHAR(450) NULL,
    CONSTRAINT FK_Courses_Lecturer FOREIGN KEY (LecturerId) REFERENCES AppUsers(Id)
);
GO

CREATE TABLE Enrollments (
    CourseId INT NOT NULL,
    StudentId NVARCHAR(450) NOT NULL,
    EnrolledAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (CourseId, StudentId),
    CONSTRAINT FK_Enrollments_Course FOREIGN KEY (CourseId) REFERENCES Courses(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Enrollments_Student FOREIGN KEY (StudentId) REFERENCES AppUsers(Id) ON DELETE CASCADE
);
GO

CREATE TABLE ClassSessions (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CourseId INT NOT NULL,
    Title NVARCHAR(256) NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NULL,
    IsOpen BIT NOT NULL DEFAULT 1,
    Secret NVARCHAR(100) NOT NULL,
    Latitude FLOAT NULL,
    Longitude FLOAT NULL,
    RadiusMeters INT DEFAULT 100,
    CONSTRAINT FK_ClassSessions_Course FOREIGN KEY (CourseId) REFERENCES Courses(Id) ON DELETE CASCADE
);
GO

CREATE TABLE Attendances (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SessionId INT NOT NULL,
    StudentId NVARCHAR(450) NOT NULL,
    CheckInTime DATETIME DEFAULT GETDATE(),
    Latitude FLOAT NULL,
    Longitude FLOAT NULL,
    DistanceMeters FLOAT NULL,
    Method NVARCHAR(50) DEFAULT 'QR', -- QR, Face, Manual
    Status NVARCHAR(50) DEFAULT 'PRESENT', -- PRESENT, LATE, ABSENT_EXCUSED, ABSENT_UNEXCUSED
    Note NVARCHAR(256) NULL,
    CONSTRAINT FK_Attendances_Session FOREIGN KEY (SessionId) REFERENCES ClassSessions(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Attendances_Student FOREIGN KEY (StudentId) REFERENCES AppUsers(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_Session_Student UNIQUE (SessionId, StudentId)
);
GO

CREATE TABLE LeaveRequests (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SessionId INT NOT NULL,
    StudentId NVARCHAR(450) NOT NULL,
    Reason NVARCHAR(500) NOT NULL,
    ProofUrl NVARCHAR(500) NULL,
    Status NVARCHAR(50) DEFAULT 'PENDING', -- PENDING, APPROVED, REJECTED
    TeacherNote NVARCHAR(256) NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Leave_Session FOREIGN KEY (SessionId) REFERENCES ClassSessions(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Leave_Student FOREIGN KEY (StudentId) REFERENCES AppUsers(Id) ON DELETE CASCADE
);
GO

-- =====================================================================
-- NẠP DỮ LIỆU MẪU CHO TRẦN HOÀNG CÔNG ĐĂNG (2380614670) - NHÓM TSV
-- =====================================================================
INSERT INTO AppUsers (Id, UserName, Email, FullName, Code, Role, PasswordHash, EmailConfirmed) VALUES
('u_admin', 'admin', 'admin@tsv.edu.vn', N'Quản Trị Viên TSV', NULL, 'Admin', 'Admin@123', 1),
('u_gv', 'gv_khoa', 'gv_khoa@tsv.edu.vn', N'GV. Nguyễn Văn Giảng', 'GV001', 'Lecturer', 'Gv@12345', 1),
('u_dang', 'sv_dang', 'dang.thc@tsv.edu.vn', N'Trần Hoàng Công Đăng', '2380614670', 'Student', 'Sv@12345', 1),
('u_an', 'sv_an', 'an.tt@tsv.edu.vn', N'Trần Thị An', '2380000001', 'Student', 'Sv@12345', 1),
('u_binh', 'sv_binh', 'binh.lv@tsv.edu.vn', N'Lê Văn Bình', '2380000002', 'Student', 'Sv@12345', 1);

INSERT INTO Courses (Id, Code, Name, Room, TotalSessions, MaxAbsentPercent, LecturerId) VALUES
(1, 'LTDD01', N'Lập trình di động (Nhóm TSV)', N'E1-02.05', 15, 20, 'u_gv'),
(2, 'CSDL02', N'Cơ sở dữ liệu', N'E2-03.01', 10, 20, 'u_gv');

INSERT INTO Enrollments (CourseId, StudentId) VALUES
(1, 'u_dang'), (1, 'u_an'), (1, 'u_binh'),
(2, 'u_dang'), (2, 'u_an'), (2, 'u_binh');

INSERT INTO ClassSessions (Id, CourseId, Title, StartTime, EndTime, IsOpen, Secret, Latitude, Longitude, RadiusMeters) VALUES
(1, 1, N'Buổi 1: Giới thiệu Flutter & Dart UI', '2026-10-07 07:00:00', '2026-10-07 10:00:00', 0, 'SECRET_KEY_1', 10.8221, 106.6882, 100),
(2, 1, N'Buổi 2: State Management & CRUD', '2026-10-14 07:00:00', '2026-10-14 10:00:00', 0, 'SECRET_KEY_2', 10.8221, 106.6882, 100),
(3, 1, N'Buổi 3: QR Code & GPS Geofencing (TSV)', '2026-10-21 07:00:00', '2026-10-21 10:00:00', 1, 'SECRET_KEY_3', 10.8221, 106.6882, 100);

INSERT INTO Attendances (SessionId, StudentId, CheckInTime, Latitude, Longitude, DistanceMeters, Method, Status, Note) VALUES
(1, 'u_dang', '2026-10-07 07:15:00', 10.8222, 106.6883, 18.2, 'QR', 'PRESENT', N'Đúng giờ, chuyên cần'),
(1, 'u_an', '2026-10-07 07:18:00', 10.8221, 106.6882, 12.0, 'QR', 'PRESENT', N'Đúng giờ'),
(2, 'u_dang', '2026-10-14 07:12:00', 10.8222, 106.6883, 18.0, 'Face', 'PRESENT', N'Xác thực Face ID');
GO
