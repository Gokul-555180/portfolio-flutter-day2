import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/portfolio_data.dart';
import '../widgets/section_title.dart';
import '../widgets/glass_container.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1000),
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
            const SectionTitle(text: 'About Me'),

            // ── About + Education row/column ──
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildAboutText(context)),
                      const SizedBox(width: 80),
                      Expanded(child: _buildEducation(context)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAboutText(context),
                      const SizedBox(height: 48),
                      _buildEducation(context),
                    ],
                  ),

            const SizedBox(height: 56),

            // ── Skills ──
            Text(
              'Skills',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSkills(),
          ],
        ),
      ),
    );
  }

  // ── About Me paragraph ──
  Widget _buildAboutText(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who I Am',
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 12),
        Text(
          PortfolioData.aboutMe,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 15,
            height: 1.7,
          ),
        ),
      ],
    );
  }

  // ── Education block ──
  Widget _buildEducation(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Education',
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 12),

        GlassContainer(
          borderRadius: 16,
          bgOpacity: 0.02,
          borderOpacity: 0.06,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                PortfolioData.degree,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                PortfolioData.university,
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Graduated: ${PortfolioData.graduationYear}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Skills Wrap ──
  Widget _buildSkills() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
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
    final theme = Theme.of(context);
    
    // Choose accent color based on category
    Color accentColor = const Color(0xFF4361EE); // Soft Blue for Mobile
    if (widget.skill.category == 'Backend') {
      accentColor = const Color(0xFF7209B7); // Violet
    } else if (widget.skill.category == 'Web') {
      accentColor = const Color(0xFF3F37C9); // Indigo
    } else if (widget.skill.category == 'Design') {
      accentColor = const Color(0xFF4CC9F0); // Cyan
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(_isHovered ? 0.08 : 0.02),
                border: Border.all(
                  color: _isHovered 
                      ? accentColor 
                      : Colors.white.withOpacity(0.08),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(100),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: accentColor.withOpacity(0.2),
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
                      color: accentColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withOpacity(0.4),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.skill.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: _isHovered ? Colors.white : theme.colorScheme.onSurface.withOpacity(0.8),
                      fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
