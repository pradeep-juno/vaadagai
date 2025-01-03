import 'package:flutter/material.dart';

import '../../app_utils/app_functions.dart';

class AgentSchedulesScreen extends StatefulWidget {
  const AgentSchedulesScreen({super.key});

  @override
  State<AgentSchedulesScreen> createState() => _AgentSchedulesScreenState();
}

class _AgentSchedulesScreenState extends State<AgentSchedulesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: buildTextFun(context, "Welcome to agent Schedules screen",
            fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    ));
  }
}
