import 'package:flutter/material.dart';
import 'package:univ_library/models/book.dart';

class BookCard extends StatefulWidget {
  const BookCard({Key? key, required this.book}) : super(key: key);
  final Book book;
  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.book.title),
      subtitle: Text(widget.book.author),
    );
  }
}
