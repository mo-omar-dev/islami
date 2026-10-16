class Zikr {
  final String category;
  final int count;
  final String description;
  final String content;

  Zikr({
    required this.category,
    required this.count,
    required this.description,
    required this.content,
  });

  static String _clean(String text) {
    return text
        .replaceAll(RegExp(r"\\n',\s*'"), '\n')
        .replaceAll(RegExp(r'\n\s*\n+'), '\n')
        .trim();
  }

  factory Zikr.fromJson(Map<String, dynamic> json) {
    return Zikr(
      category: json['category'],
      count: int.tryParse(json['count'].toString()) ?? 1,
      description: json['description'] ?? '',
      content: _clean(json['content']),
    );
  }
}
