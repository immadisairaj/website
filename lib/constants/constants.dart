import 'package:website/classes/project_class.dart';

class AppConstants {
  /// Bio of the user
  static const String bio =
      'I am a developer who is proficient in building Mobile Applications. '
      'I love to organize things and make them look simple. '
      'I always believe that the work we do currently can/has '
      'to be continued by others later. '
      'I love Open Source. '
      'I am also a Musician, learning Tabla from age 5.';

  // Skills

  /// frameworks
  static const String frameworks = 'Flutter • '
      'Angular • '
      'React Native';

  /// tools
  static const String tools = 'Git • '
      'GitHub • '
      'VS Code • '
      'Adobe Premiere Pro';

  // projects
  static const List<Project> projects = [
    Project(
      title: 'Curious Explorer Portfolio',
      subTitle: 'September 2023',
      description: 'A portfolio website built for my brother in flutter.',
      imagePath: 'assets/projects/curious-explorer.png',
      link: 'https://sivaratnakar.com',
    ),
    Project(
      title: 'Prides',
      subTitle: 'March 2023',
      description: 'A flutter pub package that helps in creating '
          'custom Slides and Presenting them.',
      imagePath: 'assets/projects/prides.png',
      link: 'https://pub.dev/packages/prides',
    ),
    Project(
      title: 'Sai Chits',
      subTitle: 'August 2022',
      description: 'An appliation that is similar to swami chits '
          'used by students of Sri Sathya Sai Baba college which is '
          'digitalized to make it easier and accessible for all the devotees. '
          'This application supports in many different platforms '
          'thanks to Flutter',
      imagePath: 'assets/projects/sai-chits.png',
      link: 'https://saichits.immadisairaj.dev',
    ),
    Project(
      title: 'Digital LCD Number',
      subTitle: 'July 2022',
      description: 'An automatic sizer digital single-digit number with '
          'LCD style widget.',
      imagePath: 'assets/projects/digital-lcd-number.png',
      link: 'https://pub.dev/packages/digital_lcd_number',
    ),
    Project(
      title: 'Timer Game',
      subTitle: 'June 2022',
      description: 'A small game to test the reflexes of the player.',
      imagePath: 'assets/projects/timer-game.png',
      link: 'https://timergame.immadisairaj.dev',
    ),
    Project(
      title: 'Random Pick',
      subTitle: 'May 2022',
      description:
          'An application which decides/picks an item from the given pool',
      imagePath: 'assets/projects/random-pick.png',
      link: 'https://randompick.immadisairaj.dev',
    ),
    Project(
      title: 'Website',
      subTitle: 'Mar 2022',
      description: 'A flutter web application for my portfolio'
          ' which mostly includes animations',
      imagePath: 'assets/projects/website.png',
      link: 'https://immadisairaj.dev',
    ),
    Project(
      title: 'Arrow Pad',
      subTitle: 'Feb 2022',
      description: 'A flutter pub package which is a circular pad with 4 '
          'arrows which has a functionality of 4 buttons.',
      imagePath: 'assets/projects/arrow-pad.png',
      link: 'https://pub.dev/packages/arrow_pad',
    ),
    Project(
      title: 'Sai Voice',
      subTitle: 'Apr 2021',
      description: 'A radio player mobile application which streams audio from'
          ' Radio Sai Global Harmony.',
      imagePath: 'assets/projects/sai-voice.png',
      link: 'https://radiosai.immadisairaj.dev',
    ),
    Project(
      title: 'Carousel Portfolio Template',
      subTitle: 'Jun 2020',
      description: 'A web application template built using Flutter Framework.'
          ' The application allows people to have an online presence with '
          'their own personal website with which they can demonstrate their '
          'skills and projects. It can be used by anyone by just editing a '
          'single file from the project and building it.',
      imagePath: 'assets/projects/carousel-portfolio.png',
      link: 'https://v1.immadisairaj.dev',
    ),
    Project(
      title: 'Distributed Group Chat System',
      subTitle: 'Mar 2020',
      description: 'A Terminal based Distributed Group Chat System. '
          'The application is built using Java with the help of Remote Method '
          'Invocation(RMI). The application is to be run from different '
          'terminals across the same Local Area Network.',
      imagePath: 'assets/projects/distributed-group-chat.png',
      link: 'https://github.com/immadisairaj/distributedGroupChatSystem',
    ),
    Project(
      title: 'Extinction Species',
      subTitle: 'Oct 2019',
      description: 'An application which shows the list of extinct species '
          'and the reasons for their extinction. It uses ICUN API and '
          'shows the data present there. It is built using Flutter Framework.',
      imagePath: 'assets/projects/extinction-species.png',
      link: 'https://immadisairaj.dev/extinction_species',
    ),
    Project(
      title: 'Harry Potter',
      subTitle: 'Aug 2019',
      description: 'A cross-platform mobile application that can '
          'be run on both iOS and Android, built using Flutter Framework. '
          'It is built for the fans of Harry Potter to test their luck on the '
          'sorting hat and also know the different characters and different '
          'spells from Harry Potter. The data is fetched using Potter API.',
      imagePath: 'assets/projects/harry-potter.jpg',
      link: 'https://github.com/immadisairaj/harry_potter',
    ),
    Project(
      title: 'Codeforces App',
      subTitle: 'Apr 2019',
      description: 'A native Android Application built using Java. '
          'The application helps people to view details and recent '
          'problem submission of a Codeforces user.',
      imagePath: 'assets/projects/codeforces-app.jpeg',
      link: 'https://github.com/immadisairaj/CodeforcesApp',
    ),
    Project(
      title: 'Quiz',
      subTitle: 'Dec 2018',
      description: 'A native Android Application built using Java. '
          'The application can be used to test a person\'s knowledge in a '
          'particular category or overall category and learn from it.'
          ' It fetches the data from an open-source API named Open Trivia.',
      imagePath: 'assets/projects/quiz.jpg',
      link: 'https://github.com/immadisairaj/Quiz',
    ),
  ];

  // other links
  static const List<Project> otherLinks = [
    Project(
      title: 'Talks',
      description: 'I have given',
      link: 'https://talks.immadisairaj.dev',
    ),
    Project(
      title: 'Experiments',
      description: 'Something Flutter',
      link: 'https://github.com/immadisairaj/flutter-experiments',
    ),
    Project(
      title: 'Gyro Maze',
      description: 'Something with Sensors',
      link: 'https://github.com/immadisairaj/gyro_maze',
    ),
  ];
}
