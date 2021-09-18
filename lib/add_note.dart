import 'package:flutter/cupertino.dart';
import 'dog.dart';
import 'package:flutter/material.dart';

import 'db_helper3.dart';

class AddNote extends StatefulWidget {
  AddNote({this.name, this.age, this.id});

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
  int _counter = 0;
  static var db = DatabaseHelper.instance;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: Text(widget.title),
          ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // const Text(
                //   'You have pushed the button this many times:',
                // ),
                // Text(
                //   '$_counter',
                //   style: Theme.of(context).textTheme.headline4,
                // ),
                TextFormField(
                  controller: nameC,
                  decoration: const InputDecoration(hintText: 'enter name'),
                ),
                TextFormField(
                  controller: ageC,
                  decoration: const InputDecoration(hintText: 'enter age'),
                ),
                // TextFormField(
                //   controller: idC,
                //   decoration: const InputDecoration(hintText: 'enter id'),
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (c) => NoteList()));
                //     },
                //     child: Text('list')),
                // ElevatedButton(
                //   // textTheme: ButtonTextTheme.primary,
                //     child: const Text("get"),
                //     onPressed: () {
                //       db.queryAll().then((value) {
                //         print(value.toString());
                //         // AlertDialog(title: Text(value.toString()));
                //         showDialog(
                //             context: context,
                //             builder: (c) =>
                //                 AlertDialog(
                //                   title: Text(value.toString()),
                //                 ));
                //       });
                //     }),
                ElevatedButton(
                    // textTheme: ButtonTextTheme.primary,
                    child: const Text("insert"),
                    onPressed: () {
                      db
                          .insert(Dog(
                                  // -1,
                                  // id: int.parse(idC.text),
                                  id: 0,
                                  name: nameC.text,
                                  age: int.parse(ageC.text))
                              .toMap())
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('successfully inserted')));
                        // showDialog(
                        //   context: context,
                        //   builder: (c) => AlertDialog(
                        //         title: Text(
                        //             'successfully inserted ${toString()}'),
                        //       ));
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
