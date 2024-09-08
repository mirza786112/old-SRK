import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player_overlay/provider/videoProvider.dart';
import 'package:video_player_overlay/testing/videoAppScreen.dart';


import 'VideoPlayer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Set preferred orientations for the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoProvider()),
      ],
      child:  const MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Disable screen recording when the app is built
    // disableScreenRecording();
    return const MaterialApp(
      home:VideoApp(),
      // home: SplashScreen(),
    );
  }
}




/// Stateful widget to fetch and then display video content.


// Future<void> disableScreenRecording() async {
//   await FlutterWindowManager.addFlags(
//       FlutterWindowManager.FLAG_SECURE);
// }
