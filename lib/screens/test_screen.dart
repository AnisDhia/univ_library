import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:univ_library/db/library_db.dart';
import 'package:univ_library/models/book.dart';
import 'package:univ_library/widgets/snackbar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _descriptionController = TextEditingController();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(label: Text('Title')),
                validator: (value) {
                  return value!.isEmpty ? "Required" : null;
                },
                autovalidateMode: AutovalidateMode.always,
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  label: Text('Author'),
                ),
                validator: (value) {
                  return value!.isEmpty ? "Required" : null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(label: Text('Category')),
              ),
              TextFormField(
                maxLines: 3,
                controller: _descriptionController,
                decoration: const InputDecoration(label: Text('Description')),
              ),
              const SizedBox(
                height: 14,
              ),
              ElevatedButton(
                  onPressed: () {
                    _addBook(context);
                  },
                  child: const Text('Add book'))
            ],
          ),
        ),
      ),
    );
  }

  Future _addBook(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Book book = Book(
          isReserved: false,
          title: _titleController.text,
          author: _authorController.text,
          description: _descriptionController.text,
          category: _categoryController.text,
          year: 0);
      await LibraryDB.instance.create(book);
      Navigator.pop(context);
    }
  }
}
