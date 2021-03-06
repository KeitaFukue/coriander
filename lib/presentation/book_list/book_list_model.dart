import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/Book.dart';

class BookListModel extends ChangeNotifier{
  List<Book> books = [];

  Future fetchBooks() async{
    final documents =
          await FirebaseFirestore.instance.collection('books').get();
    print(documents);
    final bookss = documents.docs.map((doc) => Book(doc)).toList();//リストの中身をほげほげ型からBook型にしてる
    this.books = bookss;
    notifyListeners();
  }

  Future deleteBook(Book book)async{
    final document = FirebaseFirestore.instance.collection('books').doc(book.documentID);
    document.delete();
  }
}