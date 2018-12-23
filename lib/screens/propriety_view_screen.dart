import 'dart:io';

import 'package:watering_app/helpers/propriety_helper.dart';
import 'package:watering_app/screens/propriety_screen.dart';
import 'package:flutter/material.dart';

enum OrderOptions {orderaz, orderza}

class ProprietyViewPage extends StatefulWidget {
  @override
  _ProprietyViewPage createState() => _ProprietyViewPage();
}

class _ProprietyViewPage extends State<ProprietyViewPage> {
  ProprietyHelper helper = ProprietyHelper();

  List<Propriety> propriety = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getAllPropriety();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Propriedade"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordernar de A-Z"),
                value: OrderOptions.orderaz,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordernar de Z-A"),
                value: OrderOptions.orderaz,
              )
            ],
            onSelected: orderList,
          )
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showProprietyPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: propriety.length,
          itemBuilder: (context, index) {
            return _proprietyCard(context, index);
          }),
    );
  }

  Widget _proprietyCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      propriety[index].name ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      propriety[index].latitude ?? "",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      propriety[index].sand ?? "",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context){
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text("Ligar", style: TextStyle(color: Colors.red, fontSize: 20.0)
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text("Editar", style: TextStyle(color: Colors.red, fontSize: 20.0)
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _showProprietyPage(propriety: propriety[index]);
                          },
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text("Excluir", style: TextStyle(color: Colors.red, fontSize: 20.0)
                          ),
                          onPressed: () {
                            helper.deletePropriety(propriety[index].id);
                            setState(() {
                              propriety.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                        ),

                      )
                    ],

                  ),
                );
              }
          );

        });
  }

  void _showProprietyPage({Propriety propriety}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProprietyPage(
              propriety: propriety,
            )));
    if (recContact != null) {
      if (propriety != null) {
        await helper.updatePropriety(recContact);
        _getAllPropriety();
      } else {
        await helper.savePropriety(recContact);
      }

      _getAllPropriety();
    }
  }

  void _getAllPropriety() {
    helper.getAllPropriety().then((list) {
      setState(() {
        propriety = list;
      });
    });
  }

  void orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderaz:
        propriety.sort((a,b){
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        propriety.sort((a,b){
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState(() {

    });
  }

}
