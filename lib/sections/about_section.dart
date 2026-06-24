// sections/about_section.dart
//
// The ABOUT section displays:
//   • A short "About Me" paragraph
//   • Education details
//   • A skills grid
//
// LAYOUT:
//   On desktop: About text | Education (side by side)
//   On mobile: stacked vertically
//   Skills: always a Wrap of Chip widgets below

import 'package:flutter/material.dart';
import '../models/portfolio_data.dart';
import '../widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 60,
      ),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.decelerate,
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: child,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reusable section heading widget
            const SectionTitle(text: 'About Me'),

          // ── About + Education row/column ────────────────────────────────
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildAboutText()),
                    const SizedBox(width: 60),
                    Expanded(child: _buildEducation()),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAboutText(),
                    const SizedBox(height: 32),
                    _buildEducation(),
                  ],
                ),

          const SizedBox(height: 48),

          // ── Skills ───────────────────────────────────────────────────────
          const Text(
            'Skills',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSkills(),
        ],
      ),
    ),
   );
  }

  // ── About Me paragraph ─────────────────────────────────────────────────────
  Widget _buildAboutText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Who I Am',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          PortfolioData.aboutMe,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black54,
            height: 1.7,
          ),
        ),
      ],
    );
  }

  // ── Education block ────────────────────────────────────────────────────────
  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Education',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // A simple Card to visually group the education info.
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Degree name
                Text(
                  PortfolioData.degree,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),

                // University name
                Text(
                  PortfolioData.university,
                  style: TextStyle(color: Colors.blue.shade700),
                ),
                const SizedBox(height: 4),

                // Graduation year
                Text(
                  'Graduated: ${PortfolioData.graduationYear}',
                  style: const TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Skills Wrap ────────────────────────────────────────────────────────────
  // Groups each skill with a category label using a FilterChip-style appearance.
  Widget _buildSkills() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: PortfolioData.skills.map((skill) {
        return _SkillChip(skill: skill);
      }).toList(),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final Skill skill;

  const _SkillChip({required this.skill});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.blue.shade50 : Colors.white,
          border: Border.all(
              color: _isHovered ? Colors.blueAccent : Colors.blue.shade300),
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _isHovered ? Colors.blueAccent : Colors.blue.shade300,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.skill.name,
              style: TextStyle(
                fontSize: 14,
                color: _isHovered ? Colors.blue.shade900 : Colors.black87,
                fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
