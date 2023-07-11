import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/teacher.dart';
import 'package:hive/hive.dart';

class AddTeacher_page extends StatefulWidget {
  const AddTeacher_page({Key? key}) : super(key: key);

  @override
  State<AddTeacher_page> createState() => _AddTeacher_pageState();
}

class _AddTeacher_pageState extends State<AddTeacher_page> {
  late Box<Teacher> teacherbox;
  final _key = GlobalKey<FormState>();
  int id = 0;
  String? name;
  String? subject;
  int? age;

  @override
  void initState() {
    super.initState();
    teacherbox = Hive.box('teacher');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple, title: Text('Add Teacher')),
      body: Column(
        children: [
          Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'ID', helperText: 'Input your ID'),
                      onSaved: (value) {
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
          SaveTeacher();
          Navigator.pop(context);
        },
        label: const Text('Save'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void SaveTeacher() async {
    final isValid = _key.currentState!.validate();

    if (isValid) {
      _key.currentState!.save();
      teacherbox.add(Teacher(id: id, name: name!, age: age!, subject: subject!));
    }
  }
}
