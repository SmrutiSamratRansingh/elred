import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eired/core/eired_exception.dart';
import 'package:eired/core/print_helper.dart';
import 'package:eired/features/todo_list/models/todo_model.dart';

class TodoRepository {
  addTodo(TodoModel todoModel, CollectionReference todoCollection) async {
    try {
      await todoCollection
          .add({
            'type': todoModel.type,
            'heading': todoModel.heading,
            'place': todoModel.place,
            'time': todoModel.time,
            'date': Timestamp.now()
          })
          .then((value) => printDebug("User Added"))
          .catchError((error) {
            printDebug("Failed to add user: $error");
            throw EiredException("unable to add todos");
          });
    } catch (e) {
      rethrow;
    }
  }

  editTodo(
      TodoModel todoModel, CollectionReference todoCollection, String docId) {
    try {
      todoCollection
          .doc(docId)
          .update({'company': 'Stokes and Sons'})
          .then((value) => printDebug("User Updated"))
          .catchError((error) {
            printDebug("Failed to update user: $error");
            throw EiredException("unable to update todos");
          });
    } catch (e) {
      rethrow;
    }
  }

  deleteTodo(
      TodoModel todoModel, CollectionReference todoCollection, String docId) {
    try {
      todoCollection
          .doc(docId)
          .delete()
          .then((value) => printDebug("User Deleted"))
          .catchError((error) {
        printDebug("Failed to delete user: $error");
        throw EiredException("unable to delete todos");
      });
    } catch (e) {
      rethrow;
    }
  }
}
