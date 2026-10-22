import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/session_model.dart';
import '../services/api_service.dart';

class QrGeneratorScreen extends StatefulWidget {
  final SessionModel session;
  final String className;

  const QrGeneratorScreen({
    Key? key,
    required this.session,
    required this.className,
  }) : super(key: key);

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  late String _currentToken;
  int _secondsRemaining = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _generateNewToken();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _generateNewToken() {
    final rand = Random();
    final chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final code = List.generate(6, (_) => chars[rand.nextInt(chars.length)]).join();
    final token = 'TSV-${widget.session.id}-$code';
    ApiService.instance.currentDynamicQrCode = token; // Lưu mã QR động toàn cục
    setState(() {
      _currentToken = token;
      _secondsRemaining = 30;
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 1) {
        setState(() => _secondsRemaining--);
      } else {
        _generateNewToken();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final qrData = 'DIEMDANH:${widget.session.id}:$_currentToken';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã QR Điểm Danh Động'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    'LỚP: ${widget.className} | ${widget.session.tenBuoiHoc}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue.shade900),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Chiếu màn hình này lên máy chiếu để sinh viên quét trực tiếp từ app.',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // QR Code Box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 6)),
                ],
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Column(
                children: [
                  // QR Matrix Visualizer
                  SizedBox(
                    width: 240,
                    height: 240,
                    child: CustomPaint(
                      painter: _QrMatrixPainter(seedString: qrData),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: SelectableText(
                      'MÃ: $_currentToken',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 2, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Countdown Timer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        value: _secondsRemaining / 30.0,
                        strokeWidth: 5,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _secondsRemaining > 10 ? Colors.blue.shade700 : Colors.red,
                        ),
                      ),
                    ),
                    Text(
                      '$_secondsRemaining s',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: _secondsRemaining > 10 ? Colors.blue.shade900 : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mã QR tự động đổi sau mỗi 30s', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text('Chống chụp hình gửi điểm danh hộ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('LÀM MỚI MÃ QR NGAY', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: _generateNewToken,
            ),
            const SizedBox(height: 24),

            // Student submission proof note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: const Row(
                children: [
                  Icon(Icons.security, color: Colors.orange, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Đồ án môn học: Điểm danh sinh viên\nTác giả: Trần Hoàng Công Đăng - MSSV: 2380614670 (Nhóm TSV)',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
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
    final paintDark = Paint()..color = const Color(0xFF1A237E); // Dark Navy
    final paintFinder = Paint()..color = const Color(0xFF0D47A1);

    const int grid = 25;
    final cellSize = size.width / grid;

    // Draw 3 Corner Finder Patterns
    void drawFinder(double x, double y) {
      // Outer 7x7
      canvas.drawRect(Rect.fromLTWH(x * cellSize, y * cellSize, 7 * cellSize, 7 * cellSize), paintFinder);
      // Inner 5x5 white
      canvas.drawRect(
        Rect.fromLTWH((x + 1) * cellSize, (y + 1) * cellSize, 5 * cellSize, 5 * cellSize),
        Paint()..color = Colors.white,
      );
      // Center 3x3
      canvas.drawRect(Rect.fromLTWH((x + 2) * cellSize, (y + 2) * cellSize, 3 * cellSize, 3 * cellSize), paintFinder);
    }

    drawFinder(1, 1);
    drawFinder(grid - 8.0, 1);
    drawFinder(1, grid - 8.0);

    // Pseudorandom grid based on seed string hash
    int hash = seedString.hashCode;
    final rand = Random(hash.abs());

    for (int r = 0; r < grid; r++) {
      for (int c = 0; c < grid; c++) {
        // Skip finder pattern zones
        if ((r < 9 && c < 9) || (r < 9 && c >= grid - 9) || (r >= grid - 9 && c < 9)) {
          continue;
        }

        // Timing patterns
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
