// widgets/section_title.dart
//
// A simple reusable heading widget displayed at the top of each section.
// Every section (About, Projects, Experience, Contact) uses this.
//
// WHY A WIDGET?
// We avoid copy-pasting the same Text style in 5 places. If a student
// wants to change how all section titles look, they only edit one file.

import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text; // The heading text, e.g. 'About Me'

  const SectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      // Align the title and underline to the left
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section heading text ─────────────────────────────────────────
        Text(
          text,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 8),

        // ── Decorative underline bar ──────────────────────────────────────
        // A simple colored Container used as an underline accent.
        // Students: try changing the color, width, or height here!
        Container(
          width: 60,
          height: 4,
          color: Colors.blueAccent,
        ),

        const SizedBox(height: 32), // Space below the title before content
      ],
    );
  }
}
