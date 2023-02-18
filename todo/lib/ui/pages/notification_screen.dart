import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/extetions.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);
  final String payload;

  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';
  @override
  void initState() {
    _payload = widget.payload;
    super.initState();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _payload.split('|')[0],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: context.theme.primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            20.sbh,
            Column(
              children: [
                Text(
                  "Hello, Mohamed",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Get.isDarkMode ? Colors.white : darkGreyClr,
                  ),
                ),
                10.sbh,
                Text(
                  "You have a new reminder",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
                  ),
                ),
              ],
            ),
            20.sbh,
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primaryClr,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.text_format,
                            color: Colors.white,
                            size: 35,
                          ),
                          20.sbw,
                          const Text(
                            "Title",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      20.sbh,
                      Text(
                        _payload.split('|')[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      20.sbh,
                      Row(
                        children: [
                          const Icon(
                            Icons.description,
                            color: Colors.white,
                            size: 35,
                          ),
                          20.sbw,
                          const Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      20.sbh,
                      Text(
                        _payload.split('|')[1],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      20.sbh,
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          20.sbw,
                          const Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      20.sbh,
                      Text(
                        _payload.split('|')[2],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      20.sbh,
                    ],
                  ),
                ),
              ),
            ),
            10.sbh,
          ],
        ),
      ),
    );
  }
}
