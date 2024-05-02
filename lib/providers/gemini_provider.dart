import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiProvider extends ChangeNotifier {
  String _visionOutputText = '';

  String get visionOutputText => _visionOutputText;

  /// language translation method
  Future<String?> geminiTranslator(String originalText, String lang) async {
    final model = GenerativeModel(
        model: 'gemini-pro', apiKey: "AIzaSyCZcwHhNaTrReoSGim2XXmj1TQcxh54I4I");

    var prompt = '$originalText Translate into $lang';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return response.text;
  }

  Future<String?> geminiVisionTranslator(String imagePath, String lang) async {
    final model = GenerativeModel(
        model: 'gemini-pro-vision',
        apiKey: "AIzaSyCZcwHhNaTrReoSGim2XXmj1TQcxh54I4I");

    var prompt = 'Translate image text into $lang';
    final imageBytes = await imagePathToUint8List(imagePath);

    final content = [
      Content.multi([
        TextPart(prompt),
        // The only accepted mime types are image/*.
        DataPart('image/jpeg', imageBytes),
      ])
    ];
    final response = await model.generateContent(content);
    if (response.text != null) {
      _visionOutputText = response.text!;
      notifyListeners();
    }
    notifyListeners();

    return response.text;
  }

  Future<Uint8List> imagePathToUint8List(String imagePath) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }
}
