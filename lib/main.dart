// main.dart
//
// Entry point of the Flutter Web Portfolio application.
//
// ARCHITECTURE OVERVIEW:
// The entire site is a single scrollable Column (Single Page Application).
// A top AppBar acts as the navigation menu. Tapping a nav link uses
// Scrollable.ensureVisible() with a GlobalKey to smooth-scroll to that section.
//
// NAVIGATION FLOW:
//   AppBar nav links → scroll to section via GlobalKey + Scrollable.ensureVisible()
//   Hero buttons     → same scrolling mechanism
//
// STRUCTURE:
//   MyApp
//   └── PortfolioPage (StatefulWidget — manages scroll keys + controller)
//       ├── AppBar (nav menu)
//       └── SingleChildScrollView
//           ├── HeroSection
//           ├── AboutSection      ← has a GlobalKey
//           ├── ProjectsSection   ← has a GlobalKey
//           ├── ExperienceSection ← has a GlobalKey
//           └── ContactSection    ← has a GlobalKey

import 'package:flutter/material.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';
import 'theme/google_theme.dart';
import 'widgets/google_logo_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/glass_container.dart';
import 'widgets/google_gemini_particles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gokul\'s Portfolio',
      debugShowCheckedModeBanner: false,
      theme: GoogleTheme.lightTheme(),
      darkTheme: GoogleTheme.darkTheme(),
      themeMode: _themeMode,
      home: PortfolioPage(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

// ─── PortfolioPage ────────────────────────────────────────────────────────────
// StatefulWidget because we need to create GlobalKeys (which must persist
// across widget rebuilds) and a ScrollController.
class PortfolioPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const PortfolioPage({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  // ── Section Keys ────────────────────────────────────────────────────────────
  final Map<String, GlobalKey> _sectionKeys = {
    'about':      GlobalKey(),
    'projects':   GlobalKey(),
    'experience': GlobalKey(),
    'contact':    GlobalKey(),
  };

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ── Scroll to Section ───────────────────────────────────────────────────────
  void _scrollToSection(String sectionName) {
    final key = _sectionKeys[sectionName];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      // ── Google Workspace Style Drawer (Mobile) ──────────────────────────────
      drawer: !isDesktop
          ? _PortfolioDrawer(
              sectionKeys: _sectionKeys,
              onSectionTap: _scrollToSection,
              isDarkMode: widget.isDarkMode,
              onToggleTheme: widget.onToggleTheme,
            )
          : null,

      // ── Floating Glassmorphic AppBar ──
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: GlassContainer(
            borderRadius: 24,
            bgOpacity: 0.03,
            borderOpacity: 0.06,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const GoogleLogoText(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isDesktop) ...[
                      _NavButton(label: 'About',      onTap: () => _scrollToSection('about')),
                      _NavButton(label: 'Projects',   onTap: () => _scrollToSection('projects')),
                      _NavButton(label: 'Experience', onTap: () => _scrollToSection('experience')),
                      _NavButton(label: 'Contact',    onTap: () => _scrollToSection('contact')),
                    ],
                    IconButton(
                      icon: Icon(
                        widget.isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
                        color: widget.isDarkMode ? Colors.yellow.shade700 : const Color(0xFF5F6368),
                      ),
                      tooltip: 'Toggle Theme',
                      onPressed: widget.onToggleTheme,
                    ),
                    if (!isDesktop) ...[
                      const SizedBox(width: 8),
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // ── Page Body ──────────────────────────────────────────────────────────
      body: Stack(
        children: [
          // ── Fixed Gradient Background ──
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.isDarkMode
                      ? [
                          const Color(0xFF070014), // Deep Purple
                          const Color(0xFF0F0525), // Dark Violet
                          const Color(0xFF020205), // Black
                        ]
                      : [
                          const Color(0xFF030014), // Deep Space Navy
                          const Color(0xFF060521), // Indigo
                          const Color(0xFF010105), // Pure Black
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // ── Giant Soft Floating/Glowing Blobs ──
          Positioned(
            top: -150,
            right: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    (widget.isDarkMode ? const Color(0xFF7209B7) : const Color(0xFF4361EE)).withOpacity(0.12),
                    (widget.isDarkMode ? const Color(0xFF7209B7) : const Color(0xFF4361EE)).withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 350,
            left: -200,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    (widget.isDarkMode ? const Color(0xFF3F37C9) : const Color(0xFF4CC9F0)).withOpacity(0.12),
                    (widget.isDarkMode ? const Color(0xFF3F37C9) : const Color(0xFF4CC9F0)).withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -250,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    (widget.isDarkMode ? const Color(0xFF7209B7) : const Color(0xFF3F37C9)).withOpacity(0.12),
                    (widget.isDarkMode ? const Color(0xFF7209B7) : const Color(0xFF3F37C9)).withOpacity(0),
                  ],
                ),
              ),
            ),
          ),

          // ── Particle system spanning the background ──
          const Positioned.fill(
            child: GoogleGeminiParticles(),
          ),

          // ── Scrollable Foreground Content ──
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // ── 1. Hero Section ──
                  HeroSection(sectionKeys: _sectionKeys),

                  // ── 2. About Section ──
                  Container(
                    key: _sectionKeys['about'],
                    child: const AboutSection(),
                  ),

                  // ── 3. Projects Section ──
                  Container(
                    key: _sectionKeys['projects'],
                    child: const ProjectsSection(),
                  ),

                  // ── 4. Experience Section ──
                  Container(
                    key: _sectionKeys['experience'],
                    child: const ExperienceSection(),
                  ),

                  // ── 5. Contact Section ──
                  Container(
                    key: _sectionKeys['contact'],
                    child: const ContactSection(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Nav Button Widget with Hover Transition ──────────────────────────────────
class _NavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: TextButton(
          onPressed: widget.onTap,
          style: TextButton.styleFrom(
            foregroundColor: _isHovered ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.8),
            backgroundColor: _isHovered ? theme.colorScheme.primary.withOpacity(0.08) : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Google Workspace Sidebar styled Drawer ──────────────────────────────────
class _PortfolioDrawer extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;
  final Function(String) onSectionTap;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const _PortfolioDrawer({
    required this.sectionKeys,
    required this.onSectionTap,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(canvasColor: Colors.transparent),
      child: Drawer(
        elevation: 0,
        child: GlassContainer(
          borderRadius: 0,
          bgOpacity: 0.08,
          borderOpacity: 0.1,
          blur: 30,
          padding: EdgeInsets.zero,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      const GoogleLogoText(fontSize: 20),
                    ],
                  ),
                ),
                Divider(color: Colors.white.withOpacity(0.1)),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      _buildDrawerItem(
                        context,
                        icon: Icons.person_outline,
                        label: 'About',
                        onTap: () => onSectionTap('about'),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.work_outline,
                        label: 'Projects',
                        onTap: () => onSectionTap('projects'),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.history_edu,
                        label: 'Experience',
                        onTap: () => onSectionTap('experience'),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.mail_outline,
                        label: 'Contact',
                        onTap: () => onSectionTap('contact'),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.white.withOpacity(0.1)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isDarkMode ? 'Dark Theme' : 'Light Theme',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
                          color: isDarkMode ? Colors.yellow.shade700 : const Color(0xFF5F6368),
                        ),
                        onPressed: onToggleTheme,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(
          label,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        hoverColor: theme.colorScheme.primary.withOpacity(0.08),
        onTap: () {
          Navigator.pop(context); // Close the drawer
          onTap();
        },
      ),
    );
  }
}
