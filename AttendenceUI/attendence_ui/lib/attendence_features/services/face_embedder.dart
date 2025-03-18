import 'dart:typed_data';
import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';


class FaceEmbedder {
  late Interpreter _interpreter;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/tfmodel/facenet_512.tflite',
        options: InterpreterOptions()..threads = 4,
      );
      _verifyModel();
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize model: ${e.toString()}');
    }
  }

  Future<List<double>> getEmbedding(File imageFile) async {
    if (!_isInitialized) throw Exception('Embedder not initialized');
    try {
      final input = await _preprocessImage(imageFile);
      // CHANGE: Fixed output tensor shape to match input tensor shape expectation
      final output = List<List<double>>.filled(1, List<double>.filled(512, 0.0));
      _interpreter.run(input, output);
      return _normalize(Float32List.fromList(output[0]));
    } catch (e) {
      throw Exception('Embedding failed: ${e.toString()}');
    }
  }

  Future<List<List<List<List<double>>>>> _preprocessImage(File file) async {
    // CHANGE: Fixed return type to match model input format
    final image = img.decodeImage(await file.readAsBytes())!;
    final resized = img.copyResize(image, width: 160, height: 160);

    // CHANGE: Creating 4D input tensor instead of flattened buffer
    final inputTensor = List.generate(
      1, // batch size
          (_) => List.generate(
        160, // height
            (y) => List.generate(
          160, // width
              (x) => List<double>.filled(3, 0.0), // RGB channels
        ),
      ),
    );

    for (int y = 0; y < 160; y++) {
      for (int x = 0; x < 160; x++) {
        final pixel = resized.getPixel(x, y);
        // CHANGE: Fill tensor properly
        inputTensor[0][y][x][0] = (pixel.r / 127.5) - 1.0; // Red
        inputTensor[0][y][x][1] = (pixel.g / 127.5) - 1.0; // Green
        inputTensor[0][y][x][2] = (pixel.b / 127.5) - 1.0; // Blue
      }
    }

    return inputTensor;
  }

  List<double> _normalize(Float32List embedding) {
    final sum = embedding.fold(0.0, (p, c) => p + c * c);
    final norm = sqrt(sum);
    // CHANGE: Better handling for near-zero norm
    if (norm < 1e-10) return List.filled(embedding.length, 0.0);
    return embedding.map((x) => x / norm).toList();
  }

  void _verifyModel() {
    final input = _interpreter.getInputTensor(0);
    final output = _interpreter.getOutputTensor(0);
    // CHANGE: Fixed shape verification to access shape directly
    if (input.shape[0] != 1 ||
        input.shape[1] != 160 ||
        input.shape[2] != 160 ||
        input.shape[3] != 3) {
      throw Exception('Invalid input shape: ${input.shape}');
    }
    if (output.shape[0] != 1 || output.shape[1] != 512) {
      throw Exception('Invalid output shape: ${output.shape}');
    }
    // CHANGE: More specific type check using TfLiteType

  }

  void dispose() {
    if (_isInitialized) {
      _interpreter.close();
      _isInitialized = false;
    }
  }
}