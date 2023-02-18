import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/extetions.dart';
import 'package:todo/ui/theme.dart';
import 'package:intl/intl.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import '../../controllers/task_controller.dart';
import 'package:todo/services/notification_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notyfyHelper;
  @override
  void initState() {
    notyfyHelper = NotifyHelper();
    notyfyHelper.requestIOSPermissions();
    notyfyHelper.initializeNotification();
    super.initState();
    _taskController.getTasks();
  }

  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = TaskController();
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
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              _taskController.getTasks();
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

  Future<void> _onRefresh() async {
    _taskController.getTasks();
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          if (_taskController.taskList.isEmpty) {
            return _noTaskMsg();
          } else {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                scrollDirection: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  Task task = _taskController.taskList[index];
                  DateTime date = DateFormat.jm().parse(task.endTime!);
                  String myTime = DateFormat("HH:mm").format(date);
                  List<String> time = myTime.split(":");
                  debugPrint(myTime);
                  NotifyHelper().scheduledNotification(
                      int.parse(time[0]), int.parse(time[1]), task);
                  if ((task.date == DateFormat.yMd().format(_selectedDate) ||
                          task.repeat == "Daily") ||
                      (task.repeat == "Weekly" &&
                          _selectedDate
                                      .difference(
                                        DateFormat.yMd().parse(task.date!),
                                      )
                                      .inDays %
                                  7 ==
                              0) ||
                      (task.repeat == "Monthly" &&
                          _selectedDate
                                      .difference(
                                        DateFormat.yMd().parse(task.date!),
                                      )
                                      .inDays %
                                  30 ==
                              0)) {
                    return _buildTaskCardItem(index, task);
                  } else {
                    return Container();
                  }
                },
                itemCount: _taskController.taskList.length,
              ),
            );
          }
        },
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
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
          ),
        )
      ],
    );
  }

  _buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[600]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.3
                  : SizeConfig.screenHeight * 0.39),
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
              ),
              20.sbh,
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      label: "Task Completed",
                      onTap: () {
                        _taskController.markTaskCompleted(task.id!);
                        Get.back();
                      },
                      clr: Colors.green[400]!,
                    ),
              _buildBottomSheet(
                label: "Delete Task",
                onTap: () {
                  _taskController.deleteTasks(task);
                  Get.back();
                },
                clr: Colors.red[400]!,
              ),
              Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
              5.sbh,
              _buildBottomSheet(
                label: "Cancel",
                onTap: () {
                  Get.back();
                },
                clr: primaryClr,
              ),
              20.sbh
            ],
          ),
        ),
      ),
    );
  }

  _buildTaskCardItem(int index, Task task) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 700),
      child: SlideAnimation(
        horizontalOffset: 300,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () => _showBottomSheet(context, task),
            child: TaskTile(task: task),
          ),
        ),
      ),
    );
  }
}
