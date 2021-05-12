import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander_app/domain/Book.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier{
  String bookTitle = ''; //　''を入れないと中身がnullになり、下記のisEmptyメソッドがNoSuchMethodエラーになる

  Future addBookToFirebase() async{
    if (bookTitle.isEmpty){
      throw('タイトルを入力してください');
    }

    final documents =  FirebaseFirestore.instance.collection('books');//コレクションbooksを取得
    await documents.add(
      {
        'title': bookTitle,
        'createAt':Timestamp.now(),
      }
    );
  }

  Future updateBook(Book book) async{
    if (bookTitle.isEmpty){
      throw('タイトルを入力してください');
    }

    final document =  FirebaseFirestore.instance.collection('books').doc(book.docmentID);//コレクションbooksの中のドキュメントを1つ取得
    await document.update(
        {
          'title': bookTitle,
          'updateAt':Timestamp.now(),
        }
    );
  }
}