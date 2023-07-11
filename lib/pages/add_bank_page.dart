import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/bank.dart';

class AddBank_page extends StatefulWidget {
  const AddBank_page({Key? key}) : super(key: key);

  @override
  State<AddBank_page> createState() => _AddBank_pageState();
}

class _AddBank_pageState extends State<AddBank_page> {
  late Box<Bank> bankbox;
  final _key = GlobalKey<FormState>();
  int id = 0;
  String? name;
  int? accountNumber;
  double? amount;

  @override
  void initState() {
    super.initState();
    bankbox = Hive.box('bank');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple, title: Text('Add Bank')),
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
                      decoration: InputDecoration(labelText: 'Account Number', helperText: 'Input your Account Number'),
                      onSaved: (value) {
                        accountNumber = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Amount', helperText: 'Input your Amount'),
                      onSaved: (value) {
                        amount = double.parse(value!);
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
          SaveBank();
          Navigator.pop(context);
        },
        label: const Text('Save'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void SaveBank() async {
    final isValid = _key.currentState!.validate();

    if (isValid) {
      _key.currentState!.save();
      bankbox.add(Bank(id: id, name: name!, accountNumber: accountNumber!, amount: amount!));
    }
  }
}
