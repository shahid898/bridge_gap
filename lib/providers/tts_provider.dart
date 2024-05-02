import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsProvider with ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  get flutterTts => _flutterTts;

  Future<void> speak(String text,String language) async {
    _isSpeaking = true;
    notifyListeners();
    await _flutterTts.setLanguage(language);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
  }
}
