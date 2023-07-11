import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/student.dart';
import 'package:hive/hive.dart';

class AddStudent_page extends StatefulWidget {
  const AddStudent_page({Key? key}) : super(key: key);

  @override
  State<AddStudent_page> createState() => _AddStudent_pageState();
}

class _AddStudent_pageState extends State<AddStudent_page> {
  ///CREATE BOX VARIABLE
  late Box<Student> studentbox;

  ///CREATE KEY FORM STATE VARIABLE
  final _key = GlobalKey<FormState>();

  ///CREATE VARAIBLE FOR THE VALUES WE WILL BE SAVING
  int id = 0;
  String? name;
  String? subject;
  int? age;

  @override
  void initState() {
    super.initState();

    ///ASSIGN BOX
    studentbox = Hive.box('student');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple, title: Text('Add Student')),
      body: Column(
        children: [
          Form(

              ///MAKE SURE KEY IS ASIGNED
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'ID', helperText: 'Input your ID'),
                      onSaved: (value) {
                        ///PASS VALUES TO ABOVE CREATED VARIABLES
                        id = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: 'Name', helperText: 'Input your Name'),
                      onSaved: (value) {
                        name = value!;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Age', helperText: 'Input your age'),
                      onSaved: (value) {
                        age = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Subject', helperText: 'Input your subject'),
                      onSaved: (value) {
                        subject = value!;
                      },
                    ),
                  ],
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          SaveStudent();
          Navigator.pop(context);
        },
        label: const Text('Save'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void SaveStudent() async {
    ///CHECK IF FIELDS ARE VALID
    final isValid = _key.currentState!.validate();

    ///AND IF THEY ARE
    if (isValid) {
      ///RUN THE ONSAVED FUNCTIONS IN THE TEXTFORMFIELD
      _key.currentState!.save();

      /// AND NOW ADD THE STUDENT TO THE BOX.
      studentbox.add(Student(id: id, name: name!, age: age!, subject: subject!));
    }
  }
}
