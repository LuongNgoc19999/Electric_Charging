import 'dart:math';
import 'package:flutter/material.dart';

class WaveWidget extends StatefulWidget {
  final double waveHeight;
  final Color color;

  const WaveWidget({
    super.key,
    required this.waveHeight,
    required this.color,
  });

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: WaterWavePainter(
            animationValue: _controller.value,
            waveHeight: widget.waveHeight,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class WaterWavePainter extends CustomPainter {
  final double animationValue;
  final double waveHeight;
  final Color color;

  WaterWavePainter({
    required this.animationValue,
    required this.waveHeight,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    double waveWidth = size.width;
    double waveMidHeight = size.height - waveHeight;

    path.moveTo(0, waveMidHeight);

    for (double i = 0; i <= waveWidth; i++) {
      path.lineTo(
        i,
        waveMidHeight +
            sin((i / waveWidth * 2 * pi) + (animationValue * 2 * pi)) * 10,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(
      path,
      Paint()..color = color.withOpacity(0.6),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




class WaveWidget1 extends StatefulWidget {
  final Color color;
  final double height;

  const WaveWidget1({
    super.key,
    required this.color,
    this.height = 200,
  });

  @override
  State<WaveWidget1> createState() => _WaveWidgetState1();
}

class _WaveWidgetState1 extends State<WaveWidget1>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          size: Size(double.infinity, widget.height),
          painter: WavePainter(_controller.value, widget.color),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double progress;
  final Color color;

  WavePainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(0.7);

    final path = Path();

    double waveHeight = 16;
    double speed = progress * 2 * pi;

    path.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      double y = sin((x / size.width * 2 * pi) + speed) * waveHeight + size.height / 2;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => true;
}
Widget buildChargingCircle() {
  return SizedBox(
    width: 260,
    height: 260,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Vòng tròn ngoài
        Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green.shade300, width: 10),
          ),
        ),

        // Sóng nước bên trong
        ClipOval(
          child: WaveWidget1(
            height: 260,
            color: Colors.green.shade300,
          ),
        ),

        // Xe máy
        Positioned(
          bottom: 50,
          child: Icon(Icons.battery_charging_full, size: 100, color: Colors.green),
        ),
      ],
    ),
  );
}