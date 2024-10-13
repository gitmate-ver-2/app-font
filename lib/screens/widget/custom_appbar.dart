import 'package:flutter/material.dart';
import 'package:gitmate/component/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // 앱바 제목
  final TextStyle? titleStyle; // 앱바 제목의 텍스트 스타일
  final bool centerTitle; // 타이틀 가운데 정렬 여부
  final PreferredSizeWidget? bottom; // 바텀 위젯
  final Color backgroundColor; // 앱바 배경색
  final double elevation; // 앱바 그림자 높이
  final double scrolledUnderElevation;
  final List<Widget>? actions; // 앱바에 표시할 액션 위젯들

  const CustomAppBar({
    super.key,
    required this.title, // 필수로 전달받을 값
    this.titleStyle,
    this.centerTitle = false, // 기본값 false
    this.bottom, // 바텀 위젯은 선택적
    this.backgroundColor = AppColors.BACKGROUNDCOLOR, // 기본 배경색
    this.elevation = 1.0, // 기본 그림자 높이
    this.scrolledUnderElevation = 1.0,
    this.actions, // 추가된 액션 위젯 리스트
  });

  @override
  Size get preferredSize => Size.fromHeight(
        bottom != null ? 100 + bottom!.preferredSize.height : 50.0,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: titleStyle, // 전달받은 스타일로 타이틀 스타일 지정
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      bottom: bottom, // 바텀이 있을 경우에만 표시
      actions: actions, // 추가된 액션 위젯 리스트 사용
    );
  }
}
