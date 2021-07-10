import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander_app/domain/Book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier{
  String bookTitle = ''; //　''を入れないと中身がnullになり、下記のisEmptyメソッドがNoSuchMethodエラーになる
  File imageFile;

  Future showImagePicker() async{
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

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

    final document =  FirebaseFirestore.instance.collection('books').doc(book.documentID);//コレクションbooksの中のドキュメントを1つ取得
    await document.update(
        {
          'title': bookTitle,
          'updateAt':Timestamp.now(),
        }
    );
  }
}