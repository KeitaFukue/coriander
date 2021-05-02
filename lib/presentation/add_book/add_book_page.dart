import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander_app/presentation/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),

      child: Scaffold(
        appBar: AppBar(
          title: Text('本追加'),
        ),

        body: Consumer<AddBookModel>(
          builder: (context, model, child) {
            return Column(
              children: [
                TextField(
                  onChanged: (text){
                    //TODO テキストフィールドの内容をmodelのプロパティに
                    model.bookTitle = text;
                  },
                ),
                TextButton(
                    onPressed: () async{
                      try{
                        //TODO modelのメソッドを起動して、firestoreにデータ追加
                        await model.addBookToFirebase();

                        //TODO firestoreにデータ追加したことを、dialogで知らせる
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('本を追加しました！'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();//Dialogを消して本追加のページに戻る
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        Navigator.of(context).pop();//本一覧のページに戻る
                      }catch(e){
                        //TODO 例外処理を伝える
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(e.toString()),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }

                      },
                    child: Text('本を追加')),
              ],
            );
          },
        ),
      ),
    );
  }
}