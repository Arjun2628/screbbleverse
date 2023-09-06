class WordDefinition {
  final String word;
  final String phonetic;
  final List<Phonetic> phonetics;
  final String? origin; // Updated to be nullable
  final List<Meaning>? meanings;

  WordDefinition({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    this.origin, // Updated to be nullable
    required this.meanings,
  });

  factory WordDefinition.fromJson(Map<String, dynamic> json) {
    final List<dynamic> phoneticsJson = json['phonetics'];
    final List<dynamic> meaningsJson = json['meanings'];

    return WordDefinition(
      word: json['word'] as String,
      phonetic: json['phonetic'] as String,
      phonetics:
          phoneticsJson.map((phonetic) => Phonetic.fromJson(phonetic)).toList(),
      origin: json['origin'] as String?, // Updated to be nullable
      meanings:
          meaningsJson.map((meaning) => Meaning.fromJson(meaning)).toList(),
    );
  }
}

class Phonetic {
  final String text;
  final String? audio;

  Phonetic({
    required this.text,
    this.audio,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) {
    return Phonetic(
      text: json['text'] as String,
      audio: json['audio'] as String?,
    );
  }
}

class Meaning {
  final String partOfSpeech;
  final List<Definition> definitions;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    final List<dynamic> definitionsJson = json['definitions'];

    return Meaning(
      partOfSpeech: json['partOfSpeech'] as String,
      definitions: definitionsJson
          .map((definition) => Definition.fromJson(definition))
          .toList(),
    );
  }
}

class Definition {
  final String definition;
  final String? example;
  final List<String> synonyms;
  final List<String> antonyms;

  Definition({
    required this.definition,
    this.example,
    required this.synonyms,
    required this.antonyms,
  });

  factory Definition.fromJson(Map<String, dynamic> json) {
    final List<dynamic> synonymsJson = json['synonyms'];
    final List<dynamic> antonymsJson = json['antonyms'];

    return Definition(
      definition: json['definition'] as String,
      example: json['example'] as String?,
      synonyms: synonymsJson.map((synonym) => synonym as String).toList(),
      antonyms: antonymsJson.map((antonym) => antonym as String).toList(),
    );
  }
}
