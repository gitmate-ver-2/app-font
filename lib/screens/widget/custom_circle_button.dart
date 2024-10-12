import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  final String imagePath; // 이미지 경로
  final double size; // 버튼 크기
  final VoidCallback onPressed; // 버튼 클릭 시 실행될 콜백
  final BoxShape shape; // 버튼 모양 (둥근 모양 또는 사각형 등)
  final Color backgroundColor; // 버튼 배경 색상
  final Color borderColor; // 테두리 색상
  final double borderWidth; // 테두리 두께
  final double borderRadius; // 테두리 둥글기 (사각형 모양에서만)
  final List<BoxShadow>? boxShadow; // 그림자 설정
  final EdgeInsets padding; // 이미지 패딩
  final String? text; // 버튼 하단에 표시할 텍스트
  final TextStyle? textStyle; // 텍스트 스타일

  const CustomCircleButton({
    super.key,
    required this.imagePath,
    this.size = 60.0, // 기본 크기를 60으로 설정
    required this.onPressed,
    this.shape = BoxShape.circle, // 기본값을 동그란 모양으로 설정
    this.backgroundColor = Colors.white, // 기본 배경 색상
    this.borderColor = Colors.grey, // 기본 테두리 색상
    this.borderWidth = 0.5, // 기본 테두리 두께
    this.borderRadius = 10.0, // 기본 둥글기 (사각형 모양일 때)
    this.boxShadow, // 기본적으로 그림자는 설정 안 됨
    this.padding = const EdgeInsets.all(8.0), // 기본 패딩 값
    this.text, // 하단 텍스트 (선택적)
    this.textStyle, // 텍스트 스타일 (선택적)
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: size, // 지정된 크기
            height: size, // 지정된 크기
            decoration: BoxDecoration(
              color: backgroundColor, // 버튼 배경 색상
              shape: shape, // 외부에서 전달된 모양을 사용
              border: Border.all(
                color: borderColor, // 테두리 색상
                width: borderWidth, // 테두리 두께
              ),
              borderRadius: shape == BoxShape.rectangle
                  ? BorderRadius.circular(borderRadius) // 사각형일 경우 둥글기 적용
                  : null, // 둥근 모양일 경우에는 둥글기 적용 안 함
              boxShadow: boxShadow ?? [], // 그림자 설정
            ),
            child: Padding(
              padding: padding, // 이미지에 대한 패딩
              child: Image.asset(imagePath), // 로고 이미지
            ),
          ),
        ),
        if (text != null) // 텍스트가 있을 경우에만 표시
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              text!,
              style: textStyle ??
                  const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black, // 기본 텍스트 색상
                  ),
            ),
          ),
      ],
    );
  }
}
