import 'package:flutter/material.dart';
import 'package:univ_library/db/library_db.dart';
import 'package:univ_library/models/book.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({Key? key, required this.bookId}) : super(key: key);
  final int bookId;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Book book;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    refreshBook();
  }

  Future refreshBook() async {
    setState(() {
      isLoading = true;
    });

    book = await LibraryDB.instance.readBook(widget.bookId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
              onPressed: () async {
                await LibraryDB.instance.delete(book.id!);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(book.title, style: const TextStyle( fontSize: 24),),
              ],
            ),
            const SizedBox(height: 14,),
            Text('author: ${book.author}'),
            const Divider(thickness: 1.25,),
            Text('category: ${book.category}'),
            const Divider(thickness: 1.25,),
            Text('description: ${book.description}')
          ],
        ),
      ),
    );
  }
}
