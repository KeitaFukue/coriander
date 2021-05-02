import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander_app/domain/Book.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier{
  String bookTitle = ''; //　''を入れないと中身がnullになり、下記のisEmptyメソッドがNoSuchMethodエラーになる

  Future addBookToFirebase() async{
    if (bookTitle.isEmpty){
      throw('タイトルを入力してください');
    }

    final documents =  FirebaseFirestore.instance.collection('books');
    await documents.add(
      {
        'title': bookTitle,
        'createAt':Timestamp.now(),
      }
    );
  }

}