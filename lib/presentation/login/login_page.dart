import 'package:coriander_app/presentation/book_list/book_list_page.dart';
import 'package:coriander_app/presentation/sign_up/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_model.dart';


class LogInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    final emailEditingController = TextEditingController();
//    final passEditingController = TextEditingController();

    return ChangeNotifierProvider<LogInModel>(
      create: (_) => LogInModel(),

      child: Scaffold(
        appBar: AppBar(
          title: Text('ログイン画面'),
        ),

        body: Consumer<LogInModel>(
          builder: (context, model, child) {
            return Column(
              children: [
                TextField(
//                  controller: emailEditingController,//フォームにデフォルトの値を入れるためのcontroller
                  onChanged: (text){
                    //TODO テキストフィールドの内容を
                    model.email = text;
                  },
                ),

                TextField(
//                  controller: passEditingController,//フォームにデフォルトの値を入れるためのcontroller
                  onChanged: (text){
                    //TODO テキストフィールドの内容を
                    model.pass = text;
                  },
                ),


                TextButton(
                  child: Text('ログイン'),
                  onPressed: () async{
                    try {
                      await model.logIn();
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ログインできたお！'),
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
                      Navigator.of(context).pop();
                      //TODO 本のbookListページに遷移
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookListPage()),
                      );
                    }
                    catch(e){
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

                TextButton(
                  child: Text('戻る'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}