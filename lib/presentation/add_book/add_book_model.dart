import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander_app/domain/Book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddBookModel extends ChangeNotifier{
  String bookTitle = ''; //　''を入れないと中身がnullになり、下記のisEmptyメソッドがNoSuchMethodエラーになる
  File imageFile;

  Future showImagePicker() async{
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    print(imageFile);
    notifyListeners();
  }

  Future addBookToFirebase() async{
    if (bookTitle.isEmpty){
      throw('タイトルを入力してください');
    }
    //storageにアップロードし，アップロードした画像のURLを取得
    final imageURL = await _uploadImage();

    //コレクションbooksを取得
    final documents =  FirebaseFirestore.instance.collection('books');
    await documents.add(//コレクションbooksに新しいドキュメントを追加
      {
        'title': bookTitle,
        'imageURL': imageURL,
        'createAt': Timestamp.now(),
      }
    );
  }

  Future updateBook(Book book) async{
    if (bookTitle.isEmpty){
      throw('タイトルを入力してください');
    }
    //storageにアップロードし，アップロードした画像の画像URLを取得
    final imageURL = await _uploadImage();

    //コレクションbooksの中のドキュメントを1つ取得
    final document =  FirebaseFirestore.instance.collection('books').doc(book.documentID);
    await document.update(//ドキュメントを編集
        {
          'title': bookTitle,
          'imageURL': imageURL,
          'updateAt': Timestamp.now(),
        }
    );
  }

  Future<String> _uploadImage()async{
    File downloadFile;

    //firebase storageへのアップロード
    await firebase_storage.FirebaseStorage.instance
        .ref('books/${bookTitle}')//storageの参照先を取得．(無ければ自動的にフォルダやファイル生成してくれる)
        .putFile(imageFile);//取得した参照先にファイル(パス)にアップロードする

    //firebase storageへのアップロードした画像のURLをダウンロード
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('books/${bookTitle}')
        .getDownloadURL();

    return downloadURL;
  }
}