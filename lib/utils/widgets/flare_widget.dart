import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../language_translator/lt_screen.dart';

class FlareWidget extends StatelessWidget {
  const FlareWidget({super.key, required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: FlareActor(
          'assets/flare/${item.name}.flr',
          alignment: Alignment.bottomCenter,
          fit: BoxFit.contain,
          animation: item.animation,
        ),
      ),
    );
  }
}
