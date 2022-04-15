import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_library/db/library_db.dart';
import 'package:univ_library/models/book.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  // late Book book;
  // bool isLoading = false;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   refreshBook();
  // }

  // Future refreshBook() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   book = await LibraryDB.instance.fetchBook(widget.bookId);

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        actions: [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.bookmark_add_outlined))
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
