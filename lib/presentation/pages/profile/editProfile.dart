import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isLoading = false;

  String? profilePath;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// Fungsi untuk mengambil data pengguna dari Firestore
  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final data = userDoc.data();
          setState(() {
            profilePath = data?['profile_path'];
            _nameController.text = data?['username'] ?? '';
            _emailController.text = data?['email'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  /// Fungsi untuk menyimpan perubahan ke Firestore dan kembali ke halaman Profile
  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'username': _nameController.text.trim(),
          'email': _emailController.text.trim(),
        });

        // Perbarui email pengguna jika berubah
        if (user.email != _emailController.text.trim()) {
          await user.updateEmail(_emailController.text.trim());
        }

        // Navigasi ke halaman Profile
        Navigator.pushReplacementNamed(context, '/profile');
      }
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> _uploadToFirebaseStorage(File imageFile) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final ref = FirebaseStorage.instance.ref().child(
            'profiles/${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Unggah file ke Firebase Storage
        final uploadTask = await ref.putFile(imageFile);

        // Dapatkan URL gambar
        return await uploadTask.ref.getDownloadURL();
      }
    } catch (e) {
      print('Failed to upload image to Firebase Storage: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
    return null;
  }

  Future<void> _savePathToFirestore(String imageUrl) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profile_path': imageUrl});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully')),
        );
      }
    } catch (e) {
      print('Error saving path to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save profile picture')),
      );
    }
  }

  Future<void> _uploadPicture() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        // Upload file ke Firebase Storage dan dapatkan URL-nya
        final imageUrl = await _uploadToFirebaseStorage(imageFile);

        if (imageUrl != null) {
          // Simpan URL ke Firestore
          await _savePathToFirestore(imageUrl);

          // Perbarui state untuk menampilkan gambar yang baru
          setState(() {
            profilePath = imageUrl;
          });
        }
      }
    } catch (e) {
      print('Error uploading picture: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: _saveProfile,
                child: Text(
                  'Save',
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile image and edit button
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: profilePath != null
                              ? NetworkImage(
                                  profilePath!) // Menggunakan URL dari Firebase Storage
                              : null,
                          backgroundColor: profilePath == null
                              ? Colors.grey[300]
                              : Colors.transparent,
                          child: profilePath == null
                              ? Icon(Icons.person, size: 50, color: Colors.grey)
                              : null,
                        ),
                      ),
                      Gap(16),
                      Center(
                        child: TextButton(
                          onPressed: _uploadPicture,
                          child: Text(
                            'Change Profile Picture',
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Name field
                      BasedText(
                        text: "Name",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                      Gap(16),

                      // Email field
                      BasedText(
                        text: "Email",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                      Gap(16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
