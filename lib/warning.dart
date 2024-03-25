import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:christmas/merrychristmas.dart';
import 'package:flutter/material.dart';

class WarningPopup extends StatefulWidget {
  @override
  _WarningPopupState createState() => _WarningPopupState();
}

class _WarningPopupState extends State<WarningPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  final _audio = Audio('asset/Warning.mp3');
  final _audioplayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioplayer.open(_audio);
    // Duration for the animation
    const Duration duration = Duration(milliseconds: 1000);

    // Create an animation controller
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    // Create a scale animation
    _scaleAnimation = Tween<double>(
      begin: 1.0, // Initial scale
      end: 1.2, // Final scale
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Create an opacity animation for blinking
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.3),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.3, end: 1.0),
        weight: 1,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _controller.repeat(reverse: true);

    // Auto-dismiss the popup after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        _controller.stop();
        _audioplayer.stop();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MerryChristmas()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background with BackdropFilter for blur effect
        Container(
          color: Colors.black45,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        // AlertDialog with warning content
        AlertDialog(
          content: Container(
            alignment: Alignment.center,
            height: 170,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow:[ BoxShadow(
                )
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16),
                Container(
                  child: AnimatedBuilder(
                    animation: _opacityAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacityAnimation.value,
                        child: AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Icon(
                                Icons.warning,
                                size: 60,
                                color: Colors.red,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: Text(
                        'Warning!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.all(16.0),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void showWarningPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return WarningPopup();
    },
  );
}
