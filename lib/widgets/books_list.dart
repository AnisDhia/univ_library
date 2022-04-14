import 'package:flutter/material.dart';
import 'package:univ_library/models/book.dart';
import 'package:univ_library/widgets/bookcard_widget.dart';

class BooksList extends StatelessWidget {
  BooksList({ Key? key, required this.books }) : super(key: key);

  List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: books.length,
        itemBuilder: ((context, index) {
        return BookCard(book: books[index]);
      })),
    );
  }
}