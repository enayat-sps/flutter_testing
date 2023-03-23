import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key, required this.books}) : super(key: key);
  final List<String> books;
  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    assert(widget.books.isNotEmpty);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: widget.books.length,
        itemBuilder: (context, index) {
          return buildListItems(widget.books, index);
        },
      ),
    );
  }
}

Widget? buildListItems(List<String> books, int index) {
  return SizedBox(
    height: 55,
    width: 200,
    child: Card(
      color: Colors.amberAccent,
      elevation: 7,
      child: Text(
        books[index],
      ),
    ),
  );
}
