import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user!.uid).get();
      if (userDoc.exists) {
        setState(() {
          profileData = userDoc.data() as Map<String, dynamic>?;
        });
      } else {
        // 프로필 정보가 없을 경우 기본 값 설정
        setState(() {
          profileData = {
            'profileImageUrl': 'assets/images/png/profile_image.png',
            'nickname': user!.displayName ?? '사용자 이름 없음',
            'followers': 0,
            'following': 0,
            'bio': '자기 소개가 없습니다.',
          };
        });
      }
    }
  }

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
                // 프로필 수정 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileEditScreen(),
                  ),
                );
              } else {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ProfileEditScreen(),
                //   ),
                // );
                // 그렇지 않으면 접근 불가 스낵바 표시
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
      body: profileData == null
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.MAINCOLOR,
              backgroundColor: AppColors.BACKGROUNDCOLOR,
            ))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 프로필 이미지
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profileData?['profileImageUrl'] != null
                        ? NetworkImage(profileData!['profileImageUrl'])
                        : AssetImage('assets/images/png/profile_image.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 16),

                  // 사용자 이름
                  Text(
                    profileData?['nickname'] ?? '이름 없음',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 이메일
                  Text(
                    user?.email ?? '이메일 없음',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
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
                            '10',
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
                            '18',
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
                    profileData?['bio'] ?? '자기 소개가 없습니다.',
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
