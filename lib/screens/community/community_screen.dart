import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gitmate/component/colors.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // 더미 데이터 리스트
  final List<Map<String, dynamic>> _posts = [
    {
      'profile': Icons.account_circle,
      'username': 'User1',
      'content': '첫 번째 게시물 내용입니다.',
      'images': [
        'assets/images/event_images/event(1).png',
        'assets/images/event_images/event(2).png',
        'assets/images/event_images/event(3).jpg',
      ],
      'comments': ['첫 번째 댓글', '두 번째 댓글', '세 번째 댓글'],
      'likes': 10,
      'saved': false,
    },
    {
      'profile': Icons.account_circle,
      'username': 'User2',
      'content': '두 번째 게시물 내용입니다.',
      'images': [
        'assets/images/event_images/event(2).png',
        'assets/images/event_images/event(3).jpg',
      ],
      'comments': ['첫 번째 댓글', '두 번째 댓글'],
      'likes': 20,
      'saved': true,
    },
    {
      'profile': Icons.account_circle,
      'username': 'User3',
      'content': '세 번째 게시물 내용입니다.',
      'images': [
        'assets/images/event_images/event(2).png',
        'assets/images/event_images/event(3).jpg',
      ],
      'comments': ['첫 번째 댓글', '두 번째 댓글'],
      'likes': 30,
      'saved': false,
    },
  ];

  final List<int> _currentSliderIndex = [];

  @override
  void initState() {
    super.initState();
    _posts.forEach((post) {
      _currentSliderIndex.add(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '커뮤니티',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('접근할 수 없습니다.')),
              );
            },
            icon: Icon(Icons.edit_document, color: AppColors.MAINCOLOR),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          final images = post['images'];
          final imageCount = images.length; // 이미지 개수 추출

          return Card(
            color: AppColors.BACKGROUNDCOLOR,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(post['profile'], size: 40),
                      const SizedBox(width: 10),
                      Text(
                        post['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          post['saved']
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                        ),
                        onPressed: () {
                          setState(() {
                            post['saved'] = !post['saved'];
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 이미지가 존재할 경우에만 CarouselSlider 표시
                  if (images != null && images.isNotEmpty)
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            onPageChanged: (pageIndex, reason) {
                              setState(() {
                                _currentSliderIndex[index] = pageIndex;
                              });
                            },
                          ),
                          items: images.map<Widget>((imagePath) {
                            return Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_currentSliderIndex[index] + 1} / $imageCount',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 10),
                  Text(post['content']),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          // 좋아요 버튼 누를 때의 동작
                        },
                      ),
                      Text('${post['likes']} likes'),
                      const SizedBox(width: 5),
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () {
                          // 댓글 버튼 누를 때의 동작
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // 댓글 2개만 표시
                  ...post['comments'].take(2).map((comment) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(comment),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
