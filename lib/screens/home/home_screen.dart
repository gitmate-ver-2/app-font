import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitmate/component/colors.dart';
import 'package:gitmate/screens/auth/sign_in_screen.dart';
import 'package:gitmate/screens/community/community_screen.dart';
import 'package:gitmate/screens/employment/employment_screen.dart';
import 'package:gitmate/screens/event/event_screen.dart';
import 'package:gitmate/screens/notification/notification_screen.dart';
import 'package:gitmate/screens/profile/profile_screen.dart';
import 'package:gitmate/screens/setting/setting_screen.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';
import 'package:gitmate/screens/widget/custom_circle_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> imgList = [
    'assets/images/event_images/event(1).png',
    'assets/images/event_images/event(2).png',
    'assets/images/event_images/event(3).jpg',
    'assets/images/event_images/event(4).gif',
    'assets/images/event_images/event(5).png',
  ];

  final List<Map<String, String>> popularPosts = [
    {'title': '고퍼콘 행사!', 'image': 'assets/images/image(1).jpeg'},
    {'title': '이정주의 Flutter Class', 'image': 'assets/images/image(2).png'},
    {
      'title': 'Hackathon 참가',
      'image': 'assets/images/event_images/event(3).jpg'
    },
    {'title': 'UI 디자인 팁', 'image': 'assets/images/event_images/event(4).gif'},
  ];

  // 더미 데이터: 진행 중인 행사
  final List<Map<String, String>> ongoingEvents = [
    {
      'title': 'Googel I/O Ex 2024 Incheon',
      'image': 'assets/images/event_images/event(4).gif'
    },
    {
      'title': 'Future<Flutter> 2024',
      'image': 'assets/images/event_images/event(3).jpg'
    },
    {
      'title': 'HyperApp 2024',
      'image': 'assets/images/event_images/event(1).png'
    },
    {
      'title': 'Devcon 2024',
      'image': 'assets/images/event_images/event(2).png'
    },
  ];

  // 더미 데이터: 최신 채용 정보
  final List<Map<String, String>> latestJobs = [
    {'title': '백프로 채용', 'image': 'assets/company/company(1).png'},
    {'title': '파마브로스', 'image': 'assets/company/company(2).png'},
    {'title': '알고케어', 'image': 'assets/company/company(3).png'},
  ];

  int _currentIndex = 0;

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignInScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _refreshData() async {
    // 새로고침할 때 데이터를 갱신하는 로직 추가 (예: 서버에서 최신 데이터를 가져오기)
    // 여기서는 2초 대기하는 예시를 사용했습니다.
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      (Route<dynamic> route) => false,
    );

    if (mounted) {
      setState(() {
        // 필요한 데이터를 새로고침 후 업데이트
      });
    }
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text(
            'Gitmate 로그아웃',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('정말 로그아웃 하시겠습니까?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                '취소',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                '확인',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _signOut();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        title: "GITMATE",
        titleStyle: TextStyle(
          color: AppColors.MAINCOLOR,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: AppColors.BACKGROUNDCOLOR,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.MAINCOLOR,
              ),
              child: Text(
                '메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('내 프로필'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('설정'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('접근할 수 없습니다.')),
                );
              },
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('로그아웃'),
              onTap: () {
                Navigator.pop(context);
                _showLogoutDialog();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: AppColors.BACKGROUNDCOLOR,
          color: AppColors.MAINCOLOR,
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(width: 0.5, color: Colors.grey)),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.25,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: imgList.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(item),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.asMap().entries.map((entry) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(
                                  _currentIndex == entry.key ? 1.0 : 0.4,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCircleButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommunityScreen()),
                          );
                        },
                        shape: BoxShape.rectangle,
                        imagePath: 'assets/images/emojis/emoji(4).png',
                        borderWidth: 0.5, // 테두리 두께
                        borderRadius: 10.0, // 둥글기 (사각형일 경우만 적용)
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(2, 1), // 그림자 위치
                          ),
                        ],
                        text: "커뮤니티",
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                      CustomCircleButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmploymentScreen()),
                          );
                        },
                        shape: BoxShape.rectangle,
                        imagePath: 'assets/images/emojis/emoji(2).png',
                        borderWidth: 0.5, // 테두리 두께
                        borderRadius: 10.0, // 둥글기 (사각형일 경우만 적용)
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(2, 1), // 그림자 위치
                          ),
                        ],
                        text: "채용",
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                        padding: const EdgeInsets.all(3.0),
                      ),
                      CustomCircleButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventScreen()),
                          );
                        },
                        shape: BoxShape.rectangle,
                        imagePath: 'assets/images/emojis/emoji(1).png',
                        borderWidth: 0.5, // 테두리 두께
                        borderRadius: 10.0, // 둥글기 (사각형일 경우만 적용)
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(2, 2), // 그림자 위치
                          ),
                        ],
                        text: "행사",
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Builder(
                        builder: (BuildContext context) {
                          return CustomCircleButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => NotificationScreen()),
                              );
                            },
                            shape: BoxShape.rectangle,
                            imagePath: 'assets/images/emojis/emoji(3).png',
                            borderWidth: 0.5,
                            borderRadius: 10.0,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: const Offset(1, 1),
                              ),
                            ],
                            text: "알림",
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),

                /*
                  카테고리별 card widget
                */

                _buildSection(
                  context,
                  'assets/images/emojis/emoji(6).png',
                  '인기 게시물',
                  popularPosts,
                  150,
                ),
                SizedBox(height: 12),
                _buildSection(
                  context,
                  'assets/images/emojis/emoji(8).png',
                  '진행중인 행사',
                  ongoingEvents,
                  220,
                ),
                SizedBox(height: 12),
                _buildSection(
                  context,
                  'assets/images/emojis/emoji(7).png',
                  '최신 채용 정보',
                  latestJobs,
                  150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String iconPath, String title,
      List<Map<String, String>> items, double itemWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Row(
            children: [
              Image.asset(iconPath, width: 24, height: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildCard(context, item, itemWidth),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(
      BuildContext context, Map<String, String> item, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              item['image']!,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  item['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
