import 'dart:math' as math;
import 'package:flutter/material.dart';

class GoogleGeminiParticles extends StatefulWidget {
  const GoogleGeminiParticles({super.key});

  @override
  State<GoogleGeminiParticles> createState() => _GoogleGeminiParticlesState();
}

class _GoogleGeminiParticlesState extends State<GoogleGeminiParticles> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    // Soft blue, violet, indigo, and cyan accent colors for a futuristic dark-tech look
    final colors = [
      const Color(0xFF4361EE), // Soft Blue
      const Color(0xFF7209B7), // Violet
      const Color(0xFF3F37C9), // Indigo
      const Color(0xFF4CC9F0), // Cyan/Teal
    ];

    for (int i = 0; i < 15; i++) {
      _particles.add(
        _Particle(
          color: colors[i % colors.length],
          baseRadius: _random.nextDouble() * 120 + 80, // Giant soft blobs
          speedX: (_random.nextDouble() - 0.5) * 0.015, // Extremely slow drift
          speedY: (_random.nextDouble() - 0.5) * 0.015,
          phase: _random.nextDouble() * math.pi * 2,
          baseX: _random.nextDouble(),
          baseY: _random.nextDouble(),
        ),
      );
    }
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
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(
            particles: _particles,
            animationValue: _controller.value,
          ),
          child: Container(),
        );
      },
    );
  }
}

class _Particle {
  final Color color;
  final double baseRadius;
  final double speedX;
  final double speedY;
  final double phase;
  final double baseX;
  final double baseY;

  _Particle({
    required this.color,
    required this.baseRadius,
    required this.speedX,
    required this.speedY,
    required this.phase,
    required this.baseX,
    required this.baseY,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double animationValue;

  _ParticlePainter({required this.particles, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      // Calculate position with drift and wrap around screen bounds
      double x = (particle.baseX + particle.speedX * animationValue * 15) % 1.0;
      double y = (particle.baseY + particle.speedY * animationValue * 15) % 1.0;

      double posX = x * size.width;
      double posY = y * size.height;

      // Add fluid vertical/horizontal wave movement
      double waveOffset = math.sin(animationValue * math.pi * 2 + particle.phase) * 20;
      posY += waveOffset;
      posX += math.cos(animationValue * math.pi * 2 + particle.phase) * 10;

      double pulse = 1.0 + 0.1 * math.sin(animationValue * math.pi * 4 + particle.phase);
      double radius = particle.baseRadius * pulse;
      double opacity = 0.04 + 0.02 * math.sin(animationValue * math.pi * 2 + particle.phase);

      final paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = RadialGradient(
          colors: [
            particle.color.withOpacity(opacity),
            particle.color.withOpacity(0.0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(posX, posY), radius: radius));

      canvas.drawCircle(Offset(posX, posY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
