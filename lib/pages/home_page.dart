import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  ///DECLARE BOX
  late Box homeBox;

  @override
  void initState() {
    ///THE BOX ALREADY HAS BEEN OPENED WE ARE JUST ASSIGNING IT.
    homeBox = Hive.box('home');

    /// WE CAN NOT USE "PUT" TO CREATE DATA.
    homeBox.put('1', 'David');
    homeBox.put('2', 'Anton');
    homeBox.put('3', 'Carmen');

    ///OR WE CAN USE PUTT ALL
    homeBox.putAll({
      '4': 'Gideon',
      '5': 'Helene',
      '6': 'Mary',
      '7': 'John',
    });

    /// AND IF YOU WANT TO ADD DATA AND DONT REALLY NEED ACCESS TO IT VIA THE KEY YOU
    /// CAN USE 'ADD'
    homeBox.add('Anton2');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///ACCESS VIA KEY
            Text(homeBox.get('1')), //put
            Text(homeBox.get('2')),
            Text(homeBox.get('3')),
            Text(homeBox.get('4')), //put all
            Text(homeBox.get('5')),
            Text(homeBox.get('6')),
            Text(homeBox.get('7')),

            ///ACCESS VIA KEY INDEX.
            Text(homeBox.getAt(0)), //add
          ],
        ),
      ),
    );
  }
}
