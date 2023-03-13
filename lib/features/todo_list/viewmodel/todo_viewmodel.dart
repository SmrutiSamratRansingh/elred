import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eired/core/eired_exception.dart';
import 'package:eired/core/enums.dart';
import 'package:eired/features/todo_list/models/todo_model.dart';
import 'package:eired/features/todo_list/usecases/todo_crud.dart';
import 'package:eired/features/todo_list/views/enter_data_screen.dart';
import 'package:eired/features/todo_list/views/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/print_helper.dart';
import '../../../core/snackbar_helper.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoCrudUsecase todoCrudUsecase;
  final firestore = FirebaseFirestore.instance;
  final todoCollection = FirebaseFirestore.instance.collection('todo');
  TextEditingController titleController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController timeController = TextEditingController();
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

  bool isEdit = false;

  late TodoModel todoEditModel;

  String docIdEdit = "";

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
      Get.offAll(const TodoScreen());
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

  void editTodo() async {
    printDebug(docIdEdit);
    try {
      final todo = TodoModel(
          type: selectedType,
          heading: titleController.text,
          place: placeController.text,
          time: timeController.text);
      await todoCrudUsecase.editTodo(
          todoModel: todo, ref: todoCollection, docId: docIdEdit);
      Get.back();
    } on EiredException catch (e) {
      ShowSnackbar.showErrorSnackbar(e.message);
    } catch (e) {
      ShowSnackbar.showErrorSnackbar("unable to add todos : $e");
    }
  }

  void setDataForEdit(TodoModel todoModel, String docID) async {
    isEdit = true;
    todoEditModel = todoModel;
    icon = getIconData(todoModel.type);
    titleController.text = todoModel.heading;
    placeController.text = todoModel.place;
    timeController.text = todoModel.time;

    docIdEdit = docID;
    Get.to(() => const EnterDataScreen());
  }

  void deleteDoc(String docId) async {
    await todoCrudUsecase.deleteTodo(docId: docId, ref: todoCollection);
    Get.back();
  }

  void clearControllers() {
    titleController.clear();
    placeController.clear();
    timeController.clear();
  }

  @override
  void dispose() {
    timeController.dispose();
    timeController.dispose();
    placeController.dispose();
    super.dispose();
  }
}
