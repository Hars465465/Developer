import 'package:flutter/material.dart';
import 'package:project_learn/sample.dart';


class sample extends StatefulWidget {
  const sample({Key? key}) : super(key: key);

  @override
  State<sample> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<sample> {
  String? selectedLevel;
  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  Widget build(BuildContext context) {
    // Filter projects based on selected level
    final filteredProjects = selectedLevel != null
        ? projectsData.where((project) => project.level == selectedLevel)
        .toList()
        : projectsData;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Frontend Projects',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Project ideas to take you from beginner to advanced in Frontend',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Tabs
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      _buildTabWithBadge('Projects', true, () {}),
                      const Spacer(),
                      ///_buildSuggestButton(),
                    ],
                  ),
                ),
              ),



              // Project cards
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: filteredProjects.map((project) =>
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            // Show project details dialog
                            _showProjectDetails(context, project);
                          },
                          child: ProjectCard(project: project),
                        ),
                      )
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProjectDetails(BuildContext context, Project project) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) =>
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildBadge(project.level, const Color(0xFFFFF8C5),
                        const Color(0xFF806A00)),
                    const SizedBox(width: 8),
                    _buildBadge(project.technology, const Color(0xFFF5F5F5),
                        Colors.grey),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  project.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Here you would navigate to the project details page
                      // or start the project
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Start Project',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildBadge(String text, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildTabWithBadge(String title, bool isActive, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: isActive
            ? const Border(
          bottom: BorderSide(color: Colors.black, width: 2),
        )
            : null,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8C5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'new',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF806A00),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Project {
  final String id;
  final String title;
  final String description;
  final String level;
  final String technology;
  final int started;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.technology,
    required this.started,
  });
}

// Sample project data
List<Project> projectsData = [
  Project(
    id: '1',
    title: 'Single-Page CV',
    description: 'Create a single-page HTML CV to showcase your career history',
    level: 'Beginner',
    technology: 'HTML',
    started: 9755,
  ),
  Project(
    id: '2',
    title: 'Basic HTML Website',
    description: 'Create simple HTML only website with multiple pages.',
    level: 'Beginner',
    technology: 'HTML',
    started: 4245,
  ),
  Project(
    id: '3',
    title: 'Personal Portfolio',
    description: 'Convert the previous simple HTML website into a personal portfolio.',
    level: 'Beginner',
    technology: 'CSS',
    started: 1639,
  ),
  Project(
    id: '4',
    title: 'Changelog Component',
    description: 'Create a changelog component for a website using HTML and CSS.',
    level: 'Beginner',
    technology: 'CSS',
    started: 1200,
  ),
  Project(
    id: '5',
    title: 'Testimonial Cards',
    description: 'Create testimonial cards for a website using HTML and CSS.',
    level: 'Beginner',
    technology: 'CSS',
    started: 980,
  ),
  Project(
    id: '6',
    title: 'Datepicker UI',
    description: 'Create a simple datepicker UI using HTML and CSS.',
    level: 'Beginner',
    technology: 'CSS',
    started: 850,
  ),
];

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header with badges
          Row(
            children: [
              _buildBadge(
                project.level,
                const Color(0xFFFFF8C5),
                const Color(0xFF806A00),
              ),
              const SizedBox(width: 8),
              _buildBadge(
                project.technology,
                const Color(0xFFF5F5F5),
                Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            project.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            project.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          // Footer
          Text(
            '${project.started} Started',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }
}