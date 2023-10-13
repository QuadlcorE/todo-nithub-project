import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  late CollectionReference todos;

  DatabaseService({this.uid}) {
    todos = FirebaseFirestore.instance.collection("todos.${uid}");
  }

  Future<void> addNote(String todo) {
    return todos.add({
      'todo': todo,
      'completed': false,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getTodosStream() {
    final todosStream =
        todos.orderBy("timestamp", descending: true).snapshots();
    return todosStream;
  }

  Future<void> updateTodo(String docID, String newTodo, bool completed) {
    return todos.doc(docID).update({
      'todo': newTodo,
      'completed': completed,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteTodo(String docID) {
    return todos.doc(docID).delete();
  }
}
