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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      // Global theme — students can change the seed color to personalise the app.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

// ─── PortfolioPage ────────────────────────────────────────────────────────────
// StatefulWidget because we need to create GlobalKeys (which must persist
// across widget rebuilds) and a ScrollController.
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  // ── Section Keys ────────────────────────────────────────────────────────────
  // Each GlobalKey is assigned to one section Container.
  // Scrollable.ensureVisible(key.currentContext!) scrolls that widget into view.
  final Map<String, GlobalKey> _sectionKeys = {
    'about':      GlobalKey(),
    'projects':   GlobalKey(),
    'experience': GlobalKey(),
    'contact':    GlobalKey(),
  };

  // ScrollController lets us control the SingleChildScrollView programmatically.
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // Always dispose controllers to free resources.
    _scrollController.dispose();
    super.dispose();
  }

  // ── Scroll to Section ───────────────────────────────────────────────────────
  // Finds the widget associated with [sectionName] and smoothly scrolls to it.
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
    // MediaQuery lets us check screen width for responsive layouts.
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 800;

    return Scaffold(
      // ── Navigation AppBar ──────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade900,
        elevation: 1,
        // App name / logo on the left
        title: const Text(
          'Portfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // Nav links on the right — only show text links on desktop.
        // On mobile a hamburger menu (Drawer) would be the better UX pattern.
        // Students: try adding a Drawer for mobile as a bonus task!
        actions: isDesktop
            ? [
                _NavButton(label: 'About',      onTap: () => _scrollToSection('about')),
                _NavButton(label: 'Projects',   onTap: () => _scrollToSection('projects')),
                _NavButton(label: 'Experience', onTap: () => _scrollToSection('experience')),
                _NavButton(label: 'Contact',    onTap: () => _scrollToSection('contact')),
                const SizedBox(width: 16),
              ]
            : [
                // On mobile: simple icon buttons for key sections
                IconButton(
                  icon: const Icon(Icons.work_outline),
                  tooltip: 'Projects',
                  onPressed: () => _scrollToSection('projects'),
                ),
                IconButton(
                  icon: const Icon(Icons.mail_outline),
                  tooltip: 'Contact',
                  onPressed: () => _scrollToSection('contact'),
                ),
              ],
      ),

      // ── Page Body: Single Scrollable Column ────────────────────────────────
      // SingleChildScrollView makes the full page scrollable.
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // ── 1. Hero Section ────────────────────────────────────────────
            // No GlobalKey needed — it's the first thing visible on load.
            HeroSection(sectionKeys: _sectionKeys),

            // ── 2. About Section ───────────────────────────────────────────
            // The Container with a GlobalKey is what gets scrolled to.
            Container(
              key: _sectionKeys['about'],
              child: const AboutSection(),
            ),

            // ── 3. Projects Section ────────────────────────────────────────
            Container(
              key: _sectionKeys['projects'],
              child: const ProjectsSection(),
            ),

            // ── 4. Experience Section ──────────────────────────────────────
            Container(
              key: _sectionKeys['experience'],
              child: const ExperienceSection(),
            ),

            // ── 5. Contact Section ─────────────────────────────────────────
            Container(
              key: _sectionKeys['contact'],
              child: const ContactSection(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Nav Button Widget ────────────────────────────────────────────────────────
// A simple text button used in the AppBar for desktop navigation.
// Extracted as a separate widget to avoid repetition.
class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
