// sections/contact_section.dart
//
// The CONTACT section displays social/contact links.
//
// Each link is shown as a row with:
//   [Icon]  [Label]  [Value]
//
// We use dart:html (available on Flutter Web with no extra packages)
// to open URLs. On non-web targets this is conditionally ignored.
//
// NOTE FOR STUDENTS:
// dart:html only works on Flutter Web. If you later add mobile support,
// replace the _launchUrl helper with the url_launcher package.

import 'dart:html' as html;
import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/portfolio_data.dart';
import '../widgets/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: 'Contact'),

          Text(
            "Let's work together! Reach out via any of the channels below.",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 40),

          // ── Contact Items ──
          _ContactItemHoverWrapper(
            icon: Icons.email_outlined,
            label: 'Email',
            value: PortfolioData.email,
            url: 'mailto:${PortfolioData.email}',
            iconColor: const Color(0xFF4361EE), // Soft Blue
          ),
          _ContactItemHoverWrapper(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: PortfolioData.phone,
            url: 'tel:${PortfolioData.phone}',
            iconColor: const Color(0xFF4CC9F0), // Cyan
          ),
          _ContactItemHoverWrapper(
            icon: Icons.link,
            label: 'LinkedIn',
            value: PortfolioData.linkedin,
            url: 'https://${PortfolioData.linkedin}',
            iconColor: const Color(0xFF3F37C9), // Indigo
          ),
          _ContactItemHoverWrapper(
            icon: Icons.code,
            label: 'GitHub',
            value: PortfolioData.github,
            url: 'https://${PortfolioData.github}',
            iconColor: const Color(0xFF7209B7), // Violet
          ),

          const SizedBox(height: 64),

          // ── Footer ──
          Center(
            child: Text(
              'Built with Flutter Web ❤️',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.4),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactItemHoverWrapper extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;
  final Color iconColor;

  const _ContactItemHoverWrapper({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    required this.iconColor,
  });

  @override
  State<_ContactItemHoverWrapper> createState() => _ContactItemHoverWrapperState();
}

class _ContactItemHoverWrapperState extends State<_ContactItemHoverWrapper> {
  bool _isHovered = false;

  void _launchUrl() {
    html.window.open(widget.url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(_isHovered ? 8 : 0, 0, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(_isHovered ? 0.08 : 0.02),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered 
                        ? widget.iconColor.withOpacity(0.4) 
                        : Colors.white.withOpacity(0.06),
                    width: 1,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: widget.iconColor.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : [],
                ),
                child: InkWell(
                  onTap: _launchUrl,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        // Icon styled with specific Color circle background
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: widget.iconColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(widget.icon, color: widget.iconColor, size: 22),
                        ),
                        const SizedBox(width: 20),

                        // Label
                        SizedBox(
                          width: 90,
                          child: Text(
                            widget.label,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),

                        // Tappable value
                        Expanded(
                          child: Text(
                            widget.value,
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
