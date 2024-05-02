import 'package:flutter/material.dart';
import 'package:bridge_gap/providers/gemini_provider.dart';
import 'package:language_picker/languages.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'tts_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SpeechProvider with ChangeNotifier {
  final SpeechToText _speech = SpeechToText();
  String _text = '';
  bool _isListening = false;
  bool languageNotSupported = false;
  final TtsProvider _ttsProvider = TtsProvider();
  final GeminiProvider _geminiProvider = GeminiProvider();
  Language _selectedDialogLanguage =  Languages.english; // Default English

  bool _loader = false;
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  String get text => _text;

  bool get isListening => _isListening;

  bool get loader => _loader;

  Language get language => _selectedDialogLanguage;

  Future<bool> _requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;

    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    return status.isGranted;
  }

  Future<bool> toggleListening() async {
    if (!_isListening) {
      bool microphoneGranted = await _requestMicrophonePermission();

      if (!microphoneGranted) {
        return false;
      }

      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'listening') {
            _isListening = true;
            notifyListeners();
          }
        },
        onError: (error) {
          print('Error: $error');
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              _text = result.recognizedWords;
              notifyListeners();
            }
          },
        );
      } else {
        print('The user has denied the use of speech recognition.');
        return false;
      }
    } else {
      _speech.stop();
      _isListening = false;
      _loader = true;
      _isSpeaking = true;
      languageNotSupported = false;
      notifyListeners();

      String? translatedText =
          await _geminiProvider.geminiTranslator(_text,_selectedDialogLanguage.name).whenComplete(() {
        _loader = false;
        notifyListeners();
      });
      if (translatedText != null) {
        await _ttsProvider.speak(translatedText,_selectedDialogLanguage.isoCode).whenComplete(() {
          _isSpeaking = false;
        });
      }
      if(translatedText == null){
        languageNotSupported = true;
        notifyListeners();
      }
      notifyListeners();
    }
    notifyListeners();
    return true;
  }

  void setLanguage(Language language) {
    _selectedDialogLanguage = language;
    notifyListeners(); // Notify listeners about the change
  }
}
