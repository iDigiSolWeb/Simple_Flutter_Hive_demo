import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/teacher.dart';
import 'package:flutter_hive_demo/pages/add_teacher_page.dart';
import 'package:flutter_hive_demo/pages/edit_delete_teacher_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Teacher_page extends StatefulWidget {
  const Teacher_page({Key? key}) : super(key: key);

  @override
  State<Teacher_page> createState() => _Teacher_pageState();
}

class _Teacher_pageState extends State<Teacher_page> {
  late Box<Teacher> teacherbox;

  @override
  void initState() {
    super.initState();
    teacherbox = Hive.box('teacher');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: teacherbox.listenable(),
                builder: (context, box, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final teacher = box.getAt(index) as Teacher;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Edit_Delete_Teacher_page(index: index!)));
                          },
                          child: Card(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('ID: ' + teacher.id.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('NAME: ' + teacher.name.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('AGE: ' + teacher.age.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('SUBJECT: ' + teacher.subject.toString()),
                                  ),
                                ]),
                          ),
                        );
                      });
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTeacher_page()));
        },
        label: const Text('ADD'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
