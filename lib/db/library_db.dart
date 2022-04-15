import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:univ_library/models/book.dart';

class LibraryDB {
  static final LibraryDB instance = LibraryDB._init();

  static Database? _database;

  LibraryDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('library.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // check if the data base exists
    var exists = await databaseExists(path);

    if(!exists) {
      // Should happen only the first time app is laucnhed 
      log('creating new copy from asset');

      // Make sure the parent dir exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // copy from asset
      ByteData data = await rootBundle.load(join('assets','univ_library.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      log('Opening existing database');
    }

    return await openDatabase(path, readOnly: true);
    // return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Future _createDB(Database db, int version) async {
  //   const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  //   const textType = 'TEXT NOT NULL';
  //   const boolType = 'BOOLEAN NOT NULL';
  //   const integerType = 'INTEGER NOT NULL';

  //   await db.execute('''CREATE TABLE $tableBooks (
  //     ${BookFields.id} $idType,
  //     ${BookFields.isReserved} $boolType,
  //     ${BookFields.author} $textType,
  //     ${BookFields.title} $textType,
  //     ${BookFields.description} $textType,
  //     ${BookFields.category} $textType,
  //     ${BookFields.year} $integerType
  //   )
  //   ''');
  // }

  Future<Book> create(Book book) async {
    final db = await instance.database;

    // final json = book.toJson();
    // const columns =
    //     '${BookFields.title}, ${BookFields.author}, ${BookFields.description}, ${BookFields.isReserved}, ${BookFields.year}, ${BookFields.id}';
    // final values =
    //     '${json[BookFields.title]}, ${json[BookFields.author]}, ${json[BookFields.description]}, ${json[BookFields.isReserved]}, ${json[BookFields.year]}, ${json[BookFields.id]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableBooks, book.toJson());
    return book.copy(id: id);
  }

  Future<Book> fetchBook(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableBooks,
        columns: BookFields.values,
        where: '${BookFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Book.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Book>> fetchAllBooks() async {
    final db = await instance.database;

    const orderBy = '${BookFields.title} ASC';
    // final result = await db.rawQuery('SELECT * FROM $tableBooks ORDER BY $orderBy');

    final result = await db.query(tableBooks, orderBy: orderBy);

    return result.map((json) => Book.fromJson(json)).toList();
  }

  Future<List<Book>> searchBooks(String keyword) async {
    final db = await instance.database;

    final result = await db.query(tableBooks,
        where:
            '${BookFields.title} LIKE ? OR ${BookFields.author} LIKE ? OR ${BookFields.category} LIKE ?',
        whereArgs: ['%$keyword%', '%$keyword%', '%$keyword%']);
    return result.map((json) => Book.fromJson(json)).toList();
  }

  Future<List<Book>> fetchBooks(int number) async {
    final db = await instance.database;

    const orderBy = '${BookFields.title} ASC';

    final result = await db.query(tableBooks, limit: number, orderBy: orderBy);
    return result.map((json) => Book.fromJson(json)).toList();
  }

  Future<int> update(Book book) async {
    final db = await instance.database;

    return db.update(tableBooks, book.toJson(),
        where: '${BookFields.id} = ?', whereArgs: [book.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db
        .delete(tableBooks, where: '${BookFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
