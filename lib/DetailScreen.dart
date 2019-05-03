import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class DetailScreen extends StatelessWidget {
  final UserDetails detailsUser;


  DetailScreen({Key key, @required this.detailsUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Google Sign In Details'),
          automaticallyImplyLeading: false,
        ),
        body: new Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection(detailsUser.uid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                final record = Record.fromSnapshot(snapshot.data.documents[0]);
                return Text(record.weight.toString());
              },
            ))
    );
  }
}

class Record {
  final int weight;
  final int height;
  final int maxCal;
  final int curCal;


  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['weight'] != null),
        assert(map['height'] != null),
        assert(map['caloriesAllowed'] != null),
        assert(map['currentCalories'] != null),
        weight = map['weight'],
        height = map['height'],
        maxCal = map['caloriesAllowed'],
        curCal = map['currentCalories'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}



