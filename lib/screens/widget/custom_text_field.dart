import 'package:flutter/material.dart';

/* 
  제발 살려주세요..
  - ㄱㅈㅎ -
*/

class CustomTextField extends StatelessWidget {
  final String hintText; // 힌트 텍스트
  final IconData? icon; // 왼쪽에 들어갈 아이콘
  final Color borderColor; // 테두리 색상
  final Color cursorColor; // 커서 색상
  final Color textColor; // 텍스트 색상
  final Color iconColor; // 아이콘 색상
  final bool obscureText; // 비밀번호 입력 여부
  final TextEditingController? controller; // 컨트롤러
  final bool enabled; // 입력 가능 여부

  const CustomTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.borderColor = Colors.grey, // 기본 테두리 색상
    this.cursorColor = Colors.black, // 기본 커서 색상
    this.textColor = Colors.black, // 기본 텍스트 색상
    this.iconColor = Colors.grey, // 기본 아이콘 색상
    this.obscureText = false, // 기본 값: 텍스트 숨기지 않음
    this.controller,
    this.enabled = true, // 기본적으로 입력 가능
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled, // enabled 속성을 외부에서 설정할 수 있도록
      controller: controller,
      obscureText: obscureText,
      cursorColor: cursorColor,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white, // 배경색
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: iconColor, // 아이콘 색상
              )
            : null, // 아이콘이 있을 경우에만 표시
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // 내용 패딩
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), // 둥근 테두리
          borderSide: BorderSide(
            color: borderColor, // 테두리 색상
            width: 0.5, // 테두리 두께
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), // 둥근 테두리
          borderSide: BorderSide(
            color: borderColor, // 테두리 색상 (포커스 시)
            width: 1, // 포커스 시 테두리 두께
          ),
        ),
      ),
    );
  }
}
