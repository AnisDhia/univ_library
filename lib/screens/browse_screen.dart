import 'package:flutter/material.dart';
import 'package:univ_library/db/library_db.dart';
import 'package:univ_library/models/book.dart';
import 'package:univ_library/screens/book_details_screen.dart';
import 'package:univ_library/widgets/custom_drawer.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  late List<Book> books;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    refreshBooks();
  }

  // @override
  // void dispose() {
  //   LibraryDB.instance.close();

  //   super.dispose();
  // }

  Future refreshBooks() async {
    setState(() {
      isLoading = true;
    });

    books = await LibraryDB.instance.readAllBooks();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // refreshBooks();
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Browse'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(books[index].title),
                      subtitle: Text('by ${books[index].author}'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailsScreen(bookId: books[index].id!),
                            ));
                      },
                    );
                  })),
    );
  }
}
