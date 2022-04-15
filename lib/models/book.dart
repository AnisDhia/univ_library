const String tableBooks = 'notices';

class BookFields {
  static final List<String> values = [
    id,
    author,
    title,
    year,
    code,
    category,
    isReserved,
  ];

  static const String id = 'notice_id';
  static const String isReserved = 'statut';
  static const String title = 'tit1';
  static const String author = 'tit4';
  static const String code = 'code';
  static const String category = 'tit2';
  static const String year = 'year';
}

class Book {
  final int? id;
  final bool isReserved;
  final String title;
  final String author;
  final String code;
  final String category;
  final String year;

  const Book({
    this.id,
    required this.isReserved,
    required this.title,
    required this.author,
    required this.code,
    required this.category,
    required this.year,
  });

  static Book fromJson(Map<String, Object?> json) => Book(
    id: json[BookFields.id] as int?,
    isReserved: int.parse(json[BookFields.isReserved].toString()) > 0,
    author: json[BookFields.author] as String,
    title: json[BookFields.title] as String,
    code: json[BookFields.code] as String,
    category: json[BookFields.category] as String,
    year: json[BookFields.year] as String,
    );

  Map<String, Object?> toJson() => {
        BookFields.id: id,
        BookFields.isReserved: isReserved ? 1 : 0,
        BookFields.title: title,
        BookFields.author: author,
        BookFields.code: code,
        BookFields.category: category,
        BookFields.year: year
      };

  Book copy(
          {int? id,
          bool? isReserved,
          String? title,
          String? author,
          String? code,
          String? category,
          String? year}) =>
      Book(
          id: id ?? this.id,
          isReserved: isReserved ?? this.isReserved,
          title: title ?? this.title,
          author: author ?? this.author,
          code: code ?? this.code,
          category: category ?? this.category,
          year: year ?? this.year);
}
