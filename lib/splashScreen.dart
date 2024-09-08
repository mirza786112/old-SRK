import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_overlay/VideoPlayer.dart';
import 'provider/videoProvider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    playVideo();
  }

  playVideo() async {
    var provider=Provider.of<VideoProvider>(context,listen: false);
    Timer(Duration(seconds: 1), () async {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const VideoApp()), (route) => false);


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/SRKtv-logo.jpg'),
      ),
    );
  }
}
