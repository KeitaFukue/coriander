import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander_app/presentation/add_book/add_book_page.dart';
import 'book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),

      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),

        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books.map(//リストであるbooksの中身をほげほげ型からListTile型に変更
              (book) => ListTile(
                title: Text(book.title),
              ),
            ).toList();

            return ListView(
            children: listTiles,
        );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                fullscreenDialog: true,//画面遷移のモーションが変わる
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}