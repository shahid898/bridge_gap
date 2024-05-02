import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedTypingText extends StatefulWidget {
  final String text;

  const AnimatedTypingText({required this.text});

  @override
  _AnimatedTypingTextState createState() => _AnimatedTypingTextState();
}

class _AnimatedTypingTextState extends State<AnimatedTypingText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation =
        IntTween(begin: 0, end: widget.text.length).animate(_controller);

    // Start animation when text changes
    if (widget.text.isNotEmpty) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedTypingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Start animation when text changes
    if (widget.text.isNotEmpty) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Get the portion of text to display based on the current animation value
        String displayedText = widget.text.substring(0, _animation.value);
        return Text(
          displayedText,
          style: TextStyle(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              height: 2),
          textAlign: TextAlign.left,
        );
      },
    );
  }
}
