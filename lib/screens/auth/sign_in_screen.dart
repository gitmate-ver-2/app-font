import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitmate/component/colors.dart';
import 'package:gitmate/screens/home/home_screen.dart';
import 'package:gitmate/screens/widget/custom_button.dart';
import 'package:gitmate/screens/widget/custom_circle_button.dart';
import 'package:gitmate/screens/widget/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text, // 컨트롤러의 텍스트 사용
        password: _passwordController.text, // 컨트롤러의 텍스트 사용
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 실패')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Image.asset(
                    'assets/images/png/logo.png',
                    color: AppColors.MAINCOLOR,
                    scale: 2,
                  ),
                ),
                const Text(
                  "GITMATE",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  controller: _emailController,
                  hintText: '아이디',
                  icon: Icons.person,
                  cursorColor: Colors.grey,
                  textColor: Colors.black,
                  iconColor: AppColors.MAINCOLOR,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _passwordController,
                  hintText: '비밀번호',
                  icon: Icons.lock,
                  cursorColor: Colors.grey,
                  textColor: Colors.black,
                  iconColor: AppColors.MAINCOLOR,
                ),
                const SizedBox(height: 40), // 텍스트 필드와 로그인 버튼 사이 여백
                // 로그인 버튼
                CustomButton(
                  text: '로그인',
                  onPressed: signIn,
                  width: double.infinity, // 버튼을 화면 가득 채우기
                  height: 50.0, // 버튼 높이
                  color: Colors.blue, // 버튼 배경색
                  textStyle: const TextStyle(
                      fontSize: 16, color: Colors.white), // 텍스트 스타일
                ),
                TextButton(
                  onPressed: () {
                    // 회원가입 로직
                  },
                  child: const Text(
                    '회원가입 하시겠습니까?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '소셜로그인',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleButton(
                      imagePath: 'assets/images/png/google_logo.png',
                      size: 60.0, // 버튼 크기
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('구글 로그인 시도')),
                        );
                      },
                    ),
                    const SizedBox(width: 25),
                    CustomCircleButton(
                      imagePath: 'assets/images/png/github_logo.png',
                      size: 60.0, // 버튼 크기
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('깃허브 로그인 시도')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
