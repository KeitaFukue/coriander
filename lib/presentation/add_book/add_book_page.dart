import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander_app/domain/Book.dart';
import 'package:coriander_app/presentation/add_book/add_book_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddBookPage extends StatelessWidget {
  AddBookPage({this.book});//コンストラクタ定義、引数を{}で囲むと、引数があってもなくてもいい

  final Book book; //プロパティ定義

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = (book != null);//bookの、中身がない時true、中身がない時false
    final textEditingController = TextEditingController();

    if(isUpdate) {
      textEditingController.text = book.title;
    }

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),

      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? '本を編集' : '本追加'),
        ),

        body: Consumer<AddBookModel>(
          builder: (context, model, child) {
            return Column(
              children: [
                SizedBox(
                  height: 130,
                  width: 160,
                  child: InkWell(
                    onTap: ()async{
                      //TODO カメラロールを開く
                      await model.showImagePicker();
                    },
                    child:((){ //即時関数
                      if(model.imageFile != null){
                        return Image.file(model.imageFile);
                      }else if(isUpdate){
                        if(book.imageURL != null) {
                          return Image.network(book.imageURL);
                        }else{
                          return Container(
                            margin: EdgeInsets.only(top: 30),
                            color: Colors.grey,
                          );
                        }
                      }else {
                        return Container(
                          margin: EdgeInsets.only(top: 30),
                          color: Colors.grey,
                        );
                      }
                    })(),
            ),
            ),
                TextField(
                  controller: textEditingController,//フォームにデフォルトの値を入れるためのcontroller
                  onChanged: (text){
                    //TODO テキストフィールドの内容をmodelのプロパティに
                    model.bookTitle = text;
                    },
                ),
                TextButton(
                  child: Text(isUpdate ? '更新する' :'本を追加'),
                  onPressed: () async{
                    try{
                      if(isUpdate){
                        await model.updateBook(book);
                      }else{
                        //TODO modelのメソッドを起動して、firestoreにデータ追加
                        await model.addBookToFirebase();
                      }
                      //TODO firestoreにデータ追加したことを、dialogで知らせる
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(isUpdate ? '本を更新しました！' :'本を追加しました！'),
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
                ),
              ],
            );
          }
          ),
      ),
    );
  }
}