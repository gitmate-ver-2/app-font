import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitmate/component/colors.dart';
import 'package:gitmate/screens/profile/profile_edit_screen.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  User? email;

  // 더미 데이터
  final Map<String, dynamic> _profileData = {
    'profileImage': 'assets/images/png/profile_image.png', // 프로필 이미지 경로
    'username': 'jinhyeon-dev', // 사용자 이름
    'email': 'jinhyeon.dev@gmail.com', // 사용자 이메일
    'followers': 10, // 팔로워 수
    'following': 18, // 팔로잉 수
    'bio': 'Flutter 개발자이자 GitMate 프로젝트의 개발자입니다.', // 사용자 소개
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        title: "프로필",
        actions: [
          IconButton(
            onPressed: () {
              // 현재 로그인된 사용자의 이메일이 admin@admin.com일 경우에만 실행
              if (user?.email == 'admin@admin.com') {
                // 여기서 원하는 액션 수행
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileEditScreen(),
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('프로필 수정 모드로 이동합니다.'),
                  ),
                );
              } else {
                // 그렇지 않으면 스낵바 표시
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('접근할 수 없습니다.')),
                );
              }
            },
            icon: Icon(Icons.edit, color: AppColors.MAINCOLOR),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 프로필 이미지
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(_profileData['profileImage']),
            ),
            const SizedBox(height: 16),

            // 사용자 이름
            Text(
              _profileData['username'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),

            // 이메일
            if (user != null)
              Text(
                '${user!.email}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              )
            else
              const Text(
                '사용자 정보를 불러오지 못했습니다.',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),

            // 팔로워 / 팔로잉 수
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      _profileData['followers'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text('팔로워'),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    Text(
                      _profileData['following'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text('팔로잉'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 사용자 소개
            Text(
              _profileData['bio'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
