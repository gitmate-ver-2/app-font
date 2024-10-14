import 'package:flutter/material.dart';
import 'package:gitmate/component/colors.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // 더미 행사 데이터 (카테고리 추가됨)
  final List<Map<String, String>> eventList = [
    {
      'title': 'HyperApp 2024',
      'description': 'KSDC(한국 학생 개발자 클럽)에서 주최하는 앱관련 개발자 컨퍼런스입니다.',
      'image': 'assets/images/event_images/event(1).png',
      'category': '개발자 컨퍼런스',
    },
    {
      'title': 'Devcon 2024',
      'description': 'K-Devcon에서 주최하는 개발자 컨퍼런스 입니다.',
      'image': 'assets/images/event_images/event(2).png',
      'category': '기술 컨퍼런스',
    },
    {
      'title': 'Future<Flutter> 2024',
      'description': 'Google Developer Group에서 주최하는 플러터 행사입니다.',
      'image': 'assets/images/event_images/event(3).jpg',
      'category': '플러터',
    },
    {
      'title': 'Google I/O Ex Incheon 2024',
      'description': 'Google Developer Group에서 주최하는 개발자 컨퍼런스 입니다.',
      'image': 'assets/images/event_images/event(4).gif',
      'category': '구글 이벤트',
    },
    {
      'title': '천안시 x 단국대 AI 로컬마케터 양성과정',
      'description': '천안시와 단국대에서 주최하는 AI 로컬마케터 양성과정입니다.',
      'image': 'assets/images/event_images/event(5).png',
      'category': 'AI 교육',
    },
    {
      'title': 'GopherCon Korea 2024',
      'description': '고커콘 코리아에서 주최하는 고언어 관련 행사입니다.',
      'image': 'assets/images/event_images/event(6).png',
      'category': '고언어',
    },
  ];

  // 검색어와 필터링된 이벤트 목록을 관리하는 변수
  String _searchQuery = '';
  List<Map<String, String>> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _filteredEvents = eventList; // 초기에는 모든 이벤트를 보여줌
  }

  // 새로고침 메서드
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        // 필요시 데이터를 갱신할 수 있습니다.
      });
    }
  }

  // 검색어 입력 시 호출되는 메서드
  void _filterEvents(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredEvents = eventList;
      } else {
        _filteredEvents = eventList.where((event) {
          final title = event['title']!.toLowerCase();
          final category = event['category']!.toLowerCase();
          final searchLower = _searchQuery.toLowerCase();
          return title.contains(searchLower) || category.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        title: '행사',
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('접근할 수 없습니다.')),
              );
            },
            icon: Icon(
              Icons.edit_calendar_outlined,
              color: AppColors.MAINCOLOR,
            ),
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
                      hintText: '제목 또는 카테고리 검색',
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
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    onChanged: _filterEvents, // 검색어 입력 시 호출
                    cursorColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.BACKGROUNDCOLOR,
        color: AppColors.MAINCOLOR,
        onRefresh: _refreshData,
        child: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _filteredEvents.length, // 필터링된 이벤트 개수만큼 보여줌
          itemBuilder: (context, index) {
            final event = _filteredEvents[index];
            return Card(
              color: AppColors.BACKGROUNDCOLOR,
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
                        // 카테고리 표시
                        Text(
                          '카테고리: ${event['category']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // 버튼들 (좋아요, 댓글)
                        Row(
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
      ),
    );
  }
}
