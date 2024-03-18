class Posts {
  int postno;
  String slug;
  String text;
  List<Translations> translations;
  String transliteration;
  String wordsmeaning;

  Posts({
    required this.postno,
    required this.translations,
    required this.slug,
    required this.transliteration,
    required this.text,
    required this.wordsmeaning,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    // Parse translations
    List<dynamic> translationsJson = json['translations'];
    List<Translations> translationsList = translationsJson.map((transJson) => Translations.fromJson(transJson)).toList();

    return Posts(
      postno: json['verse_number'],
      slug: json['slug'],
      text: json['text'],
      transliteration: json['transliteration'],
      translations: translationsList,
      wordsmeaning: json['word_meanings'],
    );
  }
}

class Translations {
  int id;
  String description;
  String language;
  String author;

  Translations({
    required this.id,
    required this.description,
    required this.language,
    required this.author,
  });

  factory Translations.fromJson(Map<String, dynamic> json) {
    return Translations(
      id: json['id'],
      description: json['description'],
      author: json['author_name'],
      language: json['language'],
    );
  }
}
