// sections/experience_section.dart
//
// The EXPERIENCE section shows a vertical timeline of past roles.
//
// TIMELINE TECHNIQUE:
// Each item has a vertical line on the left, a coloured dot, and then
// the text content to the right. We build this manually using a Row:
//
//   [Line + Dot]  |  [Company / Role / Duration / Description]
//
// A real timeline library (like timeline_tile) could do this more elegantly —
// students can replace this with one as a bonus task!

import 'package:flutter/material.dart';
import '../models/portfolio_data.dart';
import '../widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: 'Experience'),

          // Build one timeline item per experience entry
          ...PortfolioData.experiences.asMap().entries.map((entry) {
            final int index = entry.key;
            final Experience exp = entry.value;
            final bool isLast = index == PortfolioData.experiences.length - 1;
            return _TimelineItemHoverWrapper(
              exp: exp,
              isLast: isLast,
              index: index,
            );
          }),
        ],
      ),
    );
  }
}

class _TimelineItemHoverWrapper extends StatefulWidget {
  final Experience exp;
  final bool isLast;
  final int index;

  const _TimelineItemHoverWrapper({
    required this.exp,
    required this.isLast,
    required this.index,
  });

  @override
  State<_TimelineItemHoverWrapper> createState() => _TimelineItemHoverWrapperState();
}

class _TimelineItemHoverWrapperState extends State<_TimelineItemHoverWrapper> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(_isHovered ? 10 : 0, 0, 0),
        child: IntrinsicHeight(
          // IntrinsicHeight makes the Row children adopt the height of the tallest child.
          // Without it, the vertical line (which uses double.infinity height) would fail.
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Left column: dot + vertical line ─────────────────────────────
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    // Coloured dot marker
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _isHovered ? 20 : 16,
                      height: _isHovered ? 20 : 16,
                      decoration: BoxDecoration(
                        color: _isHovered ? Colors.blue : Colors.blueAccent,
                        shape: BoxShape.circle,
                        boxShadow: _isHovered
                            ? [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ]
                            : [],
                      ),
                    ),
                    // Vertical line connecting to the next item (not shown on last item)
                    if (!widget.isLast)
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: _isHovered ? 4 : 2,
                          color: _isHovered
                              ? Colors.blue.shade200
                              : Colors.blue.shade100,
                        ),
                      ),
                  ],
                ),
              ),

              // ── Right column: text content ─────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Position title
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: _isHovered ? Colors.blue.shade900 : Colors.black87,
                        ),
                        child: Text(widget.exp.position),
                      ),
                      const SizedBox(height: 4),

                      // Company name
                      Text(
                        widget.exp.company,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Duration badge
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? Colors.blue.shade100
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.exp.duration,
                          style: TextStyle(
                              fontSize: 12, color: Colors.blue.shade900),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Description
                      Text(
                        widget.exp.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
