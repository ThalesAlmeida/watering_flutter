import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:path/path.dart';
import 'package:watering_app/screens/propriety_screen.dart';
import 'package:watering_app/helpers/propriety_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione uma das opções"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Cadastrar Propriedade"),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new ProprietyPage();
                }));
              },
            ),
            RaisedButton(
              child: Text("Cadastrar Cultivo"),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new ProprietyPage();
                }));
              },
            ),
            RaisedButton(
              child: Text("Começar a irrigação"),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new ProprietyPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}

