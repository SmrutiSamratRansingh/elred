import 'package:eired/core/enums.dart';

class TodoModel {
  final TodoType type;
  final String heading;
  final String place;
  final String description;
  final String date;

  TodoModel(
      {required this.type,
      required this.heading,
      required this.place,
      required this.description,
      required this.date});
}
