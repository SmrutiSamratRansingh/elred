import 'package:eired/features/todo_list/models/todo_model.dart';
import 'package:eired/features/todo_list/repository/todo_repository.dart';

class TodoCrudUsecase {
  final TodoRepository todoRepository;

  TodoCrudUsecase({required this.todoRepository});

  addTodo({required TodoModel todoModel}) async {
    await todoRepository.addTodo(todoModel);
  }

  editTodo({required TodoModel todoModel}) async {
    await todoRepository.editTodo(todoModel);
  }

  deleteTodo({required TodoModel todoModel}) async {
    await todoRepository.deleteTodo(todoModel);
  }
}
