import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Color backgroundColor; // 배경 색상
  final IconData icon; // 아이콘
  final double iconSize; // 아이콘 크기
  final Color iconColor; // 아이콘 색상
  final VoidCallback onPressed; // 버튼이 눌렸을 때의 콜백

  const CustomFloatingActionButton({
    super.key,
    required this.backgroundColor, // 필수로 받아야 할 배경 색상
    required this.icon, // 필수로 받아야 할 아이콘
    this.iconSize = 30.0, // 아이콘 크기의 기본값
    this.iconColor = Colors.white, // 아이콘 색상의 기본값
    required this.onPressed, // 버튼이 눌렸을 때 실행되는 콜백
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backgroundColor, // 전달받은 배경 색상 사용
      onPressed: onPressed, // 전달받은 onPressed 콜백 실행
      child: Icon(
        icon, // 전달받은 아이콘 사용
        size: iconSize, // 전달받은 아이콘 크기 사용
        color: iconColor, // 전달받은 아이콘 색상 사용
      ),
    );
  }
}
