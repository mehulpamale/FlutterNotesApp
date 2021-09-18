import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'dog.dart';
import 'package:flutter/material.dart';

import 'db_helper3.dart';

class AddNote extends StatefulWidget {
  AddNote({required this.id});

  String? name;
  int? age;
  int? id;

  AddNote.fromExisting(this.id);

  var db = DatabaseHelper.instance.database;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<AddNote> createState() => _AddNoteState();
}

final nameC = TextEditingController();
final ageC = TextEditingController();
final idC = TextEditingController();

class _AddNoteState extends State<AddNote> {
  static var db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();

    // print(widget.id);
    if (widget.id != null) {
      idC.text = widget.id.toString();
      db.query(widget.id!).then((value) {
        Map<String, dynamic> dog = value[0];
        nameC.text = dog['name'];
        ageC.text = dog['age'].toString();
      });
    }
    else{
      nameC.text = "";
      ageC.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: nameC,
                  decoration: const InputDecoration(hintText: 'enter name'),
                ),
                TextFormField(
                  controller: ageC,
                  decoration: const InputDecoration(hintText: 'enter age'),
                ),
                widget.id == null
                    ? ElevatedButton(
                        // textTheme: ButtonTextTheme.primary,
                        child: const Text("add"),
                        onPressed: () {
                          db
                              .insert(Dog(
                                      // -1,
                                      // id: int.parse(idC.text),
                                      // id: 0,
                                      name: nameC.text,
                                      age: int.parse(ageC.text))
                                  .toMap())
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('successfully inserted')));
                          });
                        })
                    : ElevatedButton(
                        // textTheme: ButtonTextTheme.primary,
                        child: const Text("update"),
                        onPressed: () {
                          db
                              .update(Dog(
                                      // -1,
                                      // id: int.parse(idC.text),
                                      id: widget.id,
                                      name: nameC.text,
                                      age: int.parse(ageC.text))
                                  .toMap())
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('successfully updated')));
                          });
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
