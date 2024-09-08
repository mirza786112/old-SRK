import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareAppScreen extends StatelessWidget {
  final String imageUrl = 'assets/sharePage.jpg'; // Local asset image path
  final String shareText ="প্রিয় সবকিছু বাংলায় দেখতে ডাউনলোড করুন SRK TV অ্যাপ";
      // 'SRKtv Plus অ্যাপ ডাউনলোড করে দেখুন ম্যাকগাইভার এবং প্রিয় সব অনুষ্ঠান.';

  const ShareAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return Future(() => false);
        },
        child: Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            title: const Text(
              'Share SRKtv Plus',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black26,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Image.asset(
                    imageUrl,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    shareText,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Focus(
                    onKey: (FocusNode node, RawKeyEvent event) {
                      // Handle key events
                      if (event is RawKeyDownEvent) {
                        if (event.logicalKey == LogicalKeyboardKey.select ||
                            event.logicalKey == LogicalKeyboardKey.enter){
                          shareImage(context);
                                            }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Builder(
                      builder: (context)
                      {
                        final focusNode = Focus.of(context);
                        return
                          ElevatedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.resolveWith<BorderSide>((states) {
                                if (focusNode.hasFocus) {
                                  return const BorderSide(color: Colors.red, width: 2.0);
                                } else {
                                  return const BorderSide(color: Colors.transparent);
                                }
                              }),
                            ),
                            onPressed: (){
                              shareImage(context);
                            },
                            child: const Text('Share App'),
                          );}
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> shareImage(BuildContext context) async {
    try {
      final ByteData bytes = await rootBundle.load(imageUrl);
      final Uint8List byteList = bytes.buffer.asUint8List();

      final Directory tempDir = await getTemporaryDirectory();
      final File imageFile = File('${tempDir.path}/tempImage.jpg');
      await imageFile.writeAsBytes(byteList);

      await Share.shareXFiles([XFile(imageFile.path)], text: shareText);
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing image: $e');
      }
    }
  }
}
