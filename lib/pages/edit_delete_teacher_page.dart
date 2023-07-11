import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/teacher.dart';
import 'package:hive/hive.dart';

class Edit_Delete_Teacher_page extends StatefulWidget {
  final int index;
  const Edit_Delete_Teacher_page({required this.index, Key? key}) : super(key: key);

  @override
  State<Edit_Delete_Teacher_page> createState() => _Edit_Delete_Teacher_pageState();
}

class _Edit_Delete_Teacher_pageState extends State<Edit_Delete_Teacher_page> {
  ///DECLARE REQUIRED VARIABLES
  late Box<Teacher> teacherbox;
  final _key = GlobalKey<FormState>();
  late int id = 0, age;
  String? name, subject;
  late Teacher teacher;

  TextEditingController _idcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _subjectcontroller = TextEditingController();
  TextEditingController _agecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    ///ASSIGN BOX
    teacherbox = Hive.box('teacher');

    ///GET TEACHER AT SPECIFIC INDEX
    teacher = teacherbox.getAt(widget.index)!;

    ///ASSING TO ITS CONTROLLER;
    _idcontroller = TextEditingController(text: teacher.id.toString());
    _namecontroller = TextEditingController(text: teacher.name);
    _subjectcontroller = TextEditingController(text: teacher.subject);
    _agecontroller = TextEditingController(text: teacher.age.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple, title: Text('Edit Teacher'), actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            deleteTeacher();
            Navigator.pop(context);
          },
        )
      ]),
      body: Column(
        children: [
          Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      enabled: false,
                      controller: _idcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'ID', helperText: 'Input your ID'),
                      onSaved: (value) {
                        id = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      controller: _namecontroller,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: 'Name', helperText: 'Input your Name'),
                      onSaved: (value) {
                        name = value!;
                      },
                    ),
                    TextFormField(
                      controller: _agecontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Age', helperText: 'Input your age'),
                      onSaved: (value) {
                        age = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      controller: _subjectcontroller,
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
          SaveEditedTeacher();
          Navigator.pop(context);
        },
        label: const Text('Save'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  ///DELETE TEACHER
  void deleteTeacher() async {
    teacherbox.deleteAt(widget.index);
  }

  ///EDIT TEACHER
  void SaveEditedTeacher() async {
    final isValid = _key.currentState!.validate();

    if (isValid) {
      _key.currentState!.save();
      teacherbox.putAt(widget.index, Teacher(id: id, name: name!, age: age!, subject: subject!));
    }
  }
}
