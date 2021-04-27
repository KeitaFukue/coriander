import 'package:coriander_app/main_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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