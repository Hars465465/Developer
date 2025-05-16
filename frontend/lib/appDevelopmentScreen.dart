import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDevelopmentScreen extends StatefulWidget {
  const AppDevelopmentScreen({Key? key}) : super(key: key);

  @override
  State<AppDevelopmentScreen> createState() => _AppDevelopmentScreenState();
}

class _AppDevelopmentScreenState extends State<AppDevelopmentScreen> {
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
                          "App Development",
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Project ideas to take you from beginner to advanced in Android and iOS",
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
                const _SectionTitle(title: 'Description'),
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
                const _SectionTitle(title: 'Project Link'),
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
    title: 'QR Code Scanner',
    description: 'An app that scans QR codes and extracts information like URLs or contact details',
    level: 'Beginner',
    technology: 'Flutter, QR Code API',
    link: "https://www.youtube.com/watch?v=vdRCbg2FQ2M"

  ),
  Project(
    title: 'Fitness Tracker',
    description: 'Users can log workouts, track calories, and set fitness goals',
    level: 'Beginner',
      technology: 'Kotlin',
    link: 'https://www.youtube.com/watch?v=hg1_yiBvSBo'

  ),
  Project(
    title: 'Recipe Book',
    description: 'Users can browse recipes, save their favorite ones, and add their own custom recipes.',
    level: 'Beginner',
    technology: 'Flutter, Firebase',
    link: 'https://www.youtube.com/playlist?list=PLlvhNpz1tBvHndWkiaSrrdJYEVielCqRp'

  ),
  Project(
    title: ' BMI Calculator',
    description: 'A calculator that takes height and weight inputs and determines the user BMI along with health tips',
    level: 'Beginner',
    technology: 'Flutter',
    link: 'https://www.youtube.com/watch?v=OwFMEhZbe_4'

  ),
  Project(
    title: 'Weather App',
    description: 'Fetch real-time weather data based on the user’s location and display temperature, humidity, and weather conditions',
    level: 'Beginner',
    technology: 'Kotlin, OpenWeather API',
    link: 'https://www.youtube.com/playlist?list=PLam6bY5NszYPU3Bk39HuPnnVVTaLhWIL0'

  ),
  Project(
    title: 'Dictionary App',
    description: 'Users can search for word meanings, synonyms, and antonyms with pronunciation support',
    level: 'Beginner',
    technology: 'React Native, Dictionary API',
    link: 'https://www.youtube.com/playlist?list=PLmA3URVkjqnmwxdT6GtkfaGVQ4Wm8hnPo'
  ),
  Project(
    title: "Chat Messaging App",
    description: "A real-time chat app with user authentication and media sharing features",
    level: "Intermediate",
    technology: "Flutter, Firebase, WebSockets",
    link: 'https://www.youtube.com/watch?v=LyL9hmLVX14&list=PLbKub4Jss9oWpmtxAPJ_q9Y_W89D6GeYs'
  ),
  Project(
    title: "Pet Adoption App",
    description: "Connects people looking to adopt pets with shelters and pet owners",
    level: "Intermediate",
    technology: "React Native,Firebase",
    link: 'https://www.youtube.com/watch?v=c0AOwKlAz9I'
  ),
  Project(
    title: "Habit Tracker",
    description: "Users can create and track habits with reminders, streaks, and progress visualization",
    level: "Intermediate",
    technology: "Flutter, Firebase",
    link: 'https://courses.codewithandrea.com/courses/1379001/lectures/32175770'
  ),
  Project(
    title: "Expense Tracker",
    description: "Track expenses with charts and filtering options.",
    level: "Intermediate",
    technology: "Kotlin",
    link: 'https://www.youtube.com/watch?v=orJG-kWKJvQ&list=PLcAVdtHk_JSTTM2Wl1fd6eMIZOAJPYzdD'
  ),
  Project(
    title: "E-Learning App",
    description: "Allows users to watch tutorial videos, take quizzes, and track progress",
    level: "Advanced",
    technology: "React Native, Firebase",
    link: 'https://www.youtube.com/playlist?list=PLaBeGKL1tOU0FuOxkLHFy_zOlIqOWUcNc'
  ),
  Project(
      title: "E-commerce App",
      description: " A basic shopping app with product listings, cart, checkout, and payment gateway integration",
      level: "Advanced",
      technology: "Flutter, Firebase",
      link: 'https://www.youtube.com/playlist?list=PL5jb9EteFAOA3tCKoanOSEJaIDYn1Z5LC'
  ),
  Project(
    title: "Video Conferencing App",
    description: "Build a Zoom-like web app using WebRTC with screen sharing.",
    level: "Advanced",
    technology: "WebRTC, React, Node.js",
    link: 'https://www.youtube.com/watch?v=QsH8FL0952k'
  ),
];