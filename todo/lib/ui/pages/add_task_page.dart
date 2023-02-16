import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/extetions.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
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
      // ignore: deprecated_member_use
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.sbh,
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
                  12.sbw,
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
                widget: Row(
                  children: [
                    DropdownButton(
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
                    6.sbw,
                  ],
                ),
              ),
              InputField(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: Row(
                  children: [
                    DropdownButton(
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
                    6.sbw,
                  ],
                ),
              ),
              18.sbh,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                    label: "Create Task",
                    onTap: () {
                      Get.back();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      // ignore: deprecated_member_use
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: primaryClr,
        ),
      ),
      actions: [
        const CircleAvatar(
          backgroundImage: AssetImage("images/person.jpeg"),
          radius: 18,
        ),
        20.sbw,
      ],
    );
  }

  Column _colorPalette() {
    return Column(
      children: [
        Text("Color", style: titleStyle),
        6.sbh,
        Wrap(
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                  radius: 14,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
