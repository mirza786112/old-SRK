// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:wakelock/wakelock.dart';
//
// class VideoApptesting extends StatefulWidget {
//   const VideoApptesting({super.key});
//
//   @override
//   _VideoApptestingState createState() => _VideoApptestingState();
// }
//
// class _VideoApptestingState extends State<VideoApptesting> {
//   late BetterPlayerController _betterPlayerController;
//
//
//   @override
//   void initState() {
//     super.initState();
//     BetterPlayerConfiguration betterPlayerConfiguration =
//     const BetterPlayerConfiguration(
//       aspectRatio: 16 / 9,
//       fit: BoxFit.contain,
//       autoPlay: true,
//       looping: true,
//       handleLifecycle: true,
//       controlsConfiguration: BetterPlayerControlsConfiguration(
//         enablePip: true,
//       ),
//     );
//
//     BetterPlayerDataSource dataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       "https://cdn.ncare.live/flixhls/flixsrktv.stream/chunks.m3u8",
//     );
//
//     _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
//     _betterPlayerController.setupDataSource(dataSource);
//
//     // Enable wakelock to keep screen on
//     Wakelock.enable();
//   }
//
//   @override
//   void dispose() {
//     _betterPlayerController.dispose();
//     Wakelock.disable(); // Disable wakelock when disposing
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AspectRatio(
//           aspectRatio: 16 / 9,
//           child: BetterPlayer(controller: _betterPlayerController),
//         ),
//       ),
//     );
//   }
// }
//
// class PipControls extends StatelessWidget {
//   final BetterPlayerController controller;
//   final GlobalKey<State<StatefulWidget>> betterPlayerGlobalKey;
//
//   const PipControls({Key? key, required this.controller, required this.betterPlayerGlobalKey}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 20.0,
//       right: 20.0,
//       child: Column(
//         children: [
//           IconButton(
//             icon: Icon(Icons.fullscreen, color: Colors.white),
//             onPressed: () {
//               controller.enablePictureInPicture(betterPlayerGlobalKey);
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.close, color: Colors.white),
//             onPressed: () {
//               controller.disablePictureInPicture();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoAppA extends StatefulWidget {
  const VideoAppA({super.key});

  @override
  _VideoAppAState createState() => _VideoAppAState();
}

class _VideoAppAState extends State<VideoAppA> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}