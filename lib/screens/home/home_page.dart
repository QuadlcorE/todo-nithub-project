import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/services/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  final DatabaseService databaseService = DatabaseService();

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void openTodoAdd({String? docID, String? todo, bool? completed}) {
    if (todo != null) {
      textController.text = todo;
    }
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            content: TextField(
              controller: textController,
              decoration:
                  const InputDecoration(labelText: 'Task e.g Wash plates'),
            ),
            actions: [
              if (docID != null)
                ElevatedButton(
                    onPressed: () {
                      databaseService.deleteTodo(docID);
                    },
                    child: const Text('Delete')),
              ElevatedButton(
                onPressed: () {
                  if (docID == null || completed == null) {
                    databaseService.addNote(textController.text);
                  } else {
                    databaseService.updateTodo(
                        docID, textController.text, completed);
                  }
                  textController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Todo"),
        leading: IconButton(
          icon: const Icon(
              Icons.person_3_rounded), // Replace with your custom icon.
          onPressed: () {
            if (_scaffoldKey.currentState != null) {
              _scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Sign Out'),
              onTap: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
      ),

      //
      floatingActionButton: FloatingActionButton(
        onPressed: openTodoAdd,
        child: const Icon(
          Icons.plus_one,
        ),
      ),

      //
      body: StreamBuilder<QuerySnapshot>(
        stream: databaseService.getTodosStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List todosList = snapshot.data!.docs;
            return ListView.builder(
                itemCount: todosList.length,
                itemBuilder: (BuildContext context, int index) {
                  // Get individual doc
                  DocumentSnapshot document = todosList[index];
                  String docID = document.id;

                  // get each not and completed status
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String todoText = data['todo'];
                  bool completed = data['completed'];

                  // display as checkboxListTile
                  return GestureDetector(
                    onLongPress: () => openTodoAdd(
                        docID: docID, todo: todoText, completed: completed),
                    child: CheckboxListTile(
                      title: Text(todoText),
                      value: completed,
                      onChanged: (bool? value) {},
                    ),
                  );
                });
          } else {
            return Center(
              child: Text("This place looks Empty."),
            );
          }
        },
      ),
    );
  }
}
