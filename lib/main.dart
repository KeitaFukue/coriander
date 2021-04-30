import 'package:coriander_app/main_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_list_page.dart';

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