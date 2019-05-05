import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pedometer/flutter_pedometer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DetailScreen.dart';
import 'mainPage.dart';

class PedoMeter extends StatefulWidget {
  @override
  _PedoMeterState createState() => _PedoMeterState();
}

class _PedoMeterState extends State<PedoMeter> {
  StreamSubscription<int> _subscription;
  FlutterPedometer pedometer;
  int scount = 0;
  int calCount = 0;
  int i = 0;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    pedometer = new FlutterPedometer();
    _subscription = pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int stepCountValue) async {
    setState(() {
      scount = (stepCountValue - stepCountValue) + i;
      i++;
      if (scount % 20 == 0 && scount != 0) {
        calCount += 1;
      }
    });
  }

  void _onDone() {
    // Do something when done collecting
  }

  void _onError(error) {
    // Handle the error
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 250,
            ),
            Text(
              scount.toString(),
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
            Text(
              "steps",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 100),
            Text(
              calCount.toString(),
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
            Text(
              "Calories Burnt",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('details').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                final record = Record.fromSnapshot(snapshot.data.documents[0]);
                return Container(
                  margin: EdgeInsets.fromLTRB(120.0, 80.0, 120.0, 80.0),
                  child: RaisedButton(
                    color: Colors.orangeAccent,
                    child: new Text(
                      "Submit",
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot freshSnap =
                            await transaction.get(record.reference);
                        await transaction.update((freshSnap.reference), {
                          'currentCalories':
                              freshSnap['currentCalories'] - calCount,
                        });
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        )));
  }
}
