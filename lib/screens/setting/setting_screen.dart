import 'package:flutter/material.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: "설정",
      ),
      body: Center(
        child: Text("setting"),
      ),
    );
  }
}
