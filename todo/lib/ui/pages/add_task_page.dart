import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titileController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("ADD TASK", style: headingStyle),
              InputField(
                title: "Title",
                hint: "Enter title here ",
                controller: _titileController,
              ),
              InputField(
                title: "Note",
                hint: "Enter note here ",
                controller: _noteController,
              ),
              InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start time",
                      hint: _startTime,
                      widget: const Icon(Icons.access_time_rounded),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InputField(
                      title: "End time",
                      hint: _endTime,
                      widget: const Icon(Icons.access_time_rounded),
                    ),
                  ),
                ],
              ),
              InputField(
                title: "Reminder",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  items: remindList
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            "$item",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                  style: subTitleStyle,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedRemind = value!;
                    });
                  },
                ),
              ),
              InputField(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  items: repeatList
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                  style: subTitleStyle,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
