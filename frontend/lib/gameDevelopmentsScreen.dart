import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDevelopmentScreen extends StatefulWidget {
  const GameDevelopmentScreen({Key? key}) : super(key: key);

  @override
  State<GameDevelopmentScreen> createState() => _GameDevelopmentScreenState();
}

class _GameDevelopmentScreenState extends State<GameDevelopmentScreen> {
  String selectedLevel = 'Beginner'; // Default selection
  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  Widget build(BuildContext context) {
    // Filter projects based on selected level
    final filteredProjects = projectsData
        .where((project) => project.level == selectedLevel)
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Web Development Title Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.grey[1900], // Darker background
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Game Development",
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Project ideas to take you from beginner to advanced in unity and more",
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Category Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: levels.map((level) {
                    bool isSelected = selectedLevel == level;
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedLevel = level;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected ? Colors.black : Colors.grey[300],
                        foregroundColor: isSelected ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      ),
                      child: Text(level),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 15),

                // Projects List
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: filteredProjects.map((project) =>
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProjectDetailScreen(project: project),
                                ),
                              );
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
      ),
    );
  }
}

// Modal Bottom Sheet for Project Details
class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // Project Title with animation
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * -20),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    project.title,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Animated Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technology.split(', ').map((tech) => _buildTag(tech)).toList(),
                ),
                const SizedBox(height: 32),

                // Description Section
                _SectionTitle(title: 'Description'),
                const SizedBox(height: 16),
                Text(
                  project.description,
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Project Link Section
                _SectionTitle(title: 'Project Link'),
                const SizedBox(height: 16),
                _buildExternalLinkButton(context),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Chip(
      backgroundColor: Colors.indigo.shade400,
      label: Text(
        text,
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildExternalLinkButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final String urlString = project.link;
        final Uri url = Uri.parse(urlString);

        debugPrint("Attempting to open: $urlString");

        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          debugPrint("Could not launch: $urlString");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open the link: $urlString'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          debugPrint("Successfully launched: $urlString");
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.indigo.shade400,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.shade800.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.open_in_new, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              'Visit Project',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 2,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.indigo.shade400,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    // Define transformation matrix
    Matrix4 transformMatrix = Matrix4.identity();
    if (_isTapped) {
      transformMatrix = Matrix4.identity()..scale(0.96)..translate(0.0, 3.0);
    }

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });

        // Navigate to the project details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailScreen(project: widget.project),
          ),
        );
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        transform: transformMatrix,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // Keep smooth rounded corners
          color: Colors.grey[900], // Dark theme background
          boxShadow: _isTapped
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(2, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildBadge(widget.project.level, const Color(0xFFFFC107), Colors.black),
                const SizedBox(width: 8),
                _buildBadge(widget.project.technology, Colors.blueGrey[700]!, Colors.white),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.project.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text for contrast
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.project.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400], // Slightly lighter text for readability
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
class Project {
  final String title;
  final String description;
  final String level;
  final String technology;
  final String link;


  Project({
    required this.title,
    required this.description,
    required this.level,
    required this.technology,
    required this.link,

  });
}

// Sample project data
List<Project> projectsData = [
  Project(
      title: 'Tic-Tac-Toe',
      description: 'A simple two-player Tic-Tac-Toe game with basic for multi-player mode.',
      level: 'Beginner',
      technology: 'JavaScript (HTML5 Canvas)',
      link: 'https://www.youtube.com/watch?v=SqrppLEljkY'

  ),
  Project(
      title: 'Simple 2D Platformer',
      description: 'A basic platformer where the player jumps between platforms and avoids obstacles',
      level: 'Beginner',
      technology: 'Unity, Godot(GDScript), Pygame',
      link: 'https://www.youtube.com/playlist?list=PLgOEwFbvGm5o8hayFB6skAfa8Z-mw4dPV'

  ),
  Project(
      title: 'Space Shooter',
      description: 'A classic arcade-style space shooter where the player shoots enemies and avoids obstacles',
      level: 'Beginner',
      technology: 'JavaScript (Phaser.js)',
      link: 'https://www.youtube.com/watch?v=mwl95yvl-n0'

  ),
  Project(
      title: 'Ping Pong Game',
      description: 'A simple table tennis game where two players (or one vs AI) hit a ball back and forth',
      level: 'Beginner',
      technology: 'Unity',
      link: 'https://www.youtube.com/watch?v=YHSanceczXY'

  ),
  Project(
      title: 'Catch the Falling Object',
      description: ' A game where the player controls a basket and catches falling objects while avoiding bad ones',
      level: 'Beginner',
      technology: 'Unity, Pygame',
      link: 'https://www.youtube.com/watch?v=HSE8I2b7Lsg'

  ),
  Project(
      title: "Multiplayer Chess Game",
      description: "A chess game with online multiplayer functionality using a server",
      level: "Intermediate",
      technology: "PUnity, Firebase",
      link: 'https://www.youtube.com/playlist?list=PLmcbjnHce7SeAUFouc3X9zqXxiPbCz8Zp'
  ),
  Project(
      title: "Tower Defense Game",
      description: "A strategic tower defense game where players place towers to stop enemy waves",
      level: "Intermediate",
      technology: "Unity, Godot (GDScript)",
      link: 'https://www.youtube.com/playlist?list=PLfX6C2dxVyLz_w9AWxvkRKc2zUvBl0GIl'
  ),
  Project(
      title: "First-Person Shooter (FPS) Prototype",
      description: "A simple FPS game with basic shooting mechanics and enemy AI",
      level: "Intermediate",
      technology: "Unity, Unreal Engine",
      link: 'https://www.youtube.com/watch?v=rJqP5EesxLk&list=PLGUw8UNswJEOv8c5ZcoHarbON6mIEUFBC'
  ),
  Project(
      title: " Battle Royale Game",
      description: "A multiplayer battle royale game where players compete to be the last one standing",
      level: "Advanced",
      technology: "Unity, Unreal Engine, Photon",
      link: 'https://www.youtube.com/playlist?list=PLDSN4X0GGaNJuuSFS5EH9rEmiC_ZC5Utc'
  ),

];