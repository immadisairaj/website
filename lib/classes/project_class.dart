class Project {
  final String title;
  final String subTitle;
  final String description;
  final String imagePath;
  final String link;

  const Project({
    required this.title,
    this.subTitle = '',
    required this.description,
    required this.imagePath,
    this.link = '',
  });
}
