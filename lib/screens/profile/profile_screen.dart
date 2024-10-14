import 'package:flutter/material.dart';
import 'package:gitmate/component/colors.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('접근할 수 없습니다.')),
              );
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
            Text(
              _profileData['email'],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
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
