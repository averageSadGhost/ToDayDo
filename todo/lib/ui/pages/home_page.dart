import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/extetions.dart';
import 'package:todo/ui/theme.dart';
import 'package:intl/intl.dart';
import '../../controllers/task_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          6.sbh,
          _showTasks(),
        ],
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
            ThemeServices().switchTheme();
          },
          icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined,
            size: 24,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          )),
      actions: [
        const CircleAvatar(
          backgroundImage: AssetImage("images/person.jpeg"),
          radius: 18,
        ),
        20.sbw,
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: subheadingStyle,
              ),
              Text("Today", style: headingStyle),
            ],
          ),
          MyButton(
            label: "+ Add task",
            onTap: () {
              Get.to(const AddTaskPage());
            },
          ),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        initialSelectedDate: DateTime.now(),
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(child: _noTaskMsg());
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              children: [
                SizeConfig.orientation == Orientation.landscape
                    ? 6.sbh
                    : 220.sbh,
                SvgPicture.asset(
                  "images/task.svg",
                  // ignore: deprecated_member_use
                  color: primaryClr.withOpacity(0.5),
                  height: 90,
                  semanticsLabel: "Task",
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "You do not have any tasks yet! \n Add new tasks to make your days productive.",
                    style: subTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizeConfig.orientation == Orientation.landscape
                    ? 120.sbh
                    : 180.sbh,
              ],
            ),
          ),
        )
      ],
    );
  }
}
