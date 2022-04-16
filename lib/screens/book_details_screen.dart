import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_library/db/library_db.dart';
import 'package:univ_library/db/preferences.dart';
import 'package:univ_library/models/book.dart';
import 'package:univ_library/models/user.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool bookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        actions: [
          Consumer<Preferences>(builder: (context, value, child) {
            return IconButton(
                onPressed: () async {
                  // value.toggleBookmark(widget.book.id!);
                  setState(() {
                    bookmarked = !bookmarked;
                  });
                },
                icon: Icon(bookmarked
                    ? Icons.bookmark
                    : Icons.bookmark_add_outlined));
          })
          // IconButton(
          //     onPressed: () async {
          //       await LibraryDB.instance.delete(widget.book.id!);
          //       Navigator.of(context).pop();
          //     },
          //     icon: const Icon(Icons.delete))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              widget.book.title,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 14,
            ),
            Text('author: ${widget.book.author}'),
            const Divider(
              thickness: 1.25,
            ),
            Text('category: ${widget.book.category}'),
            const Divider(
              thickness: 1.25,
            ),
            Text('code: ${widget.book.code}')
          ],
        ),
      ),
    );
  }
}
