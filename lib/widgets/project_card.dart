// widgets/project_card.dart
//
// A reusable card widget that displays one project in the Projects grid.
// It receives a Project object and renders:
//   • A coloured image placeholder rectangle
//   • The project title
//   • A short description
//   • Technology chip badges

import 'package:flutter/material.dart';
import '../models/portfolio_data.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Card adds a white background with a subtle shadow (elevation).
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        child: Card(
          elevation: _isHovered ? 12 : 2,
          shadowColor: Colors.blueAccent.withOpacity(0.5),
          // ClipRRect clips the card's children to its rounded corners.
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Column(
              // crossAxisAlignment.start aligns all children to the left edge.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Image Placeholder ────────────────────────────────────────
                // In a real app this would be an Image.network() or Image.asset().
                // For now it's a coloured box with the project name as a label.
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 140,
                  width: double.infinity, // Fill the full card width
                  color: _isHovered ? Colors.blue.shade200 : Colors.blue.shade100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.image_outlined,
                            size: 40, color: Colors.blue),
                        const SizedBox(height: 8),
                        Text(
                          widget.project.imageLabel,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Text content area ─────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project title
                      Text(
                        widget.project.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Project description
                      Text(
                        widget.project.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          height: 1.5, // Line height for readability
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ── Technology chips ─────────────────────────────────────
                      // Wrap lays out children left-to-right, wrapping to the next
                      // line when there's no more horizontal space.
                      Wrap(
                        spacing: 6,  // Horizontal gap between chips
                        runSpacing: 6, // Vertical gap between chip rows
                        children: widget.project.technologies.map((tech) {
                          // Chip is a Material Design label badge.
                          return Chip(
                            label: Text(
                              tech,
                              style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                            ),
                            backgroundColor: Colors.blue.shade50,
                            padding: EdgeInsets.zero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          );
                        }).toList(),
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
}
