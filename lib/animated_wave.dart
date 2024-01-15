import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedWave extends StatefulWidget {
  const AnimatedWave({super.key});

  @override
  State<AnimatedWave> createState() => _AnimatedWaveState();
}

class _AnimatedWaveState extends State<AnimatedWave> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4), lowerBound: 0.18, upperBound: 0.8)
          ..repeat(reverse: true, period: const Duration(seconds: 3));

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Offset?> points = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff29537B),
        body: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              points.add(renderBox.globalToLocal(details.globalPosition));
            });
          },
          onPanEnd: (details) {
            points.add(null); // Add null to indicate the end of a drawing stroke
          },
          child: Stack(
            children: [
              CustomPaint(
                painter: BrushPaint(points),
                size: const Size(double.infinity, double.infinity),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Positioned(
                bottom: -100,
                left: 100,
                right: 100,
                child: Transform.rotate(
                  angle: 135,
                  child: Transform.scale(
                    scale: controller.value * 10,
                    origin: const Offset(0, 80),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white10,
                      radius: 150,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                points.clear();
                              });
                            },
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Welcome",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "This is your space to have an honest conversation with God.",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Nothing is off-limits, simply come as you are.",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Take a few deep breaths, and invite God to speak with you",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BrushPaint extends CustomPainter {
  final List<Offset?> points;

  BrushPaint(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff346391)
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
