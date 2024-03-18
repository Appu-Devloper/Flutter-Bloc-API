
class BhagavadGitaChapter {
  int chapterNumber;
  int versesCount;
  String name;
  String translation;
  String transliteration;
  Map<String, String> meaning;
  Map<String, String> summary;

  BhagavadGitaChapter({
    required this.chapterNumber,
    required this.versesCount,
    required this.name,
    required this.translation,
    required this.transliteration,
    required this.meaning,
    required this.summary,
  });

  factory BhagavadGitaChapter.fromJson(Map<String, dynamic> json) {
    return BhagavadGitaChapter(
      chapterNumber: json['chapter_number'],
      versesCount: json['verses_count'],
      name: json['name'],
      translation: json['translation'],
      transliteration: json['transliteration'],
      meaning: Map<String, String>.from(json['meaning']),
      summary: Map<String, String>.from(json['summary']),
    );
  } 
}
