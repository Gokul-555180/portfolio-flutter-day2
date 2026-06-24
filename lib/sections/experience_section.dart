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
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
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
    final theme = Theme.of(context);
    
    // Distribute accent colors along timeline points
    Color markerColor = const Color(0xFF4361EE); // Soft Blue
    if (widget.index == 1) {
      markerColor = const Color(0xFF7209B7); // Violet
    } else if (widget.index == 2) {
      markerColor = const Color(0xFF3F37C9); // Indigo
    } else if (widget.index >= 3) {
      markerColor = const Color(0xFF4CC9F0); // Cyan
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(_isHovered ? 8 : 0, 0, 0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Left column: dot + vertical line ──
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    // Animated Dot Marker
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _isHovered ? 18 : 14,
                      height: _isHovered ? 18 : 14,
                      decoration: BoxDecoration(
                        color: markerColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: markerColor.withOpacity(_isHovered ? 0.6 : 0.25),
                            blurRadius: _isHovered ? 10 : 6,
                            spreadRadius: _isHovered ? 3 : 1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Vertical line connecting to the next item
                    if (!widget.isLast)
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: _isHovered ? 3 : 1.5,
                          color: _isHovered
                              ? markerColor.withOpacity(0.5)
                              : theme.colorScheme.outline.withOpacity(0.5),
                        ),
                      ),
                  ],
                ),
              ),

              // ── Right column: text content ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Position title
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          color: _isHovered ? markerColor : theme.colorScheme.onSurface,
                        ),
                        child: Text(widget.exp.position),
                      ),
                      const SizedBox(height: 4),

                      // Company name
                      Text(
                        widget.exp.company,
                        style: TextStyle(
                          fontSize: 15,
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Duration badge (Material 3 style)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: markerColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: markerColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          widget.exp.duration,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: markerColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Description
                      Text(
                        widget.exp.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
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
