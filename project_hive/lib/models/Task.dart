import 'package:hive/hive.dart';
part 'Task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String task;
  Task({required this.task});
}
