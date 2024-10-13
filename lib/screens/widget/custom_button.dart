import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // 버튼에 표시할 텍스트
  final VoidCallback onPressed; // 버튼 클릭 시 실행될 콜백
  final double width; // 버튼 너비
  final double height; // 버튼 높이
  final Color color; // 버튼 배경색
  final TextStyle? textStyle; // 텍스트 스타일

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity, // 기본값: 화면 가득 채우기
    this.height = 50.0, // 기본 높이 50
    this.color = Colors.blue, // 기본 버튼 색상
    this.textStyle, // 텍스트 스타일 (선택적)
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // 버튼 너비
      height: height, // 버튼 높이
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // 버튼 배경색
        ),
        onPressed: onPressed, // 클릭 이벤트
        child: Text(
          text,
          style: textStyle ??
              const TextStyle(fontSize: 16, color: Colors.white), // 기본 텍스트 스타일
        ),
      ),
    );
  }
}
