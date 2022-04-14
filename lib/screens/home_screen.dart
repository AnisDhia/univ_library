import 'package:flutter/material.dart';
import 'package:univ_library/db/library_db.dart';
import 'package:univ_library/models/book.dart';
import 'package:univ_library/widgets/bookcard_widget.dart';
import 'package:univ_library/widgets/books_list.dart';
import 'package:univ_library/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Book> books = await LibraryDB.instance.readAllBooks();
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'keyword'),
                  onChanged: (value) {
                    keyword = value;
                    setState(() {});
                  },
                ),
              ),
              FutureBuilder(
                  future: LibraryDB.instance.searchBooks(keyword),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print('error');
                    var data = snapshot.data as List<Book>;
                    return snapshot.hasData ? BooksList(books: data) : const Center(child: Text('No matches'),);
                  })
            ],
          )),
        ));
  }
}
