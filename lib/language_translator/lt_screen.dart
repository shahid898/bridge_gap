import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';
import 'package:provider/provider.dart';

import '../providers/speech_provider.dart';
import '../providers/tts_provider.dart';
import '../utils/widgets/flare_widget.dart';

class MenuItem {
  final String name;
  final String animation;

  MenuItem(this.name, this.animation);
}

class VoiceTranslation extends StatefulWidget {
  const VoiceTranslation({super.key});

  @override
  State<StatefulWidget> createState() => _VoiceTranslationState();
}

class _VoiceTranslationState extends State<VoiceTranslation> {
  bool isListening = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final speechProvider = Provider.of<SpeechProvider>(context);
    final ttsProvider = Provider.of<TtsProvider>(context);

    return PopScope(
      onPopInvoked: (value) {
        ttsProvider.flutterTts.stop();
        speechProvider.setLanguage(Languages.english);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.black87,
          centerTitle: true,
          elevation: 0.0,
          title: const Text(
            'Voice Translator',
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions:[ GestureDetector(
            onTap: (){
              ttsProvider.flutterTts.stop();

            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.stop_circle_outlined,size: 40,color: Colors.white),
            ),
          ),]
        ),
        body: speechProvider.loader
            ? Center(child: FlareWidget(item: MenuItem('Loader', 'Untitled')))
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                speechProvider.languageNotSupported = false;

                                _openLanguagePickerDialog(context);
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
                              speechProvider.language.name,
                              style: TextStyle(
                                  fontSize: 22.sp, color: Colors.deepPurple),
                            ),
                          ],
                        ),
                      ),
                      speechProvider.isListening
                          // ? FlareWidget(item: MenuItem('Loader', 'Untitled'))
                          ? FlareWidget(
                              item: MenuItem('voice_input', 'analysis'))
                          : FlareWidget(
                              item: MenuItem('recording', 'analysis')),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: speechProvider.isListening
                                      ? Colors.redAccent
                                      : const Color(0xff161617),
                                ),
                                child: IconButton(
                                  icon: speechProvider.isListening
                                      ? const Icon(
                                          Icons.pause,
                                          color: Colors.black,
                                          size: 30.0,
                                        )
                                      : const Icon(
                                          Icons.mic,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                  onPressed: () async {
                                    bool success =
                                        await speechProvider.toggleListening();

                                    if (!success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Microphone permission is required for speech recognition.')),
                                      );
                                    }
                                    if (speechProvider.languageNotSupported) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Sorry the selected language not supported yet.')),
                                      );
                                    }
                                  },
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

void _openLanguagePickerDialog(context) => showDialog(
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
                Provider.of<SpeechProvider>(context, listen: false)
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
