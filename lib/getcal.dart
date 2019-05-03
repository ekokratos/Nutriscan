import 'package:flutter/material.dart';



class DisplayPage extends StatefulWidget {
  final Information data;
  DisplayPage({Key key, @required this.data}) : super(key: key);
  @override
  _DisplayPageState createState() => new _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {

  Information data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      body:new Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Text("Calories : "+data.calo),
                Text("Fat : "+data.fat),
            ],
          ),
        ),
      )
    );
  }
}


class Information{
  String fName;
  String calo;
  String fat;
  Information(this.fName,this.calo,this.fat);
}


