import 'package:flutter/material.dart';
import 'package:univ_library/db/library_db.dart';
import 'package:univ_library/models/book.dart';
import 'package:univ_library/screens/book_details_screen.dart';
import 'package:univ_library/widgets/bookcard_widget.dart';
import 'package:univ_library/widgets/custom_drawer.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final controller = ScrollController();
  List<Book> books = [];
  bool isLoading = false, hasMore = true;

  @override
  void initState() {
    super.initState();

    fetch();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
    // refreshBooks();
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;

    final newBooks = await LibraryDB.instance.fetchBooks(15);

    // if (newBooks.isNotEmpty) {
    setState(() {
      isLoading = false;

      if (newBooks.length < 15) {
        hasMore = false;
      }
      books.addAll(newBooks);
    });
    // }
  }

  @override
  void dispose() {
    // LibraryDB.instance.close();
    controller.dispose();

    super.dispose();
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      books.clear();
    });

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    // refreshBooks();
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Browse'),
        // actions: [
        //   IconButton(onPressed: refreshBooks, icon: const Icon(Icons.refresh)),
        // ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index < books.length) {
                    return BookCard(book: books[index]);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: hasMore
                            ? const CircularProgressIndicator()
                            : const Text('No more results'),
                      ),
                    );
                  }
                }),
          )),
    );
  }
}
