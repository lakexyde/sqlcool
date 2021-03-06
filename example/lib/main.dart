import 'package:flutter/material.dart';
import 'pages/select_bloc.dart';
import 'pages/index.dart';
import 'pages/join_query.dart';
import 'conf.dart';

void main() {
  /// initialize the database async. We will use the [onReady]
  /// callback later to react to the initialization completed event
  initDb();
  runApp(MyApp());
}

Future<void> initDb() async {
  /// these queries will run only once, after the Sqlite file creation
  String q1 = """CREATE TABLE product (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      price REAL NOT NULL,
      category_id INTEGER NOT NULL,
      CONSTRAINT category
        FOREIGN KEY (category_id) 
        REFERENCES category(id) 
        ON DELETE CASCADE
      )""";
  String q2 = """CREATE TABLE category (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL
      )""";
  // populate the database
  String q3 = 'INSERT INTO category(name) VALUES("Category 1")';
  String q4 = 'INSERT INTO category(name) VALUES("Category 2")';
  String q5 = 'INSERT INTO category(name) VALUES("Category 3")';
  String q6 =
      'INSERT INTO product(name,price,category_id) VALUES("Product 1", 50, 1)';
  String q7 =
      'INSERT INTO product(name,price,category_id) VALUES("Product 2", 30, 1)';
  String q8 =
      'INSERT INTO product(name,price,category_id) VALUES("Product 3", 20, 2)';
  String dbpath = "items.sqlite";
  await db
      .init(
          path: dbpath,
          queries: [q1, q2, q3, q4, q5, q6, q7, q8],
          verbose: true)
      .catchError((dynamic e) {
    throw ("Error initializing the database: ${e.message}");
  });
}

final routes = {
  '/': (BuildContext context) => PageIndex(),
  '/select_bloc': (BuildContext context) => PageSelectBloc(),
  '/join': (BuildContext context) => PageJoinQuery(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqlcool example',
      routes: routes,
    );
  }
}
