import 'package:flutter/material.dart';
import 'package:bridge_gap/language_translator/lt_screen.dart';
import 'package:bridge_gap/main_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bridge_gap/providers/gemini_provider.dart';
import 'package:bridge_gap/providers/image_picker_provider.dart';
import 'package:bridge_gap/providers/speech_provider.dart';
import 'package:bridge_gap/providers/tts_provider.dart';
import 'package:bridge_gap/vision_translator/vt_screen.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.microphone.request();
  runApp(const AiTranslator());
}

class AiTranslator extends StatelessWidget {
  const AiTranslator({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SpeechProvider()),
        ChangeNotifierProvider(create: (context) => TtsProvider()),
        ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
        ChangeNotifierProvider(create: (context) => GeminiProvider()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'BridgeGap',
              theme: ThemeData.dark(useMaterial3: true)
                  .copyWith(scaffoldBackgroundColor: Colors.black),
              initialRoute: '/',
              routes: {
                '/': (context) => const MainScreen(),
                '/second': (context) => const VoiceTranslation(),
                '/third': (context) => const VisionTranslation(),
              },
            );
          }),
    );
  }
}
