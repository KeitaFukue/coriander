import 'package:cloud_firestore/cloud_firestore.dart';

class Book{
  //コンストラクタ定義
  Book(QueryDocumentSnapshot doc){
    title = doc['title'];
    documentID = doc.id;
//    ImageURL = doc['ImageURL'];
  }

  //プロパティ定義
  String title;
  String documentID;
  String ImageURL;
}