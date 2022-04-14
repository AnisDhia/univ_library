import 'package:flutter/material.dart';
import 'package:univ_library/widgets/custom_drawer.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({ Key? key }) : super(key: key);

  @override
  State<BookmarksScreen> createState() => BookmarksScreenState();
}

class BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: Container(),
    );
  }
}