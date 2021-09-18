import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_dogs_db_demo/db_helper3.dart';

import 'add_note.dart';
import 'dog.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final db = DatabaseHelper.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchList();
  }

  List<Map<String, dynamic>> dogs = List.empty();

  Future<void> fetchList() async {
    var records = await db.queryAll();
    setState(() {
      dogs = records;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dogs List'),
      ),
      body: ListView.builder(
          itemCount: dogs.length,
          itemBuilder: (c, i) {
            Map<String, dynamic> dog = dogs[i];
            return Card(
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    db.delete(dog['id']);
                    fetchList();
                  },
                ),
                onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => AddNote.fromExisting(dog['id'])))
                    .then((value) => fetchList()),
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('id: ${dog['id']}'),
                          Text('name: ${dog['name']}'),
                          Text('age: ${dog['age']}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              onPressed: () => fetchList(),
              heroTag: 'fab2',
              child: Icon(Icons.refresh),
            ),
          ),
          FloatingActionButton(
            heroTag: 'fab1',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => AddNote(id: null)));
            },
            tooltip: 'add note',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
