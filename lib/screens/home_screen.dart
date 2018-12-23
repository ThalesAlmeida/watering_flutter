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

  ProprietyHelper helper = ProprietyHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Propriety p = Propriety();
    p.name = "daniel";
    p.latitude = "20";
    p.sand = "1.4";
    p.q0 = "15";
    p.cra = "10";
    p.cta = "45";
    p.intensidade = "12";
    p.eficiencia = "120";
    p.f = "17";
    p.z = "13";
    p.tempMinima = "002";
    p.tempMaxima = "001";
    p.kc = "46";

    helper.savePropriety(p);

    helper.getAllPropriety().then((list){
      print(list);
    });
  }

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

