import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bridge_gap/providers/gemini_provider.dart';
import 'package:bridge_gap/providers/image_picker_provider.dart';
import 'package:bridge_gap/utils/widgets/animted_typing_text.dart';
import 'package:language_picker/languages.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/speech_provider.dart';
import '../utils/widgets/dialogs_widgets.dart';

class VisionTranslation extends StatefulWidget {
  const VisionTranslation({super.key});

  @override
  State<StatefulWidget> createState() => VisionTranslationState();
}

class VisionTranslationState extends State<VisionTranslation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagePickerProvider>(context);

    return PopScope(
      onPopInvoked: (value) {
        imageProvider.profileImageUrlLocal = '';
        imageProvider.visionOutputText = '';
        imageProvider.setLanguage(Languages.english);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.black87,
          centerTitle: true,
          elevation: 0.0,
          title: const Text(
            'Vision Translator',
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Select output language",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 18.5.sp),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          openLanguagePickerDialog(context);
                        },
                        child: Container(
                          height: 40.h,
                          width: 110.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              "Select",
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        imageProvider.language.name,
                        style: TextStyle(
                            fontSize: 22.sp, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                imageProvider.profileImageUrlLocal != ''
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 300.h,
                          width: 1.sw,
                          child: Image.file(
                            File(imageProvider.profileImageUrlLocal),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          showImagePickerDialog(context);
                        },
                        child: Container(
                          height: 290.h,
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: const Color(0xff161617),
                              borderRadius: BorderRadius.circular(15.0),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Center(
                            child: Container(
                              height: 40.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  "Add Image",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                imageProvider.visionOutputText != ""
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: AnimatedTypingText(
                                text: imageProvider.visionOutputText!)),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
