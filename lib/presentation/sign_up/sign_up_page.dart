import 'package:coriander_app/presentation/sign_up/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    final emailEditingController = TextEditingController();
//    final passEditingController = TextEditingController();

    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),

      child: Scaffold(
        appBar: AppBar(
          title: Text('アカウント作成'),
        ),

        body: Consumer<SignUpModel>(
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
                  child: Text('アカウント作成する'),
                  onPressed: () async{
                    try {
                      await model.signUp();
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('アカウント作成が完了しました！'),
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