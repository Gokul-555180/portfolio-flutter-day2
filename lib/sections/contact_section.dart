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

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import '../models/portfolio_data.dart';
import '../widgets/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      color: Colors.blue.shade50,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: 'Contact'),

          const Text(
            "Let's work together! Reach out via any of the channels below.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 32),

          // ── Contact Items ──────────────────────────────────────────────────
          _ContactItemHoverWrapper(
            icon: Icons.email_outlined,
            label: 'Email',
            value: PortfolioData.email,
            url: 'mailto:${PortfolioData.email}',
          ),
          _ContactItemHoverWrapper(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: PortfolioData.phone,
            url: 'tel:${PortfolioData.phone}',
          ),
          _ContactItemHoverWrapper(
            icon: Icons.link,
            label: 'LinkedIn',
            value: PortfolioData.linkedin,
            url: 'https://${PortfolioData.linkedin}',
          ),
          _ContactItemHoverWrapper(
            icon: Icons.code,
            label: 'GitHub',
            value: PortfolioData.github,
            url: 'https://${PortfolioData.github}',
          ),

          const SizedBox(height: 48),

          // ── Footer ─────────────────────────────────────────────────────────
          const Center(
            child: Text(
              'Built with Flutter Web ❤️',
              style: TextStyle(color: Colors.black38, fontSize: 13),
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

  const _ContactItemHoverWrapper({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(_isHovered ? 10 : 0, 0, 0),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: InkWell(
            // InkWell adds a ripple tap effect and calls onTap when pressed.
            onTap: _launchUrl,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Icon
                  Icon(widget.icon, color: Colors.blueAccent, size: 22),
                  const SizedBox(width: 16),

                  // Label (fixed width so values line up)
                  SizedBox(
                    width: 80,
                    child: Text(
                      widget.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  // Tappable value
                  Expanded(
                    child: Text(
                      widget.value,
                      style: TextStyle(
                        color: Colors.blue.shade700,
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
    );
  }
}
