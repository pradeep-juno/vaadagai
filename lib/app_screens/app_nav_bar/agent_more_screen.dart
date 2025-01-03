import 'package:flutter/material.dart';

import '../../app_utils/app_functions.dart';

class AgentMoreScreen extends StatefulWidget {
  const AgentMoreScreen({super.key});

  @override
  State<AgentMoreScreen> createState() => _AgentMoreScreenState();
}

class _AgentMoreScreenState extends State<AgentMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: buildTextFun(context, "Welcome to agent more screen",
            fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    ));
  }
}
