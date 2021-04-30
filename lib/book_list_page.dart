import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('本一覧'),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('books').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document['title']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}