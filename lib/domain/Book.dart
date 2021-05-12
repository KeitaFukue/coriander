import 'package:cloud_firestore/cloud_firestore.dart';

class Book{
  //コンストラクタ定義
  Book(QueryDocumentSnapshot doc){
    title = doc['title'];
    docmentID = doc.id;
  }

  //プロパティ定義
  String title;
  String docmentID;
}