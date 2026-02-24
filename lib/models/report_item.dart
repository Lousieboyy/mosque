class ReportItem {
  ReportItem({
    required this.title,
    required this.description,
    required this.createdAt,
    this.voiceSource = false,
  });

  final String title;
  final String description;
  final DateTime createdAt;
  final bool voiceSource;
}
