import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  final taskList = <Task>[
    Task(
      id: 4,
      title: "test 1",
      note: "note 1",
      isCompleted: 1,
      startTime: DateFormat("hh:mm a")
          .format(DateTime.now().add(const Duration(minutes: 1)))
          .toString(),
      color: 1,
    ),
  ];

  getTasks() {}
}
