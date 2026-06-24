// sections/hero_section.dart
//
// The HERO is the first thing visitors see — it fills most of the viewport.
//
// LAYOUT (desktop):
//   [Left column: text + buttons]   [Right column: avatar placeholder]
//
// LAYOUT (mobile):
//   [Avatar]
//   [Text + buttons]  (stacked vertically)
//
// RESPONSIVE TECHNIQUE:
// We check MediaQuery.of(context).size.width. If width >= 800 we use a Row
// for side-by-side layout; otherwise we use a Column for a stacked layout.

import 'package:flutter/material.dart';
import '../models/portfolio_data.dart';

class HeroSection extends StatefulWidget {
  // ScrollController lets us scroll the page when a nav button is tapped.
  // The keys let us scroll to specific sections.
  final Map<String, GlobalKey> sectionKeys;

  const HeroSection({super.key, required this.sectionKeys});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _avatarController;

  @override
  void initState() {
    super.initState();
    _avatarController = AnimationController(
       vsync: this,
       duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery gives us the current screen width.
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 800; // Breakpoint: 800px

    return Container(
      // ── Background colour of the hero ─────────────────────────────────────
      // Students: try a gradient with BoxDecoration instead!
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      // Padding: more horizontal space on desktop, less on mobile.
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),

      child: TweenAnimationBuilder<double>(
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 50 * (1 - value)),
              child: isDesktop
                  ? _buildDesktopLayout(context)
                  : _buildMobileLayout(context),
            ),
          );
        },
      ),
    );
  }

  // ── Desktop: side-by-side Row layout ──────────────────────────────────────
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Left side expands to fill available space
        Expanded(child: _buildTextContent(context)),
        const SizedBox(width: 60),
        _buildAvatar(),
      ],
    );
  }

  // ── Mobile: vertically stacked Column layout ───────────────────────────────
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAvatar(),
        const SizedBox(height: 40),
        _buildTextContent(context),
      ],
    );
  }

  // ── Profile Image Placeholder ──────────────────────────────────────────────
  Widget _buildAvatar() {
    // CircleAvatar with a large radius acts as the profile photo placeholder.
    return AnimatedBuilder(
      animation: _avatarController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_avatarController.value * 0.05),
          child: child,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: CircleAvatar(
  radius: 100,
  backgroundColor: Colors.blue.shade200,
  backgroundImage: PortfolioData.avatarImage.isNotEmpty
      ? (PortfolioData.avatarImage.startsWith('http')
          ? NetworkImage(PortfolioData.avatarImage)
          : AssetImage(PortfolioData.avatarImage) as ImageProvider)
      : null,
  child: PortfolioData.avatarImage.isEmpty
      ? const Icon(Icons.person, size: 100, color: Colors.white)
      : null,
),
      ),
    );
  }

  // ── Text Content + Buttons ─────────────────────────────────────────────────
  Widget _buildTextContent(BuildContext context) {
    return Column(
      // On mobile the column fills the full width, align text to the left.
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text(
          PortfolioData.name,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 8),

        // Professional title
        Text(
          PortfolioData.title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue.shade700,
          ),
        ),

        const SizedBox(height: 20),

        // Short introduction paragraph
        Text(
          PortfolioData.intro,
          style: TextStyle(
            shadows: [
              Shadow(
                blurRadius: 5,
                color: Colors.blueAccent.withOpacity(0.5),
              ),
            ],
            fontSize: 16,
            color: Colors.black54,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 32),

        // ── CTA Buttons ────────────────────────────────────────────────────
        // Wrap so buttons stack on narrow screens.
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            // "View Projects" scrolls to the Projects section.
            ElevatedButton(
              onPressed: () => _scrollToSection('projects'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 16),
              ),
              child: const Text('View Projects'),
            ),

            // "Contact Me" scrolls to the Contact section.
            OutlinedButton(
              onPressed: () => _scrollToSection('contact'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                side: const BorderSide(color: Colors.blueAccent, width: 2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 16),
              ),
              child: const Text('Contact Me'),
            ),
          ],
        ),
      ],
    );
  }

  // ── Scroll Helper ──────────────────────────────────────────────────────────
  // Uses the GlobalKey stored in sectionKeys to find the widget on screen
  // and smoothly scroll to it.
  void _scrollToSection(String key) {
    final globalKey = widget.sectionKeys[key];
    if (globalKey?.currentContext != null) {
      Scrollable.ensureVisible(
        globalKey!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }
}
