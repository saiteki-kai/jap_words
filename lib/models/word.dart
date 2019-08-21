class WordItem {
  String id;
  Word word;
  List<Sentence> sentences;

  WordItem({
    this.id,
    this.word,
    this.sentences,
  });

  factory WordItem.fromMap(Map<String, dynamic> json) => WordItem(
        id: json["_id"],
        word: Word.fromMap(json["word"]),
        sentences: new List<Sentence>.from(
          json["sentences"].map((x) => Sentence.fromMap(x)),
        ),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "word": word.toMap(),
        "sentences": List<dynamic>.from(sentences.map((x) => x.toMap())),
      };
}

class Sentence {
  String kanji;
  String traduction;
  String kana;
  String romaji;
  String image;
  String audio;

  Sentence({
    this.kanji,
    this.traduction,
    this.kana,
    this.romaji,
    this.image,
    this.audio,
  });

  factory Sentence.fromMap(Map<String, dynamic> json) => Sentence(
        kanji: json["kanji"],
        traduction: json["traduction"],
        kana: json["kana"],
        romaji: json["romaji"],
        image: json["image"],
        audio: json["audio"],
      );

  Map<String, dynamic> toMap() => {
        "kanji": kanji,
        "traduction": traduction,
        "kana": kana,
        "romaji": romaji,
        "image": image,
        "audio": audio,
      };
}

class Word {
  String kanji;
  String partOfSpeech;
  String category;
  String traduction;
  String kana;
  String romaji;
  String audio;

  Word({
    this.kanji,
    this.partOfSpeech,
    this.category,
    this.traduction,
    this.kana,
    this.romaji,
    this.audio,
  });

  factory Word.fromMap(Map<String, dynamic> json) => Word(
        kanji: json["kanji"],
        partOfSpeech: json["partOfSpeech"],
        traduction: json["traduction"],
        category: json["category"],
        kana: json["kana"],
        romaji: json["romaji"],
        audio: json["audio"],
      );

  Map<String, dynamic> toMap() => {
        "kanji": kanji,
        "partOfSpeech": partOfSpeech,
        "traduction": traduction,
        "category": category,
        "kana": kana,
        "romaji": romaji,
        "audio": audio,
      };
}
