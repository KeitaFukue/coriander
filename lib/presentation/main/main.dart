import 'package:coriander_app/presentation/book_list/book_list_page.dart';
import 'package:coriander_app/presentation/login/login_page.dart';
import 'package:coriander_app/presentation/sign_up/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_model.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("${snapshot.error}");
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Main();
        }
        return Container();
      },
    );
  }
}

class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: ChangeNotifierProvider(
        create: (_) => MainModel(),

        child: Scaffold(
          appBar: AppBar(
            title: Text('コリアンダー'),
          ),

          body: Consumer<MainModel>(
            builder: (context, model, child) {
              return Center(
                child:Column(
                  children: [
                    Text(
                      model.tempText,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                ),
                    TextButton(
                      child:Text('ボタン'),
                      onPressed: (){
                        model.changeTempText();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookListPage()),
                        );
                      },
                    ),

                    TextButton(
                      child:Text('アカウント作成'),
                      onPressed: (){
                        model.changeTempText();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                    ),

                    TextButton(
                      child:Text('ログイン'),
                      onPressed: (){
                        model.changeTempText();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LogInPage()),
                        );
                      },
                    ),
                  ],
                )
              );
            }
          ),
        ),
      )
    );
  }
}