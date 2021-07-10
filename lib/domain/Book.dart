import 'package:cloud_firestore/cloud_firestore.dart';

class Book{
  //コンストラクタ定義
  Book(QueryDocumentSnapshot doc){
    title = doc['title'];
    documentID = doc.id;
    imageURL = doc['imageURL'];//book_list_pageで呼び出す時に，要素(imageURL)を持っていないドキュメント(doc)を参照するとエラーになることに留意する
  }

  //プロパティ定義
  String title;
  String documentID;
  String imageURL;
}