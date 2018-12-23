import 'package:flutter/material.dart';
import 'package:watering_app/helpers/propriety_helper.dart';


class ProprietyPage extends StatefulWidget {

  final Propriety propriety;

  ProprietyPage({this.propriety});


  @override
  _ProprietyPageState createState() => _ProprietyPageState();
}

class _ProprietyPageState extends State<ProprietyPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _sandController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;
  Propriety _editedPropriety;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.propriety == null) {
      _editedPropriety = Propriety();
    } else {
      _editedPropriety = Propriety.fromMap((widget.propriety.toMap()));
      _nomeController.text = _editedPropriety.name;
      _latitudeController.text = _editedPropriety.latitude;
      _sandController.text = _editedPropriety.sand;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_editedPropriety.name ?? "Nova Propriedade"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editedPropriety.name != null &&
                _editedPropriety.name.isNotEmpty && _editedPropriety.latitude.isNotEmpty && _editedPropriety.sand.isNotEmpty) {
              Navigator.pop(context, _editedPropriety);
            } else {
              _scaffoldKey.currentState..showSnackBar(
                  SnackBar(content: Text("É necessário o preenchimento de todos os campos"),
                    backgroundColor: Theme.of(context).primaryColor,
                    duration: Duration(seconds: 2),
                  )
              );
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                        labelText: "Nome da propriedade"),
                    onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedPropriety.name = text;
                      });
                    },
                  ),
                  TextField(
                    controller: _latitudeController,
                    decoration: InputDecoration(labelText: "Latitude"),
                    onChanged: (text) {
                      _userEdited = true;
                      _editedPropriety.latitude = text;
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                  TextField(
                    controller: _sandController,
                    decoration: InputDecoration(labelText: "Nível de areia"),
                    onChanged: (text) {
                      _userEdited = true;
                      _editedPropriety.sand = text;
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }


  


  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}


