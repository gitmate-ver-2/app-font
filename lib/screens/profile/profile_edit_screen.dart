import 'package:flutter/material.dart';
import 'package:gitmate/screens/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final picker = ImagePicker();
  File? _image;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            _nicknameController.text =
                (userDoc.data() as Map<String, dynamic>)['nickname'] ?? '';
            _bioController.text =
                (userDoc.data() as Map<String, dynamic>)['bio'] ?? '';
            _emailController.text = user.email ?? '';
            _profileImageUrl =
                (userDoc.data() as Map<String, dynamic>)['profileImageUrl'];
          });
        }
      } catch (e) {
        print('Error loading user profile: $e');
        // 오류 발생 시 사용자에게 알림
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필 로딩 중 오류가 발생했습니다.')),
        );
      }
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _profileImageUrl = null;
      }
    });
  }

  Future<void> _saveProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String? imageUrl;

      if (_image != null) {
        Reference ref =
            FirebaseStorage.instance.ref().child('user_profiles/${user.uid}');
        UploadTask uploadTask = ref.putFile(_image!);
        TaskSnapshot taskSnapshot = await uploadTask;
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }

      Map<String, dynamic> updateData = {
        'nickname': _nicknameController.text,
        'bio': _bioController.text,
      };

      if (imageUrl != null) {
        updateData['profileImageUrl'] = imageUrl;
      }

      try {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(updateData, SetOptions(merge: true));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필이 업데이트되었습니다.')),
        );
        Navigator.pop(context);
      } catch (e) {
        print('Error saving profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필 저장 중 오류가 발생했습니다.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        title: "프로필 수정",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: _getImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : (_profileImageUrl != null
                            ? NetworkImage(_profileImageUrl!)
                            : null) as ImageProvider?,
                    child: (_image == null && _profileImageUrl == null)
                        ? Icon(Icons.person, size: 60)
                        : null,
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: '닉네임',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: '자기소개',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.description),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('저장하기'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
