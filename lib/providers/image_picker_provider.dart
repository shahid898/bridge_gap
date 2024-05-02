import 'package:flutter/cupertino.dart';
import 'package:bridge_gap/providers/gemini_provider.dart';
import 'package:bridge_gap/providers/speech_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:language_picker/languages.dart';

class ImagePickerProvider extends ChangeNotifier {
  final _picker = ImagePicker();
  String profileImageUrlLocal = ''; //
  Language _selectedDialogLanguage =  Languages.english; // Default English
  Language get language => _selectedDialogLanguage;
  final GeminiProvider _geminiProvider = GeminiProvider();
  String? visionOutputText = '';


  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImageUrlLocal = pickedFile.path;
      visionOutputText = await _geminiProvider.geminiVisionTranslator(profileImageUrlLocal, _selectedDialogLanguage.name);
      notifyListeners();
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImageUrlLocal = pickedFile.path;
      visionOutputText = await _geminiProvider.geminiVisionTranslator(profileImageUrlLocal, _selectedDialogLanguage.name);
      notifyListeners();
    }
  }
  void setLanguage(Language language) {
    _selectedDialogLanguage = language;
    notifyListeners(); // Notify listeners about the change
  }

}
