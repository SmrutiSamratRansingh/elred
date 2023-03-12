import 'package:eired/features/todo_list/models/todo_model.dart';
import 'package:eired/features/todo_list/repository/todo_repository.dart';
import 'package:eired/features/todo_list/usecases/todo_crud.dart';
import 'package:eired/features/todo_list/viewmodel/todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterData extends StatelessWidget {
  const EnterData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => TodoViewModel(
          todoCrudUsecase: TodoCrudUsecase(todoRepository: TodoRepository()))),
      child: const EnterDataScreen(),
    );
  }
}

class EnterDataScreen extends StatelessWidget {
  const EnterDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoVmRead = context.read<TodoViewModel>();
    return Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[900],
          title: const Text("Add New Thing"),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
            minimum: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<TodoViewModel>(
                    builder: (context, tdVm, child) {
                      return icon(tdVm);
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  dropDownButton(context),
                  const SizedBox(
                    height: 10,
                  ),
                  createTextField(
                    hint: "Title",
                    controller: todoVmRead.titleController,
                    isReadOnly: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  createTextField(
                    hint: "Place",
                    controller: todoVmRead.placeController,
                    isReadOnly: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  createTextField(
                    hint: "Time",
                    controller: todoVmRead.timeController,
                    isReadOnly: true,
                    callback: () async {
                      TimeOfDay? td = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      todoVmRead.createTimeString(td);
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            addTodo(context);
                          },
                          child: const Text("ADD YOUR THING")))
                ],
              ),
            )));
  }

  Container icon(TodoViewModel tdVm) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
      child: Icon(
        tdVm.icon,
        color: Colors.blue,
      ),
    );
  }

  SizedBox dropDownButton(BuildContext context) {
    final todoVmRead = context.read<TodoViewModel>();
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.lightBlue,
        hint: const Text(
          "Select Type",
          style: TextStyle(color: Colors.grey),
        ),
        items: todoVmRead.typeList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
        onChanged: (val) {
          todoVmRead.changeIcon(val);
        },
      ),
    );
  }

  TextField createTextField(
      {required String hint,
      required TextEditingController controller,
      required bool isReadOnly,
      Function()? callback}) {
    return TextField(
        onTap: callback,
        style: const TextStyle(color: Colors.white),
        readOnly: isReadOnly,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ));
  }

  void addTodo(BuildContext context) {
    final todoVmRead = context.read<TodoViewModel>();
    todoVmRead.addTodo();
  }
}
