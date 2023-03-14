class TodoModel {
  final String type;
  final String heading;
  final String description;
  final String date;
  final String time;

  TodoModel(
      {required this.type,
      required this.heading,
      required this.description,
      required this.time,
      required this.date});
}
