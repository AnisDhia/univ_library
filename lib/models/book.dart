final String tableBooks = 'books';

class BookFields {
  static final List<String> values = [
    id,
    author,
    title,
    year,
    description,
    category,
    isReserved,
  ];

  static const String id = '_id';
  static const String isReserved = 'isReserved';
  static const String title = 'title';
  static const String author = 'author';
  static const String description = 'description';
  static const String category = 'category';
  static const String year = 'year';
}

class Book {
  final int? id;
  final bool isReserved;
  final String title;
  final String author;
  final String description;
  final String category;
  final int year;

  const Book({
    required this.id,
    required this.isReserved,
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    required this.year,
  });

  static Book fromJson(Map<String, Object?> json) => Book(
    id: json[BookFields.id] as int?,
    isReserved: json[BookFields.isReserved] == 1,
    author: json[BookFields.author] as String,
    title: json[BookFields.title] as String,
    description: json[BookFields.description] as String,
    category: json[BookFields.category] as String,
    year: json[BookFields.year] as int,
    );

  Map<String, Object?> toJson() => {
        BookFields.id: id,
        BookFields.isReserved: isReserved ? 1 : 0,
        BookFields.title: title,
        BookFields.author: author,
        BookFields.description: description,
        BookFields.category: category,
        BookFields.year: year
      };

  Book copy(
          {int? id,
          bool? isReserved,
          String? title,
          String? author,
          String? description,
          String? category,
          int? year}) =>
      Book(
          id: id ?? this.id,
          isReserved: isReserved ?? this.isReserved,
          title: title ?? this.title,
          author: author ?? this.author,
          description: description ?? this.description,
          category: category ?? this.category,
          year: year ?? this.year);
}
