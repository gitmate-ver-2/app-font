import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitmate/component/colors.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  User? email;

  // 더미 알림 데이터
  final List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'title': '새로운 메시지',
      'content': '안녕하세요, 저희 서비스에 가입해주셔서 감사합니다! '
          '이제 다양한 기능을 이용해 보세요. 더 많은 업데이트가 준비 중입니다.',
      'imageUrl': 'assets/images/png/logo.png', // 프로필 이미지
      'profileName': 'GITMATE'
    },
    {
      'id': 2,
      'title': '새로운 업데이트',
      'content': '최신 버전이 출시되었습니다. 이제 더 많은 기능을 이용할 수 있습니다.',
      'imageUrl': 'assets/images/png/logo.png', // 프로필 이미지
      'profileName': 'GITMATE'
    },
  ];

  Future<void> _refreshData() async {
    // 새로고침할 때 데이터를 갱신하는 로직 추가 (예: 서버에서 최신 데이터를 가져오기)
    // 여기서는 2초 대기하는 예시를 사용했습니다.
    await Future.delayed(const Duration(seconds: 2));

    // 데이터 갱신 후 UI를 업데이트합니다.
    if (mounted) {
      setState(() {
        // 필요한 데이터를 새로고침 후 업데이트
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        title: "알림",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: user?.email == 'admin@admin.com'
            ? [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('접근할 수 없습니다.')),
                    );
                  },
                  icon: const Icon(Icons.notification_add),
                ),
              ]
            : null, // admin이 아니면 null로 표시하지 않음
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.BACKGROUNDCOLOR,
        color: AppColors.MAINCOLOR,
        onRefresh: _refreshData,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.disabled_by_default_rounded,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 프로필 이미지 및 이름
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.MAINCOLOR,
                              radius: 30,
                              child: Image.asset(notification['imageUrl'],
                                  width: 50),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              notification['profileName'], // 프로필 이름 표시
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // 알림 내용
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 제목
                              Text(
                                notification['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // 내용 (최대 3줄, 넘어가면 ... 처리)
                              Text(
                                notification['content']!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
