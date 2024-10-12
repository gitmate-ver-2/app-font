import 'package:flutter/material.dart';
import 'package:gitmate/component/colors.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';
import 'package:gitmate/screens/widget/custom_floating_action_button.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // 더미 행사 데이터
  final List<Map<String, String>> eventList = [
    {
      'title': 'Flutter Workshop',
      'description': 'Learn the basics of Flutter and build your first app.',
      'image': 'assets/images/event_images/event(1).png',
    },
    {
      'title': 'Dart Conference',
      'description':
          'Join the Dart experts for a full-day conference on Dart programming.',
      'image': 'assets/images/event_images/event(2).png',
    },
    {
      'title': 'Tech Fest 2024',
      'description': 'Explore the latest in tech innovation at Tech Fest 2024.',
      'image': 'assets/images/event_images/event(3).jpg',
    },
    {
      'title': 'Startup Expo',
      'description':
          'Meet the top startups and entrepreneurs from across the globe.',
      'image': 'assets/images/event_images/event(4).gif',
    },
    {
      'title': 'AI Summit',
      'description':
          'Discover the future of AI technology with industry leaders.',
      'image': 'assets/images/event_images/event(5).png',
    },
    {
      'title': 'AI Summit',
      'description':
          'Discover the future of AI technology with industry leaders.',
      'image': 'assets/images/event_images/event(6).png',
    },
    {
      'title': 'AI Summit',
      'description':
          'Discover the future of AI technology with industry leaders.',
      'image': 'assets/images/event_images/event(7).png',
    },
    {
      'title': 'AI Summit',
      'description':
          'Discover the future of AI technology with industry leaders.',
      'image': 'assets/images/event_images/event(8).png',
    },
    {
      'title': 'AI Summit',
      'description':
          'Discover the future of AI technology with industry leaders.',
      'image': 'assets/images/event_images/event(9).png',
    },
    {
      'title': 'AI Summit',
      'description':
          'Discover the future of AI technology with industry leaders.',
      'image': 'assets/images/event_images/event(10).png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        title: '행사',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_calendar_outlined),
          ),
          const SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '검색',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), // 둥근 테두리
                        borderSide: const BorderSide(
                          color: Colors.grey, // 테두리 색상
                          width: 0.5, // 테두리 두께
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), // 둥근 테두리
                        borderSide: const BorderSide(
                          color: Colors.grey, // 테두리 색상 (포커스 시)
                          width: 1, // 포커스 시 테두리 두께
                        ),
                      ),
                    ),
                    // onChanged: (value) {
                    //   setState(() {
                    //     searchQuery = value;
                    //     filterCompanies();
                    //   });
                    // },
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              // 카테고리 필터
            ],
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: eventList.length,
        itemBuilder: (context, index) {
          final event = eventList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 행사 이미지
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.bookmark_outline),
                      color: Colors.blue,
                      onPressed: () {
                        // 저장 버튼 동작
                      },
                    ),
                  ],
                ),
                Image.asset(event['image']!),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 행사 제목
                      Text(
                        event['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // 행사 설명
                      Text(
                        event['description']!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      // 버튼들 (좋아요, 댓글, 저장)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up_alt_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              // 좋아요 버튼 동작
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.comment_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              // 댓글 버튼 동작
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
