import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:project_learn/gameDevelopmentsScreen.dart';
import 'package:project_learn/webDevelopmentScreen.dart';
import 'package:project_learn/appDevelopmentScreen.dart';
import 'package:project_learn/machineLearningScreen.dart';

Future<void> saveAndOpenFile(String assetPath, String fileName) async {
  try {
    // Get the directory for storing the file
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');

    // Check if the file already exists
    if (!await file.exists()) {
      // Load the file from assets
      final byteData = await rootBundle.load(assetPath);
      final buffer = byteData.buffer;

      // Write to local file
      await file.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }

    // Open the file with an external app
    OpenResult result = await OpenFile.open(file.path);

    if (result.type != ResultType.done) {
      print("Failed to open file: ${result.message}");
    }
  } catch (e) {
    print("Error copying or opening asset file: $e");
  }
}



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Developer",
          style: TextStyle(fontWeight: FontWeight.bold)),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/helper.png"),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, I am your Sarathi",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "What do you want to learn today?",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),

              /// Upskill Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.grey[1900],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upscale your Skills",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Tutorials are good, but building a project is a great way to learn.",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                          children: [
                            TextSpan(text: "Do"),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: GradientText(
                                " learning through projects",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                gradient: LinearGradient(
                                  colors: [Colors.blueAccent, Colors.purpleAccent],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                            ),
                            TextSpan(text: " and upscale your skills"),
                          ],
                        ),
                      ),
                      Lottie.asset("assets/images/laptop.json"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35),

              /// Course Cards
              const CourseCard(
                title: "Web Development",
                description: "Build web applications using HTML, CSS, JavaScript and more",
                image: "assets/images/web1.png",
                screen: WebDevelopmentScreen(),
              ),
              const CourseCard(
                title: "App Development",
                description: "Learn to build mobile apps with Java, Flutter, Dart and more",
                image: "assets/images/app.png",
                screen: AppDevelopmentScreen(), // Change to AppDevelopmentScreen when available
              ),
              const CourseCard(
                title: "Machine Learning",
                description: "Learn how machines work using Python, SciKit, Pandas and more",
                image: "assets/images/machine1.png",
                screen: Machinelearningscreen(), // Change to MLScreen when available
              ),
              const CourseCard(
                title: "Game Development",
                description: "Build games with Unity, Unreal Engine, and more",
                image: "assets/images/game1.png",
                screen: GameDevelopmentScreen(), // Change to GameDevScreen when available
              ),

              const SizedBox(height: 30),

              /// Developer Roadmap
              const Center(
                child: GradientText(
                  "Developer Roadmap",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.greenAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              const RoadmapCard(
                title: "Flutter Roadmap",
                assetPath: "assets/file/ai-engineer.pdf", // Replace with actual URL
                fileName: "flutter_roadmap.pdf",
              ),
              const RoadmapCard(
                title: "AI Engineer Roadmap",
                assetPath: "assets/file/ai-engineer.pdf", // Replace with actual URL
                fileName: "web_dev_roadmap.pdf",
              ),

            ],
          ),
        ),
      ),
    );
  }
}

/// A reusable CourseCard widget
class CourseCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Widget screen;

  const CourseCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.grey[1900],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                image,
                width: 120,
                height: 120,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A reusable RoadmapCard Widget that allows file download
class RoadmapCard extends StatelessWidget {
  final String title;
  final String assetPath;
  final String fileName;

  const RoadmapCard({
    super.key,
    required this.title,
    required this.assetPath,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        saveAndOpenFile(assetPath, fileName);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.grey[1800],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/// A reusable widget that applies a gradient to text using a [ShaderMask].
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(
      this.text, {
        super.key,
        required this.style,
        required this.gradient,
      });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
