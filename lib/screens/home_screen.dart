import 'package:flutter/material.dart';
import 'package:univ_library/db/library_db.dart';
import 'package:univ_library/models/book.dart';
import 'package:univ_library/widgets/bookcard_widget.dart';
import 'package:univ_library/widgets/books_list.dart';
import 'package:univ_library/widgets/custom_drawer.dart';
import 'package:univ_library/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Book> books = await LibraryDB.instance.readAllBooks();
  String query = '';
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
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text('Home'),
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          // ],
        ),
        body: Column(
          children: [
            buildSearch(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: ((context, index) {
                      if (index < books.length) {
                        final book = books[index];

                        return BookCard(book: book);
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
                    })),
              ),
            ),
          ],
        ));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title, author or category Name',
        onChanged: searchBook,
      );

  void searchBook(String query) async {
    final books = await LibraryDB.instance.searchBooks(query);

    setState(() {
      this.query = query;
      this.books = books;
    });
  }
}

// SingleChildScrollView(
//           child: Center(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(), labelText: 'keyword'),
//                   onChanged: (value) {
//                     keyword = value;
//                     setState(() {});
//                   },
//                 ),
//               ),
//               FutureBuilder(
//                   future: LibraryDB.instance.searchBooks(keyword),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) print('error');
//                     var data = snapshot.data as List<Book>;
//                     return RefreshIndicator(
//                         child: ListView.builder(
//                             itemBuilder: ((context, index) {
                              
//                             })),
//                         onRefresh: refresh);
//                   })
//             ],
//           )),
//         )