import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';

class FaceDetectionScreen extends StatefulWidget {
  const FaceDetectionScreen({Key? key}) : super(key: key);

  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  List<Face> _faces = [];
  late CameraController _controller;
  late FaceDetector _faceDetector;
  bool _isValidFace = false;
  bool _isProcessing = false;
  bool _isCameraInitialized = false;
  bool _isCapturing = false;

  // Initialize validation rectangle with a default value
  double _validationSize = 512;
  late double _validationwidthSize;
  late double _validationheightSize;
  double sx = 0, sy = 0;

  // Fix: Initialize _validationRect with a default value to avoid late initialization error
  Rect _validationRect = Rect.zero;

  @override
  void initState() {
    super.initState();

    _requestCameraPermission();
  }

  @override
  void dispose() {
    if (_controller.value.isInitialized) {
      _controller.stopImageStream();
    }
    _faceDetector.close();
    _controller.dispose();
    super.dispose();
  }

  void _initializeDetector() {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableContours: true,
        enableLandmarks: true,
        enableClassification: true,
        enableTracking: true,
        minFaceSize: 0.7,
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  Future<void> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;

    if (status.isDenied) {
      // showToast("We need camera access for face detection.");
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      // showToast("Camera permission granted.");
      _initializeCamera();
    } else if (status.isPermanentlyDenied) {
      showToast("Camera permission permanently denied. Opening settings...");
      await openAppSettings();
    } else {
      showToast("Camera permission denied.");
    }
  }


  Future<void> _initializeCamera() async {
    try {


      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(frontCamera, ResolutionPreset.ultraHigh);

      await _controller.initialize();
      if (!mounted) return;

      _initializeDetector();

      setState(() {
        _isCameraInitialized = true;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _calculateValidationRect();
        _controller.startImageStream(_processCameraImage);
      });
    } catch (e) {
      debugPrint("Error initializing camera: $e");
    }
  }

  void _calculateValidationRect() {
    if (!mounted || !_isCameraInitialized) return;

    final previewSize = _controller.value.previewSize;
    if (previewSize == null) return;

    // Get the actual preview size
    double previewWidth = previewSize.height;
    double previewHeight = previewSize.width;

    // Get the screen dimensions
    final screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    // Calculate scaling factors
    double scaleX = screenWidth / previewWidth;
    double scaleY = screenHeight / previewHeight;
    sx = scaleX;
    sy = scaleY;
    // Set validation rectangle dynamically
    _validationwidthSize = previewWidth * 0.7 * scaleX;
    _validationheightSize = previewHeight * 0.4 * scaleY;

    // Update the validation rectangle
    setState(() {
      _validationRect = Rect.fromCenter(
        center: Offset(screenWidth / 2, screenHeight / 2),
        width: _validationwidthSize,
        height: _validationheightSize,
      );
    });

    debugPrint('Preview Width: $previewWidth, Preview Height: $previewHeight');
    debugPrint('Screen Width: $screenWidth, Screen Height: $screenHeight');
    debugPrint('Validation Rect: $_validationRect');
    debugPrint(
      'widthXheight:${MediaQuery.sizeOf(context).width}X${MediaQuery.sizeOf(context).height}',
    );
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isProcessing || !_controller.value.isInitialized || !mounted) return;
    print('cameraImage:$image');
    setState(() {
      _isProcessing = true;
    });

    try {
      final inputImage = _getInputImage(image);
      print("inputImage : $inputImage");

      final faces = await _faceDetector.processImage(inputImage);
      print("faces : $faces");
      if (!mounted) return;
      setState(() {
        _faces = faces;
      });

      if (faces.isNotEmpty) {
        print("found face");
        _validateFace(faces.first);
      } else {
        setState(() => _isValidFace = false);
      }
    } catch (e) {
      debugPrint("Face detection error: $e");
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  InputImage _getInputImage(CameraImage image) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    // print("image : ${image.format.group}");
    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: _rotationFromCamera(),
        format: _getInputImageFormat(image.format.group),
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );
  }

  /// Determines the correct InputImageFormat based on platform and camera image format.
  InputImageFormat _getInputImageFormat(ImageFormatGroup formatGroup) {
    if (Platform.isAndroid) {
      return InputImageFormat.nv21;
    } else if (Platform.isIOS) {
      return InputImageFormat.bgra8888;
    } else {
      throw Exception("Unsupported platform");
    }
  }

  InputImageRotation _rotationFromCamera() {
    // For front camera, we need to adjust the rotation
    final sensorOrientation = _controller.description.sensorOrientation;
    final isFrontCamera =
        _controller.description.lensDirection == CameraLensDirection.front;

    // Adjust rotation based on camera direction and sensor orientation
    switch (sensorOrientation) {
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  void _validateFace(Face face) {
    if (!mounted) return;

    // Get the face bounding box
    final faceRect = face.boundingBox;

    // Check if the face bounding box is within the validation rectangle
    final isFaceInside = _validationRect.overlaps(faceRect);
    print("isFaceInside : $isFaceInside");

    // Check face orientation
    final isFrontal =
        (face.headEulerAngleY?.abs() ?? 90) < 20 &&
        (face.headEulerAngleX?.abs() ?? 90) < 20;

    print("isFrontal : $isFrontal");

    // Check if eyes are open
    final eyesOpen =
        (face.leftEyeOpenProbability ?? 0) > 0.2 &&
        (face.rightEyeOpenProbability ?? 0) > 0.2;
    print("eyesOpen : $eyesOpen");

    setState(() {
      _isValidFace = isFaceInside && isFrontal && eyesOpen;
    });

    if (_isValidFace && !_isCapturing) {
      // Wait for face to be stable before capturing
      Future.delayed(const Duration(seconds: 2), _captureValidImage);
    }
  }

  Future<void> _captureValidImage() async {
    if (!_isValidFace || !_isCameraInitialized || _isCapturing || !mounted) {
      return;
    }

    setState(() {
      _isCapturing = true;
    });

    try {
      // Stop the image stream before taking picture
      await _controller.stopImageStream();

      // Small delay to ensure the stream is stopped
      await Future.delayed(const Duration(milliseconds: 200));

      // Take the picture
      final image = await _controller.takePicture();

      // Process the image
      final croppedFace = await cropFace(File(image.path));

      // Return the result
      if (mounted) {
        Navigator.pop(context, croppedFace);
      }
    } catch (e) {
      debugPrint("Error capturing image: $e");

      // Restart the stream if an error occurs
      if (mounted && _controller.value.isInitialized) {
        _controller.startImageStream(_processCameraImage);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCapturing = false;
        });
      }
    }
  }

  Future<File?> cropFace(File imgFile) async {
    try {
      final inputImage = InputImage.fromFile(imgFile);
      final faceDetector = GoogleMlKit.vision.faceDetector(
        FaceDetectorOptions(
          enableContours: true,
          enableClassification: true,
          enableLandmarks: true,
          enableTracking: true,
          minFaceSize: 0.25,
          performanceMode: FaceDetectorMode.accurate,
        ),
      );

      final faces = await faceDetector.processImage(inputImage);
      await faceDetector.close();

      if (faces.isEmpty) {
        return null;
      }

      // Load image into a processable format
      final imageBytes = await imgFile.readAsBytes();
      final image = img.decodeImage(imageBytes);
      if (image == null) {
        return null;
      }

      // Get first detected face bounds
      final face = faces.first;
      final rect = face.boundingBox;

      if (rect.width <= 0 || rect.height <= 0) {
        return null;
      }

      // Add padding to the face rectangle (20% of face size)
      final padding = rect.width * 0.2;
      final expandedRect = Rect.fromLTRB(
        rect.left - padding,
        rect.top - padding,
        rect.right + padding,
        rect.bottom + padding,
      );

      // Ensure cropping dimensions do not exceed image size
      int x = expandedRect.left.toInt().clamp(0, image.width - 1);
      int y = expandedRect.top.toInt().clamp(0, image.height - 1);
      int width = expandedRect.width.toInt().clamp(1, image.width - x);
      int height = expandedRect.height.toInt().clamp(1, image.height - y);

      // Crop the face
      final croppedFace = img.copyCrop(
        image,
        x: x,
        y: y,
        width: width,
        height: height,
      );

      // Resize to 160x160 for compatibility with FaceEmbedder
      final resizedFace = img.copyResize(croppedFace, width: 160, height: 160);

      // Convert back to File
      final croppedFile = File(imgFile.path.replaceFirst('.jpg', '_face.jpg'));
      await croppedFile.writeAsBytes(img.encodeJpg(resizedFace));

      return croppedFile;
    } catch (e) {
      debugPrint("Error cropping face: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isCameraInitialized
              ? Stack(
                children: [
                  Positioned.fill(
                    child: RotatedBox(
                      quarterTurns: 4, // Rotate camera
                      child: SizedBox.expand(child: CameraPreview(_controller)),
                    ),
                  ),
                  ..._faces.map((face) {
                    final rect = face.boundingBox;
                    return Positioned(
                      left: rect.left - 20,
                      top: rect.top - 100,
                      child: DottedBorder(
                        color: Color(0xFF00FB46),
                        borderType: BorderType.Oval,
                        strokeWidth: 7.w,
                        dashPattern: [5, 3],
                        child: Container(
                          width: rect.width * 0.7 * sx, // Set explicit width
                          height: rect.height * 0.9 * sy, // Set explicit height
                        ),
                      ),
                    );
                  }).toList(),
                  // Add validation rectangle
                  Center(
                    child: Container(
                      width: _validationRect.width,
                      height: _validationRect.height,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              _isValidFace
                                  ? Colors.transparent
                                  : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  _buildInstructions(),
                  // Add back button
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              )
              : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildInstructions() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Text(
            _isValidFace ? "Hold still..." : "Keep your face in center",
            style: TextStyle(
              color: _isValidFace ? Colors.green : Colors.white,
              fontSize: 20,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _isValidFace
              ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              )
              : const Icon(Icons.face, size: 60, color: Colors.white),
        ],
      ),
    );
  }
}
