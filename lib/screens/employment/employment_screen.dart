// lib/screens/employment/employment_screen.dart

import 'package:flutter/material.dart';
import 'package:gitmate/screens/widget/company_card.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gitmate/component/colors.dart';
import 'package:gitmate/models/company_info.dart';

class EmploymentScreen extends StatefulWidget {
  const EmploymentScreen({super.key});

  @override
  State<EmploymentScreen> createState() => _EmploymentScreenState();
}

class _EmploymentScreenState extends State<EmploymentScreen> {
  List<CompanyInfo> companies = [];
  List<CompanyInfo> filteredCompanies = [];
  bool isLoading = true;
  String selectedCategory = 'All';
  String searchQuery = '';
  List<String> categories = ['All'];

  @override
  void initState() {
    super.initState();
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    final String? awsUrl = dotenv.env['AWS_URL'];
    if (awsUrl == null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('AWS URL is not set in .env file')),
      );
      return;
    }

    try {
      final response = await http.get(Uri.parse('$awsUrl/company_info'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          companies =
              jsonData.map((json) => CompanyInfo.fromJson(json)).toList();
          filteredCompanies = companies;
          categories = [
            'All',
            ...{...companies.map((c) => c.industry)}
          ];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load companies')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void filterCompanies() {
    setState(() {
      filteredCompanies = companies.where((company) {
        final matchesCategory =
            selectedCategory == 'All' || company.industry == selectedCategory;
        final matchesSearch = company.companyName
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            company.industry.toLowerCase().contains(searchQuery.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

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
        backgroundColor: AppColors.BACKGROUNDCOLOR,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: '채용',
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
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
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        filterCompanies();
                      });
                    },
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              // 카테고리 필터
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        selectedColor: AppColors.MAINCOLOR.withOpacity(0.9),
                        backgroundColor: Colors.grey.shade100,
                        labelStyle: TextStyle(
                          color: selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category;
                            filterCompanies();
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredCompanies.isEmpty
              ? const Center(
                  child: Text(
                    'No companies found.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : RefreshIndicator(
                  backgroundColor: AppColors.BACKGROUNDCOLOR,
                  color: AppColors.MAINCOLOR,
                  onRefresh: _refreshData,
                  child: ListView.builder(
                    itemCount: filteredCompanies.length,
                    itemBuilder: (context, index) {
                      final company = filteredCompanies[index];
                      return CompanyCard(
                        company: company,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${company.companyName}')),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
