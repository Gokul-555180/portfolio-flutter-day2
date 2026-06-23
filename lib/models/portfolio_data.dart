// models/portfolio_data.dart
//
// This file holds ALL the data shown on the portfolio website.
// Students: change the values here to personalise the portfolio —
// no need to touch the layout files at all.

// ─── Project Model ────────────────────────────────────────────────────────────
class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String imageLabel;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    required this.imageLabel,
  });
}

// ─── Experience Model ─────────────────────────────────────────────────────────
class Experience {
  final String company;
  final String position;
  final String duration;
  final String description;

  const Experience({
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
  });
}

// ─── Skill Model ──────────────────────────────────────────────────────────────
class Skill {
  final String name;
  final String category;

  const Skill({required this.name, required this.category});
}

// ─── Sample Portfolio Data ────────────────────────────────────────────────────
// Replace every value below with your own information.

class PortfolioData {
  // Personal Info
  static const String name  = 'Gokul N R';
  static const String title = 'Flutter Developer & UI Designer';
  static const String intro =
      'I build beautiful, cross-platform apps using Flutter. '
      'Passionate about clean code, great UX, and open source.';
  static const String aboutMe =
      "Hi! I'm Gokul, a software developer with 1 year of experience building "
      'mobile and web applications. I love solving real problems through elegant '
      'code and intuitive design. When I\'m not coding, you\'ll find me reading tech blogs, contributing to open source, '
      'or experimenting with new frameworks.';

  // Education
  static const String degree         = 'B.Tech. Computer Science';
  static const String university     = 'APJ Abdul Kalam Technological University';
  static const String graduationYear = '2028';

  // Contact
  static const String email    = 'dev.gokul123@gmail.com';
  static const String phone    = '+91 1234567890';
  static const String linkedin = 'linkedin.com/in/gokulnr';
  static const String github   = 'github.com/Gokul-123';

  // Skills
  static const List<Skill> skills = [
    Skill(name: 'Flutter',      category: 'Mobile'),
    Skill(name: 'Dart',         category: 'Mobile'),
    Skill(name: 'Firebase',     category: 'Backend'),
    Skill(name: 'REST APIs',    category: 'Backend'),
    Skill(name: 'React',        category: 'Web'),
    Skill(name: 'HTML & CSS',   category: 'Web'),
    Skill(name: 'Git & GitHub', category: 'Tools'),
    Skill(name: 'Figma',        category: 'Design'),
  ];

  // Projects
  static const List<Project> projects = [
    Project(
      title: 'Growth Lens',
      description: 'A smart business monitoring platform that helps users track key metrics, visualize performance trends, and gain actionable insights through an intuitive dashboard.',
      technologies: ['React', 'HTML', 'CSS'],
      imageLabel: 'Growth Lens',
    ),
    Project(
      title: 'Virtual Science Lab',
      description: 'A web-based virtual laboratory designed for students to perform science experiments digitally through interactive simulations, making practical learning accessible anytime, anywhere.',
      technologies: ['React', 'HTML', 'Simulation Engine'],
      imageLabel: 'Virtual Science Lab',
    ),
    Project(
      title: 'MindMate',
      description: 'A digital wellbeing application designed to support users with mood tracking, mindfulness activities, and productivity-focused wellness features.',
      technologies: ['Flutter', 'Figma', 'SQLite'],
      imageLabel: 'MindMate',
    ),
    Project(
      title: 'Portfolio Website',
      description: 'This very portfolio! Built with Flutter Web as a '
          'single-page application with smooth scrolling.',
      technologies: ['Flutter Web', 'Dart'],
      imageLabel: 'Portfolio',
    ),
    Project(
      title: 'BugBattle',
      description: 'A competitive programming platform where users solve coding challenges, improve problem-solving skills, and participate in leaderboard-based competitions.',
      technologies: ['Flutter', 'Firebase', 'Python'],
      imageLabel: 'BugBattle',
    ),
    Project(
      title: 'TaskNest',
      description: 'A Java Swing-based productivity application that helps users organize tasks, set priorities, and track daily progress through a simple and intuitive interface.',
      technologies: ['Java', 'Swing', 'SQLite'],
      imageLabel: 'TaskNest',
    ),
  ];

  // Experience
  static const List<Experience> experiences = [
    Experience(
      company: 'Thiranex',
      position: 'UI/UX Intern',
      duration: 'Jun 2026 – Present',
      description: 'Building and redesigning existing user interfaces to improve usability and aesthetics.',
    ),
    Experience(
      company: 'Infosys Springboard',
      position: 'AI/ML Intern',
      duration: 'Feb 2026 – Apr 2026',
      description: 'Developed an AI Based Facial Skin Analysis Tool.',
    ),
    Experience(
      company: 'MuLearn VAST',
      position: 'Execom Member',
      duration: '2025 – Present',
      description: 'Manages new members and helps them complete new tasks on different levels.',
    ),
  ];
}
