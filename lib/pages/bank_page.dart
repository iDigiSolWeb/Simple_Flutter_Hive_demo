import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/pages/add_bank_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/bank.dart';

class Bank_page extends StatefulWidget {
  const Bank_page({Key? key}) : super(key: key);

  @override
  State<Bank_page> createState() => _Bank_pageState();
}

class _Bank_pageState extends State<Bank_page> {
  late Box<Bank> bankbox;

  @override
  void initState() {
    super.initState();
    bankbox = Hive.box('bank');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: bankbox.listenable(),
                builder: (context, box, child) {
                  ///WE HAVE ADDED A FILTER TO SHOW IF YOU WANT TO ONLY SHOW A SPECIFIC QUERY.
                  final filterbox = box.values.where((element) => element.amount >= 100).toList();
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: filterbox.length,
                      itemBuilder: (context, index) {
                        final bank = filterbox[index];
                        return Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('ID: ' + bank.id.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('NAME: ' + bank.name.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('ACCOUNT NUMBER: ' + bank.accountNumber.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('AMOUNT: ' + bank.amount.toString()),
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
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddBank_page()));
        },
        label: const Text('ADD'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
