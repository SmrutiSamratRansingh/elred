import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eired/core/print_helper.dart';
import 'package:eired/features/todo_list/views/enter_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../repository/todo_repository.dart';
import '../usecases/todo_crud.dart';
import '../viewmodel/todo_viewmodel.dart';

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => TodoViewModel(
          todoCrudUsecase: TodoCrudUsecase(todoRepository: TodoRepository()))),
      child: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const EnterData())));
        },
      ),
      body: Column(
        children: [topImageWidget(context), todoList(context)],
      ),
    );
  }

  todoList(BuildContext context) {
    final todoVmRead = context.read<TodoViewModel>();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: todoVmRead.todoCollection
            .orderBy('date', descending: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Expanded(
                child: Center(child: CircularProgressIndicator.adaptive()));
          }
          printDebug(snapshot.data!.docs.length);
          if (snapshot.data!.docs.isEmpty) {
            return const Expanded(
                child: Center(
                    child: Text(
              "No todos added yet..",
              style: TextStyle(color: Colors.black),
            )));
          }

          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  printDebug(snapshot.data!.docs.length.toString());
                  final data = snapshot.data!.docs[index].data();
                  return Column(
                    children: [
                      ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)),
                          child: Icon(
                            todoVmRead.getIconData(data["type"]),
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(data["heading"]),
                        subtitle: Text(data["place"]),
                        trailing: Text(data["time"]),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  );
                })),
          );
        }));
  }

  Stack topImageWidget(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Image.asset(
            "assets/images/todo_nature.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
          left: 20,
          child: const Text(
            " Your\n Things",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            DateFormat.yMMMEd().format(DateTime.now()),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
