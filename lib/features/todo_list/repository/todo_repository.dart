import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eired/core/print_helper.dart';
import 'package:eired/features/todo_list/models/todo_model.dart';

class TodoRepository {
  final firestore = FirebaseFirestore.instance;
  final todoCollection = FirebaseFirestore.instance.collection('todo');
  addTodo(TodoModel todoModel) {
    todoCollection
        .add({
          'type': todoModel.type.name,
          'heading': todoModel.heading,
          'description': todoModel.description
        })
        .then((value) => printDebug("User Added"))
        .catchError((error) => printDebug("Failed to add user: $error"));
  }

  editTodo(TodoModel todoModel) {}

  deleteTodo(TodoModel todoModel) {}
}
