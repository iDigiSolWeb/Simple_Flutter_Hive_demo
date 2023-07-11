import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/student.dart';
import 'package:flutter_hive_demo/pages/add_student_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Student_page extends StatefulWidget {
  const Student_page({Key? key}) : super(key: key);

  @override
  State<Student_page> createState() => _Student_pageState();
}

class _Student_pageState extends State<Student_page> {
  ///DECLARE BOX
  late Box<Student> studentbox;

  @override
  void initState() {
    super.initState();

    ///ASSIGN BOX
    studentbox = Hive.box('student');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ///WE MAKE USE OF VALUE LISTANABLE BUILDER AND GIVE IT A CONTEXT, A BOX AND A CHILD
            ///WE USE VALUELISTANBLEBUILDER TO LISTEN TO CHANGES TO OUR BOX FOR ANY CRUD OPERATION.
            ValueListenableBuilder(

                ///SET THE BOX TO LISTEN TO
                valueListenable: studentbox.listenable(),
                builder: (context, box, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final student = box.getAt(index) as Student;
                        return Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('ID: ' + student.id.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('NAME: ' + student.name.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('AGE: ' + student.age.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('SUBJECT: ' + student.subject.toString()),
                                ),
                              ]),
                        );
                      });
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStudent_page()));
        },
        label: const Text('ADD'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
