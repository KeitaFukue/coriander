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
            final listTiles = books.map(//リストであるbooksの中身をBook型からListTile型に変更
              (book) => ListTile(//BookListModelに入っているListであるbooksの各要素がbook
                title: Text(book.title),
                trailing: IconButton(
                  icon: Icon(Icons.create),
                  onPressed: ()async{//本一覧ページから本編集ページに遷移
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddBookPage(book: book,),//BookListModelに入っているListであるbooksの各要素がbook
                        fullscreenDialog: true,//画面遷移のモーションが変わる
                      ),
                    );
                    model.fetchBooks();//本編集ページから本一覧ページに戻ってきた時に、firestoreの値を自動取得
                  },
                ),
              ),
            ).toList();

            return ListView(
            children: listTiles,
        );
          },
        ),
        floatingActionButton: Consumer<BookListModel>(
            builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async {//本一覧ページから本追加ページに遷移
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBookPage(),
                    fullscreenDialog: true,//画面遷移のモーションが変わる
                  ),
                );
                model.fetchBooks();//本追加ページから本一覧ページに戻ってきた時に、firestoreの値を自動取得
              },
              child: const Icon(Icons.add),
            );
            }
        ),
      ),
    );
  }
}