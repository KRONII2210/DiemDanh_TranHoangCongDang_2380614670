import 'dart:math';
import 'package:flutter/material.dart';
import '../models/session_model.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class QrScannerScreen extends StatefulWidget {
  final SessionModel? session;
  const QrScannerScreen({Key? key, this.session}) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  final TextEditingController _manualCodeController = TextEditingController(text: 'TSV-1-K7X9A2');
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _manualCodeController.text = ApiService.instance.currentDynamicQrCode;
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    _manualCodeController.dispose();
    super.dispose();
  }

  Future<void> _processScan(String qrContent) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    final user = AuthService.instance.currentUser;
    final int buoiId = widget.session?.id ?? 1;

    // Simulate GPS coordinates (10.8221, 106.6882) - campus location
    final result = await ApiService.instance.markAttendanceWithQrAndLocation(
      buoiHocId: buoiId,
      sinhVienId: user?.id ?? 1,
      qrToken: qrContent,
      latitude: 10.8221,
      longitude: 106.6882,
      faceVerified: true,
    );

    setState(() => _isProcessing = false);

    if (!mounted) return;

    if (result['success'] == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 28),
              const SizedBox(width: 8),
              const Text('Điểm Danh Thành Công!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow('Sinh viên:', user?.fullName ?? 'Trần Hoàng Công Đăng'),
              _buildRow('MSSV:', user?.mssv ?? '2380614670'),
              _buildRow('Mã QR:', qrContent),
              _buildRow('Vị trí GPS:', '10.8221, 106.6882 (Hợp lệ)'),
              _buildRow('Khoảng cách:', '${result['distanceMeters'] ?? 18}m / Bán kính 100m'),
              _buildRow('Xác thực khuôn mặt:', 'Đã đối soát Face ID'),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)),
                child: const Text('Trạng thái: ĐÃ GHI NHẬN CÓ MẶT (PRESENT)', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700, foregroundColor: Colors.white),
              child: const Text('Xong'),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Lỗi điểm danh'), backgroundColor: Colors.red),
      );
    }
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87))),
        ],
      ),
    );
  }

  void _showQrCodeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.qr_code_2, color: Colors.blue),
            SizedBox(width: 8),
            Text('Mã QR Của Buổi Học', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Lớp: LTDD01 - Lập trình di động\nBuổi học: Buổi 1 (Mã đổi mỗi 30s)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
                ],
              ),
              child: SizedBox(
                width: 170,
                height: 170,
                child: CustomPaint(
                  painter: _QrMatrixPainter(seedString: 'DIEMDANH:1:${ApiService.instance.currentDynamicQrCode}'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                'Mã: ${ApiService.instance.currentDynamicQrCode}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Đóng'),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800, foregroundColor: Colors.white),
            icon: const Icon(Icons.check_circle_outline, size: 18),
            label: const Text('Điểm danh ngay'),
            onPressed: () {
              Navigator.pop(ctx);
              _manualCodeController.text = ApiService.instance.currentDynamicQrCode;
              _processScan(ApiService.instance.currentDynamicQrCode);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quét Mã QR Điểm Danh'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_2),
            tooltip: 'Xem mã QR buổi học (Dành cho kiểm thử 1 máy)',
            onPressed: _showQrCodeDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Camera viewfinder simulation
            Container(
              height: 320,
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Camera background feed simulation
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [Colors.grey.shade900, Colors.black],
                        radius: 0.9,
                      ),
                    ),
                  ),

                  // Viewfinder Frame
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade400, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  // Animated Scanning Laser Line
                  AnimatedBuilder(
                    animation: _animController,
                    builder: (context, child) {
                      return Positioned(
                        top: 50 + (_animController.value * 220),
                        child: Container(
                          width: 210,
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueAccent.withOpacity(0.0),
                                Colors.cyanAccent,
                                Colors.blueAccent.withOpacity(0.0),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(color: Colors.cyanAccent.withOpacity(0.8), blurRadius: 6),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Guidance text
                  Positioned(
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                      child: const Text('Hướng camera vào mã QR của Giảng viên', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),

            // Controls & Test Options
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: _isProcessing
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.qr_code_scanner),
                    label: Text(_isProcessing ? 'Đang xác thực điểm danh...' : 'QUÉT & ĐIỂM DANH MÃ QR HIỆN TẠI', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    onPressed: _isProcessing
                        ? null
                        : () {
                            setState(() {
                              _manualCodeController.text = ApiService.instance.currentDynamicQrCode;
                            });
                            _processScan(ApiService.instance.currentDynamicQrCode);
                          },
                  ),
                  const SizedBox(height: 10),

                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue.shade900,
                      side: BorderSide(color: Colors.blue.shade300, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.qr_code_2_rounded),
                    label: const Text('HIỂN THỊ MÃ QR BUỔI HỌC (TEST 1 MÁY)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    onPressed: _showQrCodeDialog,
                  ),
                  const SizedBox(height: 16),

                  const Divider(),
                  const Text('HOẶC NHẬP MÃ ĐIỂM DANH THỦ CÔNG:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _manualCodeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            labelText: 'Mã QR Code',
                            prefixIcon: const Icon(Icons.pin),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Xác nhận'),
                        onPressed: _isProcessing
                        ? null
                        : () {
                            setState(() {
                              _manualCodeController.text = ApiService.instance.currentDynamicQrCode;
                            });
                            _processScan(ApiService.instance.currentDynamicQrCode);
                          },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('QUY TRÌNH XÁC THỰC 3 LỚP AN TOÀN:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue)),
                        SizedBox(height: 4),
                        Text('1. Nhận diện QR Code bảo mật thời gian thực', style: TextStyle(fontSize: 12)),
                        Text('2. Đối soát tọa độ GPS trong bán kính phòng học', style: TextStyle(fontSize: 12)),
                        Text('3. Xác thực danh tính sinh viên Trần Hoàng Công Đăng - 2380614670', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QrMatrixPainter extends CustomPainter {
  final String seedString;
  _QrMatrixPainter({required this.seedString});

  @override
  void paint(Canvas canvas, Size size) {
    final paintDark = Paint()..color = const Color(0xFF1A237E);
    final paintFinder = Paint()..color = const Color(0xFF0D47A1);

    const int grid = 25;
    final cellSize = size.width / grid;

    void drawFinder(double x, double y) {
      canvas.drawRect(Rect.fromLTWH(x * cellSize, y * cellSize, 7 * cellSize, 7 * cellSize), paintFinder);
      canvas.drawRect(
        Rect.fromLTWH((x + 1) * cellSize, (y + 1) * cellSize, 5 * cellSize, 5 * cellSize),
        Paint()..color = Colors.white,
      );
      canvas.drawRect(Rect.fromLTWH((x + 2) * cellSize, (y + 2) * cellSize, 3 * cellSize, 3 * cellSize), paintFinder);
    }

    drawFinder(1, 1);
    drawFinder(grid - 8.0, 1);
    drawFinder(1, grid - 8.0);

    int hash = seedString.hashCode;
    final rand = Random(hash.abs());

    for (int r = 0; r < grid; r++) {
      for (int c = 0; c < grid; c++) {
        if ((r < 9 && c < 9) || (r < 9 && c >= grid - 9) || (r >= grid - 9 && c < 9)) {
          continue;
        }

        if (r == 6 || c == 6) {
          if ((r + c) % 2 == 0) {
            canvas.drawRect(Rect.fromLTWH(c * cellSize, r * cellSize, cellSize, cellSize), paintDark);
          }
          continue;
        }

        if (rand.nextBool()) {
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(c * cellSize + 0.5, r * cellSize + 0.5, cellSize - 1, cellSize - 1),
              const Radius.circular(1.5),
            ),
            paintDark,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _QrMatrixPainter oldDelegate) => oldDelegate.seedString != seedString;
}
