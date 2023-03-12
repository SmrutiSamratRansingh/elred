import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eired/core/eired_exception.dart';
import 'package:eired/features/todo_list/models/todo_model.dart';
import 'package:eired/features/todo_list/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class TodoCrudUsecase {
  final TodoRepository todoRepository;

  TodoCrudUsecase({required this.todoRepository});

  addTodo(
      {required TodoModel todoModel, required CollectionReference ref}) async {
    try {
      await todoRepository.addTodo(todoModel, ref);
    } catch (e) {
      rethrow;
    }
  }

  editTodo(
      {required TodoModel todoModel,
      required CollectionReference ref,
      required String docId}) async {
    try {
      await todoRepository.editTodo(todoModel, ref, docId);
    } catch (e) {
      rethrow;
    }
  }

  deleteTodo(
      {required TodoModel todoModel,
      required CollectionReference ref,
      required String docId}) async {
    try {
      await todoRepository.deleteTodo(todoModel, ref, docId);
    } catch (e) {
      rethrow;
    }
  }

  String createTimeString(TimeOfDay? td) {
    String hour = td!.hour.toString();
    String mins = td.minute.toString();
    return "$hour : $mins";
  }
}
