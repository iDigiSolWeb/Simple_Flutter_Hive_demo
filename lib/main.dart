import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/bank.dart';
import 'package:flutter_hive_demo/model/student.dart';
import 'package:flutter_hive_demo/model/teacher.dart';
import 'package:flutter_hive_demo/pages/bank_page.dart';
import 'package:flutter_hive_demo/pages/home_page.dart';
import 'package:flutter_hive_demo/pages/student_page.dart';
import 'package:flutter_hive_demo/pages/teacher_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

///GLOBAL VARIABLE -> DO NOT DO IN REAL WORLD APPLICATIOn
const secureStorage = FlutterSecureStorage();

void main() async {
  ///ENSURE INITIALIZED
  WidgetsFlutterBinding.ensureInitialized();

  ///<******** SEPERATE THIS CODE OUT IN REAL WORLD APPLICATION**********>
  ///CHECK IF ENCRYPTION KEY EXISTS
  final encryptionkey = await secureStorage.read(key: 'hiveKey');

  ///IF ENCRYPTION KEY DOES NOT EXIST , CREATE IT
  if (encryptionkey == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(key: 'hiveKey', value: base64Url.encode(key));
  }

  ///DECODE KEY - WE WILL USE THIS BELOW
  final KEY = base64Url.decode(encryptionkey.toString());

  ///GET APPLICATIONS DIRECTORY
  final dir = await path.getApplicationDocumentsDirectory();

  ///INITIALISE PATH
  Hive.init(dir.path);

  ///INITIALIZE FOLDER - IF ALREADY CREATED IT WONT CREATE IT AGAIN.
  Hive.initFlutter('hive_db');

  ///REGISTER ADAPTORS
  Hive.registerAdapter<Student>(StudentAdapter());
  Hive.registerAdapter<Teacher>(TeacherAdapter());
  Hive.registerAdapter<Bank>(BankAdapter());

  ///OPEN BOXES
  await Hive.openBox('home');
  await Hive.openBox<Student>('student');
  await Hive.openBox<Teacher>('teacher');

  ///IF DATA NEEDS TO BE ENCRYPTED ADD ENCRYPTION CIPHER AND PASS THE KEY FETCHED EARLIER.
  await Hive.openBox<Bank>('bank', encryptionCipher: HiveAesCipher(KEY));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Hive Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: MyHomePage(title: 'Flutter Hive Demo '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final pages = [
    Home_page(),
    Student_page(),
    Teacher_page(),
    Bank_page(),
  ];

  @override
  void dispose() {
    ///COMPACT BOXES ON EXIT
    Hive.box('home').compact();
    Hive.box('student').compact();
    Hive.box('teacher').compact();
    Hive.box('bank').compact();

    ///CLOSE BOX ON EXIT
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepPurple,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(color: Colors.white),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'Student'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Teacher'),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Bank'),
          ]),
    );
  }
}
