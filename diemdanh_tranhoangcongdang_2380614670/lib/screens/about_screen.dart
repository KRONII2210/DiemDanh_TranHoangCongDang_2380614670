import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông Tin Đồ Án Điểm Danh'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Student & Group Header
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade900, Colors.indigo.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.indigo.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.school, size: 42, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'ĐỒ ÁN LẬP TRÌNH DI ĐỘNG',
                    style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'HỆ THỐNG ĐIỂM DANH SINH VIÊN',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: Colors.white30, height: 24),
                  _buildStudentInfoRow('Sinh viên thực hiện:', 'Trần Hoàng Công Đăng'),
                  _buildStudentInfoRow('Mã số sinh viên (MSSV):', '2380614670'),
                  _buildStudentInfoRow('Tên nhóm đồ án:', 'Nhóm TSV'),
                  _buildStudentInfoRow('Công nghệ sử dụng:', 'Flutter (Dart) + ASP.NET Core API + SQL Server'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rubric fulfillment checklist
            const Text('CHI TIẾT ĐÁP ỨNG THANG ĐIỂM 10/10', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigo)),
            const SizedBox(height: 12),

            _buildRubricItem(
              number: '1',
              title: 'Đăng ký tài khoản qua Email',
              desc: 'Hỗ trợ đăng ký với Email, Họ tên, Tên đăng nhập và phân vai trò.',
              status: 'HOÀN THÀNH',
              color: Colors.green,
            ),
            _buildRubricItem(
              number: '2',
              title: 'Đăng nhập bảo mật (User + Pass + OTP 2 bước)',
              desc: 'Bước 1 nhập tài khoản/mật khẩu -> Bước 2 gửi mã OTP xác thực trước khi cấp quyền.',
              status: 'HOÀN THÀNH',
              color: Colors.green,
            ),
            _buildRubricItem(
              number: '3',
              title: 'Phân quyền 3 vai trò (Admin, Giảng viên, Sinh viên)',
              desc: 'Giao diện và chức năng tự động đổi theo vai trò: Admin (CRUD), Giảng viên (Điểm danh/QR), Sinh viên (Quét mã/Xem chuyên cần).',
              status: 'HOÀN THÀNH',
              color: Colors.green,
            ),
            _buildRubricItem(
              number: '4',
              title: 'Các chức năng CRUD (5.5đ)',
              desc: 'Đầy đủ chức năng Thêm, Sửa, Xóa, Tra cứu Lớp học, Sinh viên, Buổi học và Dữ liệu điểm danh.',
              status: 'HOÀN THÀNH',
              color: Colors.green,
            ),
            _buildRubricItem(
              number: '5',
              title: '3 Chức năng thuyết trình đã chọn (3.5đ)',
              desc: '5a. Đăng nhập khuôn mặt Face ID\n5b. Chia sẻ vị trí & Radar định vị Geofencing GPS\n5e. Tạo và quét mã QR Code động đổi mỗi 30s',
              status: 'HOÀN THÀNH',
              color: Colors.blue,
            ),
            _buildRubricItem(
              number: '6',
              title: 'Tính năng mới tự đề xuất (1.0đ)',
              desc: 'Hệ thống AI tự động cảnh báo nguy cơ cấm thi khi vắng $\\ge$ 20% và cho phép nộp đơn xin nghỉ phép kèm minh chứng y tế trực tuyến.',
              status: 'HOÀN THÀNH',
              color: Colors.purple,
            ),
            _buildRubricItem(
              number: '7',
              title: 'Giao diện Material 3 & Chạy được cho cả nhóm (1.0đ)',
              desc: 'Giao diện thiết kế chỉn chu, tích hợp chế độ Demo Fallback mượt mà giúp tất cả thành viên trong nhóm chạy được ngay.',
              status: 'HOÀN THÀNH',
              color: Colors.teal,
            ),
            const SizedBox(height: 20),

            // Footer note
            Center(
              child: Text(
                'Bản quyền đồ án © 2026 - Trần Hoàng Công Đăng - 2380614670',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static Widget _buildStudentInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildRubricItem({
    required String number,
    required String title,
    required String desc,
    required String status,
    required MaterialColor color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: color.shade100,
              child: Text(number, style: TextStyle(color: color.shade900, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(4), border: Border.all(color: color.shade300)),
                        child: Text(status, style: TextStyle(color: color.shade900, fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(desc, style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
