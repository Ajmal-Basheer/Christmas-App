import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MerryChristmas extends StatefulWidget {  @override
State<StatefulWidget> createState() => MerryChristmasState();
}
class MerryChristmasState extends State {
  final _audio = Audio('asset/christmas.mp3');
  final _audioplayer = AssetsAudioPlayer();
  @override
  void initState() {
    _audioplayer.open(_audio);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children :[
                  Container(
                    child: Lottie.asset('asset/santa.json',
                      width: 350,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}















