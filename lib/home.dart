
import 'package:christmas/snow.dart';
import 'package:christmas/warning.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class Happy_Christmas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Happy_ChristmasState();
}

class Happy_ChristmasState extends State<Happy_Christmas>
    with TickerProviderStateMixin {
  bool showGiftBox = false;
  bool showGiftBox2 = false;
  bool showButton1 = false;
  bool showButton2 = false;
  bool boomCele = false;
  bool boomCele1 = false;
  bool santa1 = true;
  bool santa2 = false;
  bool santaAnimation1 = true;
  bool Warning = false;
  bool houseVisible = true;
  bool houseVisible2 = false;
  bool _textVisible = false;
  bool _textVisible2 = false;

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _sizeAnimation;
  final double _end = 100;

  late AnimationController _houseAnimationController;
  late Animation<double> _houseSizeAnimation;

  late AnimationController _TextAnimationController;
  late Animation<double> _TextSizeAnimation;
  // Adjust the end position as needed


  void initState() {
    super.initState();

    // Duration for the animation
    const Duration duration = Duration(seconds: 3);

    // Create an animation controller
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    // Create a Tween that starts from 0 and ends at the screen width
    _animation = Tween<double>(
      begin: 400,
      end: _end,
    ).animate(_controller);

    // Start the animation
    _controller.forward();

    _sizeAnimation = Tween<double>(
      begin: 30,
      end: 70,
    ).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && _animation.value == 100) {
        setState(() {
          santaAnimation1 = false;
          houseVisible=false;
          houseVisible2 = true;
          _textVisible2 = true;
        });
      }
    });
    _houseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // You can adjust the duration as needed
    )..repeat(reverse: true);

    // Set up a size animation for the house
    _houseSizeAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_houseAnimationController);

    _TextAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _TextSizeAnimation = Tween<double>(
      begin: .9,
      end: 1,
    ).animate(_TextAnimationController);
  }

  @override
  void dispose() {
    // Dispose the animation controllers
    _controller.dispose();
    _houseAnimationController.dispose();
    _TextAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Image.asset('asset/christmasApp.png'),
            ),
            Visibility(
              visible: santa1,
              child: Positioned(
                top: 340,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation.value, 0),
                      child: Container(
                        width: _sizeAnimation.value,
                        height: _sizeAnimation.value,
                        child: Lottie.asset(
                          'asset/mainsanta.json',
                          repeat: santaAnimation1,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: houseVisible,
              child: Positioned(
                top: 320,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showButton1 = !showButton1;
                    });
                  },
                  child: Container(
                    width: 120,
                    child: Image.asset('asset/house.png'),
                  ),
                ),
              ),
            ),

            Visibility(
              visible: houseVisible2,
              child: Positioned(
                top: 320,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showButton1 = !showButton1;
                      houseVisible2 = false;
                      houseVisible = true;
                      _textVisible2 = false;
                    });
                  },
                  child: ScaleTransition(
                    scale: _houseSizeAnimation,
                    child: Container(
                      width: 120,
                      child: Image.asset('asset/house.png'),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 420,
              left: 260,
              child: GestureDetector(
                onTap: () {
                  // Handle onTap for the second house
                  setState(() {
                    showButton2 = !showButton2;
                  });
                },
                child: Container(
                  width: 150,
                  child: Image.asset('asset/house2.png'),
                ),
              ),
            ),
            Visibility(
              visible: showGiftBox,
              child: Positioned(
                top: 360,
                left: 80,
                child: GestureDetector(
                  onTap: () {
                    // Handle onTap for the gift box
                    setState(() {
                      showGiftBox = false;
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Image.asset('asset/gift.png'),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showButton1,
              child: Positioned(
                top: 420,
                left: 30,
                child: GestureDetector(
                  onTap: () {
                    // Handle onTap for the gift box
                    setState(() {
                      showButton1 = false;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showGiftBox = true;
                        showButton1 = false;
                        boomCele1 = true;
                        houseVisible2 = false;
                        houseVisible = true;
                        _textVisible = true;
                      });
                    },
                    child: Text(
                      'Gift Now',
                      style: GoogleFonts.adamina(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[800]),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showGiftBox2,
              child: Positioned(
                top: 470,
                right: 80,
                child: GestureDetector(
                  onTap: () {
                    // Handle onTap for the gift box
                    setState(() {
                      showGiftBox2 = false;
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Image.asset('asset/gift.png'),
                  ),
                ),
              ),
            ),
            // Visibility(
            //   visible: showButton2,
            //   child: Positioned(
            //     top: 520,
            //     right: 30,
            //     child: GestureDetector(
            //       onTap: () {
            //         // Handle onTap for the gift box
            //         setState(() {
            //           showButton2 = false;
            //         });
            //       },
            //       child: ElevatedButton(
            //           onPressed: (){
            //             setState(() {
            //               showGiftBox2 = true;
            //               showButton2 = false;
            //               boomCele = true;
            //             });
            //           },
            //           child: Text('Gift Now'),
            //       ),
            //     ),
            //   ),
            // ),
            Visibility(
                visible: boomCele,
                child: Positioned(
                    top: 450,
                    right: 60,
                    child: Lottie.asset(
                      'asset/boom.json',
                      width: 130,
                      repeat: false,
                    ))),
            Visibility(
                visible: boomCele1,
                child: Positioned(
                    top: 340,
                    left: 50,
                    child: Lottie.asset('asset/boom.json',
                      width: 130,
                      repeat: false,
                    ))),
            Visibility(
              visible: _textVisible,
              child: Positioned(
                bottom: 20,
                left: 45,
                child: GestureDetector(
                  child: AnimatedBuilder(
                    animation: _TextAnimationController,
                    builder: (context, child) {
                      return  ScaleTransition(
                        scale: _TextSizeAnimation,
                        child: Container(
                          padding: EdgeInsets.only(top: 105, left: 18),
                          width: 160,
                          height: 130,
                          color: Colors.transparent,
                          child: Text(
                            "Touch Here",
                            style: GoogleFonts.adamina(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[800],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    setState(() {
                      Warning = true;
                    });
                  },
                ),
              ),
            ),
            SnowyBackground(),
            Visibility(
              visible: _textVisible2,
              child: Positioned(
                top: 405,
                left: 30,
                child: AnimatedBuilder(
                  animation: _TextAnimationController,
                  builder: (context, child) {
                    return  ScaleTransition(
                      scale: _TextSizeAnimation,
                      child: Container(
                        color: Colors.transparent,
                        child: Text(
                          "Tap Here",
                          style: GoogleFonts.adamina(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),),
            Visibility(
              visible: Warning,
              child: WarningPopup(),
            ),
          ],
        ),
      ),
    );
  }
}
