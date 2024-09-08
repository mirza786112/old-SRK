// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:screen_brightness/screen_brightness.dart';
// // import 'package:screen_brightness/screen_brightness.dart';
// import 'package:video_player/video_player.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
//
// class VideoProvider with ChangeNotifier {
//   late VideoPlayerController controller;
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   List<String> path = [
//     'assets/svg/bangla-toons.svg',
//     'assets/svg/janab-rani.svg',
//     'assets/svg/jara-abir.svg',
//     'assets/svg/jol-pori.svg',
//     'assets/svg/pori.svg',
//     'assets/svg/suleman.svg',
//     'assets/svg/sura.svg'
//   ];
//
//   // focuses
//   FocusNode sliderFocus=FocusNode();
//   FocusNode shareFocus=FocusNode();
//   FocusNode menuFocus=FocusNode();
//   FocusNode volumeFocus=FocusNode();
//   FocusNode closeFocus=FocusNode();
//
//
//
//   bool videoPlayError = false;
//   String? errorDescription;
//
//   bool showOverlay = true;
//   bool isMute = false;
//   bool isPip = false;
//   Timer? timer;
//
//   String? playedUrlImagePath;
//   String firstUrl='https://cdn.ncare.live/flixhls/flixsrktv.stream/chunks.m3u8';
//
//   double brightness = 30;
//
//   static const platform = MethodChannel('pip.channel');
//
//   VideoProvider() {
//     // setBrightness(30);
//     onVideoPlay();
//     hideStatusBarTemporarily();
//     initializeVideoPlayer('https://cdn.ncare.live/flixhls/flixsrktv.stream/chunks.m3u8',true,'');
//     // initializeVideoPlayer('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', false);
//   }
//
//   void onVideoPlay() {
//     errorDescription = null;
//     videoPlayError = false;
//     notifyListeners();
//   }
//
//   Future<void> initializeVideoPlayer(String url, bool second,String imagePath) async {
//     try {
//       onVideoPlay();
// print(url.toString());
//       playedUrlImagePath=imagePath;
//       notifyListeners();
//       controller = VideoPlayerController.network(url)
//         ..initialize().then((_) {
//           if(isMute){
//             controller.setVolume(0.0);
//           }
//           onVideoPlay();
//           controller.play();
//           _startListeners(second);
//           toggleOverlay();
//           WakelockPlus.enable();
//           notifyListeners();
//         }).catchError((error) {
//           videoPlayError = true;
//           notifyListeners();
//           _handleVideoError(second);
//         })
//         ..setLooping(true);
//       controller.addListener(() {
//         if (controller.value.position == controller.value.duration) {
//           controller.seekTo(Duration.zero);
//           controller.play();
//         }
//         notifyListeners();
//       });
//
//       controller.addListener(() {
//         if (controller.value.isPlaying) {
//           WakelockPlus.enable();
//         } else {
//           WakelockPlus.disable();
//         }
//         notifyListeners();
//       });
//     } catch (e) {
//       print('Error initializing video player: $e');
//       // Handle error as needed
//     }
//   }
//
//   void pauseVideo() {
//     controller.pause();
//     notifyListeners();
//   }
//
//   void _startListeners(bool second) {
//     controller.addListener(() {
//       if (controller.value.hasError) {
//         _handleVideoError(second);
//       }
//     });
//     notifyListeners();
//   }
//
//   void _handleVideoError(bool second) {
//     if (!second) {
//       print('Trying second URL');
//       // Fluttertoast.showToast(msg: controller.value.errorDescription?.split(':').last.toString() ?? 'Unknown error');
//       // initializeVideoPlayer('https://cdn.ncare.live/flixhls/flixsrktv.stream/chunks.m3u8', true);
//     } else {
//
//       if(!controller.value.isInitialized){
//         errorDescription = controller.value.errorDescription?.split(':').last ??
//             'Unknown error';
//         print('Video player error: $errorDescription');
//         // Fluttertoast.showToast(
//         //     msg:
//         //         controller.value.errorDescription?.split(':').last.toString() ??
//         //             'Unknown error');
//         videoPlayError = true;
//       }
//       notifyListeners();
//     }
//   }
//
//
//   toggleTv(){
//     showOverlay=true;
//     timer?.cancel();
//     timer = Timer(const Duration(seconds: 7), () {
//       if (showOverlay) {
//         showOverlay = false;
//       }
//       notifyListeners();
//     });
//     notifyListeners();
//   }
//
//   void toggleOverlay() {
//
//     showOverlay = !showOverlay;
//
//
//     // for hiding status bar
//     // if (!showOverlay) {
//     //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     // } else {
//     //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     // }
//     // for hiding controls
//     if (showOverlay) {
//       timer?.cancel();
//       timer = Timer(const Duration(seconds: 7), () {
//         if (showOverlay) {
//           showOverlay = false;
//         }
//         notifyListeners();
//       });
//     }
//     notifyListeners();
//   }
//
//   Future<void> isMuteCheck(BuildContext context) async {
//     await checkAndCloseDrawer(context);
//     controller.setVolume(isMute ? 100.0 : 0.0);
//     isMute = !isMute;
//     notifyListeners();
//   }
//
//   Future<void> checkAndCloseDrawer(BuildContext context) async {
//     if (scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
//       Navigator.of(context).pop(); // Close the drawer
//     }
//   }
//
//   Future<void> enterPiPMode() async {
//     try {
//       showOverlay = false;
//       await platform.invokeMethod('enterPiPMode');
//     } on PlatformException catch (e) {
//       print("Failed to enter PiP mode: ${e.message}");
//     }
//     notifyListeners();
//   }
//
//   void playVideo() {
//     controller.play();
//     notifyListeners();
//   }
//
//   Future<void> setBrightness(double brightness) async {
//     try {
//       await ScreenBrightness.instance.setScreenBrightness(brightness / 100);
//     } catch (e) {
//       print('Failed to set brightness: $e');
//     }
//   }
//
//   void hideStatusBarTemporarily() {
//     Timer.periodic((const Duration(seconds: 3)), (timer) {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     });
//   }
// }

















import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class VideoProvider with ChangeNotifier {
  late VideoPlayerController controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> path = [
    'assets/svg/bangla-toons.svg',
    'assets/svg/janab-rani.svg',
    'assets/svg/jara-abir.svg',
    'assets/svg/jol-pori.svg',
    'assets/svg/pori.svg',
    'assets/svg/suleman.svg',
    'assets/svg/sura.svg'
  ];

  // focuses
  FocusNode sliderFocus=FocusNode();
  FocusNode shareFocus=FocusNode();
  FocusNode menuFocus=FocusNode();
  FocusNode volumeFocus=FocusNode();
  FocusNode closeFocus=FocusNode();



  bool videoPlayError = false;
  String? errorDescription;

  bool showOverlay = true;
  bool isMute = false;
  bool isPip = false;
  Timer? timer;

  String? playedUrlImagePath;
  String firstUrl='https://cdn.ncare.live/flixhls/flixsrktv.stream/chunks.m3u8';

  double brightness = 30;

  static const platform = MethodChannel('pip.channel');

  VideoProvider() {
    setBrightness(30);
    onVideoPlay();
    hideStatusBarTemporarily();
    initializeVideoPlayer('https://cdn.ncare.live/flixhls/flixsrktv.stream/chunks.m3u8',true,'');
    // initializeVideoPlayer('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', false);
  }

  void onVideoPlay() {
    errorDescription = null;
    videoPlayError = false;
    notifyListeners();
  }

  Future<void> initializeVideoPlayer(String url, bool second,String imagePath) async {
    try {
      onVideoPlay();

      playedUrlImagePath=imagePath;
      notifyListeners();
      controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          if(isMute){
            controller.setVolume(0.0);
          }
          onVideoPlay();
          controller.play();
          _startListeners(second);
          toggleOverlay();
          WakelockPlus.enable();
          notifyListeners();
        }).catchError((error) {
          videoPlayError = true;
          notifyListeners();
          _handleVideoError(second);
        })
        ..setLooping(true);
      controller.addListener(() {
        if (controller.value.position == controller.value.duration) {
          controller.seekTo(Duration.zero);
          controller.play();
        }
        notifyListeners();
      });

      controller.addListener(() {
        if (controller.value.isPlaying) {
          WakelockPlus.enable();
        } else {
          WakelockPlus.disable();
        }
        notifyListeners();
      });
    } catch (e) {
      print('Error initializing video player: $e');
      // Handle error as needed
    }
  }

  void pauseVideo() {
    controller.pause();
    notifyListeners();
  }

  void _startListeners(bool second) {
    controller.addListener(() {
      if (controller.value.hasError) {
        _handleVideoError(second);
      }
    });
    notifyListeners();
  }

  void _handleVideoError(bool second) {
    if (!second) {
      print('Trying second URL');
      // Fluttertoast.showToast(msg: controller.value.errorDescription?.split(':').last.toString() ?? 'Unknown error');
      // initializeVideoPlayer('https://cdn.ncare.live/flixhls/flixsrktv.stream/chunks.m3u8', true);
    } else {

      if(!controller.value.isInitialized){
        errorDescription = controller.value.errorDescription?.split(':').last ??
            'Unknown error';
        print('Video player error: $errorDescription');
        // Fluttertoast.showToast(
        //     msg:
        //         controller.value.errorDescription?.split(':').last.toString() ??
        //             'Unknown error');
        videoPlayError = true;
      }
      notifyListeners();
    }
  }


  toggleTv(){
    showOverlay=true;
    timer?.cancel();
    timer = Timer(const Duration(seconds: 7), () {
      if (showOverlay) {
        showOverlay = false;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void toggleOverlay() {

    showOverlay = !showOverlay;


    // for hiding status bar
    // if (!showOverlay) {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // } else {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // }
    // for hiding controls
    if (showOverlay) {
      timer?.cancel();
      timer = Timer(const Duration(seconds: 7), () {
        if (showOverlay) {
          showOverlay = false;
        }
        notifyListeners();
      });
    }
    notifyListeners();
  }

  Future<void> isMuteCheck(BuildContext context) async {
    await checkAndCloseDrawer(context);
    controller.setVolume(isMute ? 100.0 : 0.0);
    isMute = !isMute;
    notifyListeners();
  }

  Future<void> checkAndCloseDrawer(BuildContext context) async {
    if (scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      Navigator.of(context).pop(); // Close the drawer
    }
  }

  Future<void> enterPiPMode() async {
    try {
      showOverlay = false;
      await platform.invokeMethod('enterPiPMode');
    } on PlatformException catch (e) {
      print("Failed to enter PiP mode: ${e.message}");
    }
    notifyListeners();
  }

  void playVideo() {
    controller.play();
    notifyListeners();
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness.instance.setScreenBrightness(brightness / 100);
    } catch (e) {
      print('Failed to set brightness: $e');
    }
  }

  void hideStatusBarTemporarily() {
    Timer.periodic((const Duration(seconds: 3)), (timer) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    });
  }
}
