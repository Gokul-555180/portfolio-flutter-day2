import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/portfolio_data.dart';
import '../widgets/project_card.dart';
import '../widgets/section_title.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    // Filter projects based on query
    final String query = _searchQuery.toLowerCase().trim();
    final List<Project> filteredProjects = PortfolioData.projects.where((project) {
      if (query.isEmpty) return true;
      final matchesTitle = project.title.toLowerCase().contains(query);
      final matchesTech = project.technologies.any((tech) => tech.toLowerCase().contains(query));
      final matchesDesc = project.description.toLowerCase().contains(query);
      return matchesTitle || matchesTech || matchesDesc;
    }).toList();

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title + Search Bar row
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(text: 'Projects'),
                    _buildSearchBar(context, isDesktop),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(text: 'Projects'),
                    const SizedBox(height: 8),
                    _buildSearchBar(context, isDesktop),
                    const SizedBox(height: 32),
                  ],
                ),

          // Grid Layout
          if (filteredProjects.isEmpty)
            _buildEmptyState(context)
          else
            LayoutBuilder(
              builder: (context, constraints) {
                int columnCount;
                if (constraints.maxWidth >= 1000) {
                  columnCount = 3;
                } else if (constraints.maxWidth >= 600) {
                  columnCount = 2;
                } else {
                  columnCount = 1;
                }
                return _buildGrid(filteredProjects, columnCount);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDesktop) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: isDesktop ? 380 : double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: TextField(
            controller: _searchController,
            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 15),
            decoration: InputDecoration(
              hintText: 'Search projects or tech...',
              hintStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.4), fontSize: 14),
              prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary.withOpacity(0.8), size: 20),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () => _searchController.clear(),
                    )
                  : null,
              filled: true,
              fillColor: Colors.white.withOpacity(0.02),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(color: theme.colorScheme.primary.withOpacity(0.4), width: 1.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_outlined,
            size: 64,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No projects found matching "$_searchQuery"',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms or keywords.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<Project> projects, int columnCount) {
    List<Widget> rows = [];
    for (int i = 0; i < projects.length; i += columnCount) {
      final rowProjects = projects.sublist(
        i,
        (i + columnCount > projects.length) ? projects.length : i + columnCount,
      );

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowProjects.map((project) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: project != rowProjects.last ? 24 : 0,
                  ),
                  child: ProjectCard(
                    key: ValueKey(project.title),
                    project: project,
                  ),
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
