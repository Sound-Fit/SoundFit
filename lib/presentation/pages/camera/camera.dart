import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'displaypicture_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get the list of available cameras.
    _cameras = await availableCameras();

    if (_cameras.isNotEmpty) {
      // Initialize the camera controller with the selected camera.
      _controller = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.high,
      );

      // Initialize the controller and store it in a Future.
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    }
  }

  void _switchCamera() {
    if (_cameras.isNotEmpty) {
      setState(() {
        _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      });
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _capturePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      if (!mounted) return;

      // Save mirror pic if front camera
      if (_cameras[_selectedCameraIndex].lensDirection ==
          CameraLensDirection.front) {
        // Read image as bytes
        final imageBytes = await image.readAsBytes();
        final imageDecode = img.decodeImage(Uint8List.fromList(imageBytes));

        if (imageDecode != null) {
          // Flip image horizontally (mirror effect)
          final flippedImage = img.flipHorizontal(imageDecode);

          // Save flipped image to file
          final flippedFilePath = '${image.path}.jpg';
          final flippedFile = File(flippedFilePath)
            ..writeAsBytesSync(img.encodeJpg(flippedImage));

          // Push to next screen with the flipped image
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(
                imagePath: flippedFile.path,
              ),
            ),
          );
        }
      } else {
        // For back camera, use the original image path
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(
              imagePath: image.path,
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _uploadPicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null && mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            imagePath: pickedFile.path,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Fit My Playlist', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Camera Screen
            if (_initializeControllerFuture != null)
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    bool isFrontCamera =
                        _cameras[_selectedCameraIndex].lensDirection ==
                            CameraLensDirection.front;

                    double aspectRatio = _controller
                        .value.aspectRatio; // Aspect ratio from the controller

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.68,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: isFrontCamera
                                ? Matrix4.rotationY(
                                    3.14159) // Flip horizontally for front camera
                                : Matrix4
                                    .identity(), // No transform for back camera
                            child: AspectRatio(
                              aspectRatio:
                                  aspectRatio, // Ensures the correct aspect ratio
                              child: CameraPreview(_controller),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/face_overlay.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            else
              const Center(child: CircularProgressIndicator()),

            Gap(30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.flip_camera_android,
                    size: 40,
                    color: Colors.grey,
                  ),
                  onPressed: _switchCamera,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.circle,
                    size: 70,
                  ),
                  onPressed: _capturePicture,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 40,
                    color: Colors.grey,
                  ),
                  onPressed: _uploadPicture,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
