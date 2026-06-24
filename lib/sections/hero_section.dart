import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/portfolio_data.dart';

class HeroSection extends StatefulWidget {
  final Map<String, GlobalKey> sectionKeys;

  const HeroSection({super.key, required this.sectionKeys});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late AnimationController _avatarController;
  late AnimationController _rotationController;
  bool _isAvatarHovered = false;

  @override
  void initState() {
    super.initState();
    _avatarController = AnimationController(
       vsync: this,
       duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    
    _rotationController = AnimationController(
       vsync: this,
       duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _avatarController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 800;

    return Stack(
      children: [
        // ── Hero Content ──
        Container(
          padding: EdgeInsets.fromLTRB(
            isDesktop ? 80 : 24,
            isDesktop ? 180 : 130,
            isDesktop ? 80 : 24,
            isDesktop ? 120 : 80,
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
        ),
      ],
    );
  }

  // ── Desktop Layout ──
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildTextContent(context, true)),
        const SizedBox(width: 80),
        _buildAvatar(),
      ],
    );
  }

  // ── Mobile Layout ──
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAvatar(),
        const SizedBox(height: 48),
        _buildTextContent(context, false),
      ],
    );
  }

  // ── Profile Image inside Large Organic Glassmorphic Shape ──
  Widget _buildAvatar() {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isAvatarHovered = true),
      onExit: (_) => setState(() => _isAvatarHovered = false),
      child: AnimatedBuilder(
        animation: Listenable.merge([_avatarController, _rotationController]),
        builder: (context, child) {
          double hoverScale = _isAvatarHovered ? 1.05 : 1.0;
          double pulseScale = _avatarController.value * 0.02;
          double totalScale = hoverScale + pulseScale;

          return Transform.scale(
            scale: totalScale,
            child: child,
          );
        },
        child: SizedBox(
          width: 300,
          height: 320,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // ── Blue-violet Glow Behind Image ──
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 200,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7209B7).withOpacity(_isAvatarHovered ? 0.35 : 0.25),
                      blurRadius: 50,
                      spreadRadius: 8,
                    ),
                    BoxShadow(
                      color: const Color(0xFF4361EE).withOpacity(_isAvatarHovered ? 0.35 : 0.25),
                      blurRadius: 50,
                      spreadRadius: -2,
                    ),
                  ],
                ),
              ),

              // ── Floating Blurred Circles Around Image ──
              // Circle 1 (Top Left)
              Positioned(
                left: 15,
                top: 25,
                child: AnimatedBuilder(
                  animation: _avatarController,
                  builder: (context, child) {
                    double offset = math.sin(_avatarController.value * math.pi * 2) * 10;
                    return Transform.translate(
                      offset: Offset(-offset, offset),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF4CC9F0).withOpacity(0.12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4CC9F0).withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Circle 2 (Bottom Right)
              Positioned(
                right: 15,
                bottom: 35,
                child: AnimatedBuilder(
                  animation: _avatarController,
                  builder: (context, child) {
                    double offset = math.cos(_avatarController.value * math.pi * 2) * 12;
                    return Transform.translate(
                      offset: Offset(offset, -offset),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF7209B7).withOpacity(0.1),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7209B7).withOpacity(0.08),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ── Organic Glassmorphic Shape Outer Border ──
              RotationTransition(
                turns: _rotationController,
                child: Container(
                  width: 230,
                  height: 260,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                      topRight: Radius.circular(80),
                      bottomLeft: Radius.circular(130),
                      bottomRight: Radius.circular(90),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF4361EE), // Soft Blue
                        Color(0xFF7209B7), // Violet
                        Color(0xFF4CC9F0), // Cyan
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),

              // ── Inner Mask matching organic shape (Glassmorphic) ──
              ClipPath(
                clipper: _OrganicShapeClipper(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 222,
                    height: 252,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                    ),
                  ),
                ),
              ),

              // ── Profile Image Clipped to organic shape ──
              ClipPath(
                clipper: _OrganicShapeClipper(),
                child: Container(
                  width: 220,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                  ),
                  child: PortfolioData.avatarImage.isNotEmpty
                      ? (PortfolioData.avatarImage.startsWith('http')
                          ? Image.network(PortfolioData.avatarImage, fit: BoxFit.cover)
                          : Image.asset(PortfolioData.avatarImage, fit: BoxFit.cover))
                      : Icon(Icons.person, size: 100, color: theme.colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Text Content + Buttons ──
  Widget _buildTextContent(BuildContext context, bool isDesktop) {
    final theme = Theme.of(context);
    final textAlignment = isDesktop ? TextAlign.left : TextAlign.center;
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Name
        Text(
          PortfolioData.name,
          textAlign: textAlignment,
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: isDesktop ? 56 : 40,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
            height: 1.1,
          ),
        ),

        const SizedBox(height: 16),

        // Professional title
        Text(
          PortfolioData.title,
          textAlign: textAlignment,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: isDesktop ? 22 : 18,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 24),

        // Short introduction paragraph
        Text(
          PortfolioData.intro,
          textAlign: textAlignment,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w300, // thin elegant typography
            color: Colors.white.withOpacity(0.7),
            height: 1.6,
          ),
        ),

        const SizedBox(height: 40),

        // ── CTA Buttons ──
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            FuturisticButton(
              label: 'View Projects',
              onPressed: () => _scrollToSection('projects'),
              isPrimary: true,
            ),
            FuturisticButton(
              label: 'Contact Me',
              onPressed: () => _scrollToSection('contact'),
              isPrimary: false,
            ),
          ],
        ),
      ],
    );
  }

  // ── Scroll Helper ──
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

// ── Custom Organic Shape Clipper ──
class _OrganicShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width * 0.45, 0);
    path.quadraticBezierTo(size.width * 0.85, 0, size.width, size.height * 0.25);
    path.quadraticBezierTo(size.width, size.height * 0.75, size.width * 0.65, size.height);
    path.quadraticBezierTo(size.width * 0.1, size.height, 0, size.height * 0.65);
    path.quadraticBezierTo(0, size.height * 0.2, size.width * 0.45, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ── Futuristic Pill Glassmorphic Button ──
class FuturisticButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const FuturisticButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  State<FuturisticButton> createState() => _FuturisticButtonState();
}

class _FuturisticButtonState extends State<FuturisticButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Cyber gradient colors
    final primaryGradient = const LinearGradient(
      colors: [
        Color(0xFF4361EE), // Soft Blue
        Color(0xFF7209B7), // Violet
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final secondaryGradient = const LinearGradient(
      colors: [
        Color(0xFF7209B7), // Violet
        Color(0xFF4CC9F0), // Cyan
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final glowColor = widget.isPrimary ? const Color(0xFF4361EE) : const Color(0xFF7209B7);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: _isHovered
                ? (widget.isPrimary ? primaryGradient : secondaryGradient)
                : null,
            color: _isHovered ? null : Colors.white.withOpacity(0.04),
            border: Border.all(
              color: _isHovered 
                  ? Colors.transparent 
                  : Colors.white.withOpacity(widget.isPrimary ? 0.15 : 0.25),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: glowColor.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: InkWell(
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    widget.label,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 0.5,
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
