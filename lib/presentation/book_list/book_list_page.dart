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
                leading: book.imageURL != null
                    ?Image.network(book.imageURL)
                    :Image.network('https://scontent-sjc3-1.xx.fbcdn.net/v/t1.18169-9/28783133_737177806487142_6109043676809966699_n.jpg?_nc_cat=101&ccb=1-3&_nc_sid=e3f864&_nc_ohc=MCr233pRxZcAX_-RarT&_nc_ht=scontent-sjc3-1.xx&oh=e76a9be861a4de498b99fcfda53ef135&oe=60EE2282'),
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

                onLongPress: ()async{
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('削除しますか？'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            model.deleteBook(book);
                            Navigator.of(context).pop();//Dialogを消して本追加のページに戻る
                            model.fetchBooks();
                          },
                        ),
                      ],
                    );
                  },
                  );
                },
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