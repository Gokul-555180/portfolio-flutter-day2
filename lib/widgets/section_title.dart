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
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 8),

        // ── Decorative Google colored underline bar ──────────────────────────────────────
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4361EE), // Soft Blue
                Color(0xFF7209B7), // Violet
                Color(0xFF4CC9F0), // Cyan
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        const SizedBox(height: 32), // Space below the title before content
      ],
    );
  }
}
