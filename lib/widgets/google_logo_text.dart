import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleLogoText extends StatelessWidget {
  final double fontSize;

  const GoogleLogoText({super.key, this.fontSize = 22});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color(0xFF4361EE), // Soft Blue
          Color(0xFF7209B7), // Violet
          Color(0xFF4CC9F0), // Cyan
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        'Gokul Portfolio',
        style: GoogleFonts.outfit(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          color: Colors.white, // Required for ShaderMask to paint properly
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}
