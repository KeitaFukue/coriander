import 'package:coriander_app/presentation/add_book/add_book_page.dart';
import 'book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<BookListModel>(
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
                    :Image.network('https://1.bp.blogspot.com/-D2I7Z7-HLGU/Xlyf7OYUi8I/AAAAAAABXq4/jZ0035aDGiE5dP3WiYhlSqhhMgGy8p7zACNcBGAsYHQ/s1600/no_image_square.jpg'),
                trailing: Wrap(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.create),
                        onPressed: ()async{
                          //本一覧ページから本編集ページに遷移
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBookPage(book: book,),//BookListModelに入っているListであるbooksの各要素がbookfullscreenDialog: true,//画面遷移のモーションが変わる
                            ),
                          );
                          model.fetchBooks();//本編集ページから本一覧ページに戻ってきた時に、firestoreの値を自動取得
                          },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: ()async{
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
                      )
                    ])
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

      create: (_) => BookListModel()..fetchBooks(),
    );
  }
}