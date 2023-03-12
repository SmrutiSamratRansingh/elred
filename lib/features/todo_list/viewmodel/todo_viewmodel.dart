import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eired/core/eired_exception.dart';
import 'package:eired/core/enums.dart';
import 'package:eired/features/todo_list/models/todo_model.dart';
import 'package:eired/features/todo_list/usecases/todo_crud.dart';
import 'package:eired/features/todo_list/views/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/snackbar_helper.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoCrudUsecase todoCrudUsecase;
  final firestore = FirebaseFirestore.instance;
  final todoCollection = FirebaseFirestore.instance.collection('todo');
  final titleController = TextEditingController();
  final placeController = TextEditingController();
  final timeController = TextEditingController();
  final List<String> typeList = [
    "Music",
    "Business",
    "Office",
    "Sports",
    "Shopping",
    "Home"
  ];
  String selectedType = "";
  IconData icon = Icons.face;

  bool isLoading = false;

  TodoViewModel({required this.todoCrudUsecase});

  void createTimeString(TimeOfDay? td) {
    String time = todoCrudUsecase.createTimeString(td);
    timeController.text = time;
  }

  void changeIcon(String? val) {
    if (val == null) {
      return;
    }
    selectedType = val;
    if (val.toLowerCase() == TodoInfo.music.name) {
      icon = Icons.music_note;
    } else if (val.toLowerCase() == TodoInfo.business.name) {
      icon = Icons.business;
    } else if (val.toLowerCase() == TodoInfo.office.name) {
      icon = Icons.local_post_office;
    } else if (val.toLowerCase() == TodoInfo.sports.name) {
      icon = Icons.sports;
    } else if (val.toLowerCase() == TodoInfo.shopping.name) {
      icon = Icons.shopping_bag;
    } else if (val.toLowerCase() == TodoInfo.home.name) {
      icon = Icons.home;
    }
    notifyListeners();
  }

  void addTodo() {
    try {
      isLoading = true;
      notifyListeners();
      final todo = TodoModel(
          type: selectedType,
          heading: titleController.text,
          place: placeController.text,
          time: timeController.text);
      todoCrudUsecase.addTodo(todoModel: todo, ref: todoCollection);
      Get.offAll(const Todo());
    } on EiredException catch (e) {
      ShowSnackbar.showErrorSnackbar(e.message);
    } catch (e) {
      ShowSnackbar.showErrorSnackbar("unable to add todos : $e");
    }
  }

  IconData getIconData(String? val) {
    if (val!.toLowerCase() == TodoInfo.music.name) {
      return Icons.music_note;
    } else if (val.toLowerCase() == TodoInfo.business.name) {
      return Icons.business;
    } else if (val.toLowerCase() == TodoInfo.office.name) {
      return Icons.local_post_office;
    } else if (val.toLowerCase() == TodoInfo.sports.name) {
      return Icons.sports;
    } else if (val.toLowerCase() == TodoInfo.shopping.name) {
      return Icons.shopping_bag;
    } else if (val.toLowerCase() == TodoInfo.home.name) {
      return Icons.home;
    } else {
      return Icons.face;
    }
  }
}
