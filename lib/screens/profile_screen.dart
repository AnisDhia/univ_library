import 'package:flutter/material.dart';
import 'package:univ_library/widgets/custom_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => BookmarksScreenState();
}

class BookmarksScreenState extends State<ProfileScreen> {
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