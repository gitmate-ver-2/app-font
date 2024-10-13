import 'package:flutter/material.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';
import 'package:gitmate/screens/widget/custom_floating_action_button.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: "커뮤니티",
      ),
      body: Center(
        child: Text("Community"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: 60,
          height: 60,
          child: CustomFloatingActionButton(
            backgroundColor: Colors.blue, // 원하는 배경 색상
            icon: Icons.comment, // 원하는 아이콘
            iconColor: Colors.white, // 아이콘 색상 설정
            onPressed: () {
              // 눌렀을 때의 동작
            },
          ),
        ),
      ),
    );
  }
}
