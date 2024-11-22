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
        ResolutionPreset.medium,
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

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            imagePath: image.path,
          ),
        ),
      );
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
    double screenWidth = MediaQuery.of(context).size.width;

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
            // Camera Screen with zoom and mirroring applied
            if (_initializeControllerFuture != null)
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SizedBox(
                      height: screenHeight * 0.68,
                      width: screenWidth * 0.8, // Adjust width to match border
                      child: ClipRect(
                        child: Transform.scale(
                          scale: 1.1, // Apply zoom effect
                          child: _selectedCameraIndex == 0
                              // Apply mirroring for front camera (index 0)
                              ? Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(
                                      3.14159), // Mirror the image horizontally
                                  child: CameraPreview(_controller),
                                )
                              : CameraPreview(_controller),
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            else
              const Center(child: CircularProgressIndicator()),

            Gap(30),

            // Buttons for camera control
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
