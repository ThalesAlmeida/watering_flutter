import 'package:flutter/material.dart';
import 'package:watering_app/helpers/propriety_helper.dart';


class ProprietyPage extends StatefulWidget {

  final Propriety propriety;

  ProprietyPage({this.propriety});


  @override
  _ProprietyPageState createState() => _ProprietyPageState();
}

class _ProprietyPageState extends State<ProprietyPage> {

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
    if(widget.propriety == null){
      _editedPropriety = Propriety();
    }else{
      _nomeController.text = _editedPropriety.name;
      _latitudeController.text = _editedPropriety.latitude;
      _sandController.text = _editedPropriety.sand;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sua irrigação"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_editedPropriety.name != null && _editedPropriety.name.isNotEmpty){
              Navigator.pop(context, _editedPropriety);
            }else{
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
                  decoration: InputDecoration(labelText: "Nome da propriedade"),
                  onChanged: (text){
                    _userEdited = true;
                    setState(() {
                      _editedPropriety.name = text;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Latitude"),
                  onChanged: (text){
                    _userEdited = true;
                    setState(() {
                      _editedPropriety.latitude = text;
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Nível de areia"),
                  onChanged: (text){
                    _userEdited = true;
                    setState(() {
                      _editedPropriety.sand = text;
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                ),
              ],
            ),
          )
      ),
    );
  }
}
