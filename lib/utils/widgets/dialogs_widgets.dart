import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bridge_gap/providers/image_picker_provider.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';
import 'package:provider/provider.dart';

import 'custom_button.dart';

Future<void> showImagePickerDialog(BuildContext context) async {
  final imagePickerProvider =
      Provider.of<ImagePickerProvider>(context, listen: false);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Image Source', style: TextStyle(fontSize: 16.sp)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              onPressed: () {
                imagePickerProvider.pickImageFromGallery();
                Navigator.of(context).pop();
              },
              text: 'Gallery',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () {
                imagePickerProvider.pickImageFromCamera();
                Navigator.of(context).pop();
              },
              text: 'Camera',
            ),
          ],
        ),
      );
    },
  );
}

void openLanguagePickerDialog(context) => showDialog(
      context: context,
      builder: (context) => Theme(
          data: Theme.of(context).copyWith(
              dialogBackgroundColor: const Color(0xff161617),
              primaryColor: Colors.pink),
          child: LanguagePickerDialog(
              titlePadding: const EdgeInsets.all(8.0),
              searchCursorColor: Colors.deepPurple,
              searchInputDecoration:
                  const InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: Text(
                'Select your language',
                style: TextStyle(fontSize: 20.sp),
              ),
              onValuePicked: (Language language) {
                Provider.of<ImagePickerProvider>(context, listen: false)
                    .setLanguage(language); // Update state using Provider
                print(language.name);
                print(language.isoCode);
              },
              itemBuilder: _buildDialogItem)),
    );
// It's sample code of Dialog Item.
Widget _buildDialogItem(Language language) => Row(
      children: <Widget>[
        Text(language.name),
        const SizedBox(width: 8.0),
        Flexible(child: Text("(${language.isoCode})"))
      ],
    );
