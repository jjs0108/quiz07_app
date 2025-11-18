import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late String currentDateTime;
  DateTime? chosenDateTime;
  late bool _isRunning;
  late Color color;

  @override
  void initState() {
    super.initState();
    currentDateTime = "";
    _isRunning = true;
    color = Colors.white;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isRunning) {
        timer.cancel();
      }
      addItem();
    });
  }

  addItem() {
    DateTime now = DateTime.now();
    currentDateTime =
        ("${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${_weekdayToString(now.weekday)} ${now.hour.toString().padLeft(2, "0")}:${now.minute.toString().padLeft(2, "0")}:${now.second.toString().padLeft(2, "0")}");
    if (chosenDateTime != null &&
        _chosenItem(now) == _chosenItem(chosenDateTime!)) {
      color = color == Colors.amber ? Colors.pinkAccent : Colors.amber;
    } else {
      color = Colors.white;
    }
    setState(() {});
  }

  String _weekdayToString(int weekday) {
    String dateName = "";
    switch (weekday) {
      case 1:
        dateName = '월';
      case 2:
        dateName = '화';
      case 3:
        dateName = '수';
      case 4:
        dateName = '목';
      case 5:
        dateName = '금';
      case 6:
        dateName = '토';
      case 7:
        dateName = '일';
    }
    return dateName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(title: Text('Date Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '현재 시간: $currentDateTime',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 300,
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                use24hFormat: true,
                onDateTimeChanged: (value) {
                  chosenDateTime = value;
                  setState(() {});
                },
              ),
            ),
            Text(
              "선택시간 : ${chosenDateTime != null ? _chosenItem(chosenDateTime!) : "시간을 선택하세요!"}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  } // build

  //-----Functions------
  _chosenItem(DateTime now) {
    String chosenDateTime =
        ("${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${_weekdayToString(now.weekday)} ${now.hour.toString().padLeft(2, "0")}:${now.minute.toString().padLeft(2, "0")}");
    return chosenDateTime;
  }
} // class
