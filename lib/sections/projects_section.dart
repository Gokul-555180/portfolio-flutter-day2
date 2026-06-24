// sections/projects_section.dart
//
// The PROJECTS section displays a responsive grid of project cards.
//
// RESPONSIVE GRID:
//   Desktop (>=1000px): 3 columns
//   Tablet  (>=600px) : 2 columns
//   Mobile            : 1 column
//
// Flutter's LayoutBuilder widget lets us read the available width
// and choose the column count at runtime.

import 'package:flutter/material.dart';
import '../models/portfolio_data.dart';
import '../widgets/project_card.dart';
import '../widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      // Slightly off-white background to visually separate from other sections
      color: Colors.blue.shade50,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: 'Projects'),

          // ── Responsive Grid ──────────────────────────────────────────────
          // LayoutBuilder provides the BoxConstraints of its parent,
          // meaning we know the exact available width at build time.
          LayoutBuilder(
            builder: (context, constraints) {
              // Decide column count based on available width
              int columnCount;
              if (constraints.maxWidth >= 1000) {
                columnCount = 3; // Wide desktop
              } else if (constraints.maxWidth >= 600) {
                columnCount = 2; // Tablet / narrow desktop
              } else {
                columnCount = 1; // Mobile
              }

              // Build a manual grid using nested Rows inside a Column.
              // Alternative: GridView.count — students can try that too!
              return _buildGrid(columnCount);
            },
          ),
        ],
      ),
    );
  }

  // Splits the project list into rows of [columnCount] cards each.
  Widget _buildGrid(int columnCount) {
    final List<Project> projects = PortfolioData.projects;

    // Create rows: slice the projects list into chunks of columnCount.
    List<Widget> rows = [];
    for (int i = 0; i < projects.length; i += columnCount) {
      // Get the slice for this row (may be smaller on the last row)
      final rowProjects = projects.sublist(
        i,
        (i + columnCount > projects.length) ? projects.length : i + columnCount,
      );

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowProjects.map((project) {
              return Expanded(
                child: Padding(
                  // Add gap between cards in the same row
                  padding: EdgeInsets.only(
                    right: project != rowProjects.last ? 20 : 0,
                  ),
                  child: ProjectCard(project: project),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}
