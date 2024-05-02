import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bridge_gap/utils/widgets/module_card_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BridgeGap",
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Column(
            children: [
              ModuleCardWidget(
                title: "Voice Translator",
                image: "assets/images/waveform.png",
                onTap: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
              ModuleCardWidget(
                title: "Vision Translator",
                image: "assets/images/vision5.png",
                onTap: () {
                  Navigator.pushNamed(context, '/third');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
