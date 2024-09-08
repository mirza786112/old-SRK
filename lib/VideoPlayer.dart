import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_overlay/MyDrawer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'provider/videoProvider.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VideoProvider>(context, listen: true);
    return Align(
      alignment: Alignment.topLeft,
      child: WillPopScope(
        onWillPop: () {
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: const Text('Close App!'),
              content: const Text('You want to close app?'),
              actions: [
                Focus(
                    onKey: (FocusNode node, RawKeyEvent event) {
                      // Handle key events
                      if (event is RawKeyDownEvent) {
                        if (event.logicalKey == LogicalKeyboardKey.select ||
                            event.logicalKey == LogicalKeyboardKey.enter){
                          provider.checkAndCloseDrawer(context);
                          if(Platform.isIOS){
                            // FlutterExitApp.exitApp();
                           }else{
                            SystemNavigator.pop();
                          }
                          }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Builder(
                    builder:(context){
                      final focusNode = Focus.of(context);
                      return
                      TextButton(onPressed: (){
                        provider.checkAndCloseDrawer(context);
                        if(Platform.isIOS){
                          // FlutterExitApp.exitApp();
                        }else{
                          SystemNavigator.pop();
                        }
                      }, child:  Text('Yes',style: TextStyle(color: focusNode.hasFocus?Colors.red:Colors.black),));})),
                Focus(
                    onKey: (FocusNode node, RawKeyEvent event) {
                      // Handle key events
                      if (event is RawKeyDownEvent) {
                        if (event.logicalKey == LogicalKeyboardKey.select ||
                            event.logicalKey == LogicalKeyboardKey.enter){
                          Navigator.pop(context);}
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Builder(
                    builder:(context){
                      final focusNode = Focus.of(context);
                      return
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child:  Text('No',style: TextStyle(color: focusNode.hasFocus?Colors.red:Colors.black),));})),
              ],
            );
          });
          return Future(() => false);
        },
        child: Scaffold(
          key: provider.scaffoldKey,
          endDrawer: MyDrawer(),
          body:
              !provider.showOverlay?
          Focus(
            focusNode: FocusNode(onKey: (node, event) {
                  provider.toggleTv();
                  // node.nextFocus();
                  // provider.sliderFocus.requestFocus(provider.sliderFocus);
              return KeyEventResult.ignored;

            }

            ),
            child
                : Builder(
                  builder:(context){return Center(
                                  child:
                     Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: provider.toggleOverlay,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                         // if (provider.controller.value.isInitialized)
                          VideoPlayer(provider.controller),
                          if (provider.showOverlay && !provider.isPip)
                            Positioned(
                              bottom: 0.0,
                              child: Container(
                                padding: const EdgeInsets.only(top: 10),
                                alignment: Alignment.bottomCenter,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 2,
                                child: SvgPicture.asset(
                                  'assets/svg/Overlay-BG-Bottom.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (provider.controller.value.isBuffering)
                      const SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
                    (!provider.videoPlayError)?
                    const SizedBox()
                        :
                    (!provider.controller.value.isPlaying)?
                    const Text('This url don\'t working',style: TextStyle(color: Colors.white),):const SizedBox(),
                    if (provider.showOverlay && !provider.isPip)
                      Positioned(
                        bottom: 0.0,
                        child: iconControls(provider),
                      ),
                   // Slider for android start

                    // if (provider.showOverlay && !provider.isPip)
                    //   Positioned(
                    //     left: 0.0,
                    //     child: SizedBox(
                    //       width: 70,
                    //       height: MediaQuery.of(context).size.height,
                    //       child: verticalSlider(provider),
                    //     ),
                    //   ),
                    // end
                  ],
                                  )

                                );}
                ),
          ):
              Center(
                  child:
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: provider.toggleOverlay,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // if (provider.controller.value.isInitialized)
                            VideoPlayer(provider.controller),
                            if (provider.showOverlay && !provider.isPip)
                              Positioned(
                                bottom: 0.0,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  alignment: Alignment.bottomCenter,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height / 2,
                                  child: SvgPicture.asset(
                                    'assets/svg/Overlay-BG-Bottom.svg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (provider.controller.value.isBuffering)
                        const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(color: Colors.blue),
                        ),
                      (!provider.videoPlayError)?
                      const SizedBox()
                          :const Text('This url don\'t working',style: TextStyle(color: Colors.white),),
                      if (provider.showOverlay && !provider.isPip)
                        Positioned(
                          bottom: 0.0,
                          child: iconControls(provider),
                        ),
                      // if (provider.showOverlay && !provider.isPip)
                      //   Positioned(
                      //     left: 0.0,
                      //     child: SizedBox(
                      //       width: 70,
                      //       height: MediaQuery.of(context).size.height,
                      //       child: verticalSlider(provider),
                      //     ),
                      //   ),
                    ],
                  )

              )
        ),
      ),
    );
  }

  @override
  void dispose() {
    var provider = Provider.of<VideoProvider>(context, listen: false);
    provider.controller.dispose();
    WakelockPlus.disable(); // Ensure wakelock is disabled when disposing
    super.dispose();
  }

  Widget popUpChannels(VideoProvider provider) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 70),
      alignment: Alignment.center,
      child: Row(
        children: List.generate(provider.path.length, (index) => channelIcon(provider.path[index],provider)),
      ),
    );
  }

  Widget channelIcon(String path,VideoProvider provider) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          if (provider.controller.value.isPlaying) {
            provider.controller.pause();
          }
          provider.onVideoPlay();
          if( provider.playedUrlImagePath!=path){
            provider.initializeVideoPlayer('https://cdn.ncare.live/live-orgin/jagoronitv.stream/playlist.m3u8', true,path);
          }else{
            provider.initializeVideoPlayer('https://cdn.ncare.live/flixhls/flixsrktv.stream/chunks.m3u8', true,'');
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height/4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.only(top: 0, bottom: 20, left: 3, right: 3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child:
            provider.playedUrlImagePath!=path?
            SvgPicture.asset(
              path,
              fit: BoxFit.cover,
            ): const Image(image: AssetImage('assets/firstPlayedImage.png',),fit: BoxFit.fill,height: 80,width: 80,),
          ),
        ),
      ),
    );
  }

  Widget verticalSlider(VideoProvider provider) {
    // void moveFocusLeft() {
    //   // Implement logic to move focus to the left
    //   Focus.of(context).previousFocus();
    // }

    // void moveFocusRight() {
    //   // Implement logic to move focus to the right
    //   Focus.of(context).requestFocus(provider.closeFocus);
    // }

    void changeBrightness(double delta) {
      // Adjust brightness by delta (positive for increase, negative for decrease)
      double newBrightness = provider.brightness + delta;
      newBrightness = newBrightness.clamp(0, 100); // Ensure brightness stays within 0 to 100 range

      setState(() {
        provider.brightness = newBrightness;
      });

      provider.setBrightness(newBrightness);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Handle brightness change on up and down arrow key press
        Focus(
          focusNode: provider.closeFocus,
          onKey: (node, event) {
            if (event is RawKeyDownEvent) {
              provider.toggleTv();
              if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                if(provider.brightness<100) {
                  changeBrightness(5); // Increase brightness by 10 units
                }
                return KeyEventResult.handled;
              } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                if(provider.brightness>0){
                  changeBrightness(-5);
                } // Decrease brightness by 10 units
                return KeyEventResult.handled;
              }
              // else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              //   moveFocusLeft();
              //   return KeyEventResult.handled;
              // } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              //   moveFocusRight();
              //   return KeyEventResult.handled;
              // }
            }
            return KeyEventResult.ignored;
          },
          child: Builder(
            builder:(context){
              final focusNode = Focus.of(context);
              return
              Column(
              children: <Widget>[
                Image.asset('assets/ic_exo_brightness_low.png', height: 18, width: 18),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: (focusNode.hasFocus && MediaQuery.of(context).size.height>500) ? Colors.red : Colors.transparent,
                    ),
                  ),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 0.4,
                        overlayShape: const RoundSliderOverlayShape(),
                        tickMarkShape: SliderTickMarkShape.noTickMark,
                        rangeThumbShape: const RoundRangeSliderThumbShape(
                          elevation: 0.1,
                          enabledThumbRadius: 5,
                        ),
                        showValueIndicator: ShowValueIndicator.never,
                      ),
                      child: Slider(
                        value: provider.brightness,
                        min: 0,
                        max: 100,
                        activeColor: Colors.white.withOpacity(0.7),
                        onChanged: (value) {
                          setState(() {
                            provider.brightness = value;
                          });
                          provider.setBrightness(value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );}
          ),
        ),
      ],
    );
  }
// for tv
//   Widget iconControls(VideoProvider provider) {
//     return Container(
//       alignment: Alignment.center,
//       height: MediaQuery.of(context).size.height / 2,
//       width: MediaQuery.of(context).size.width,
//       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const SizedBox(height: 20,),
//           const SizedBox(),
//           const SizedBox(),
//           // Container(
//           //   alignment: Alignment.center,
//           //     height: MediaQuery.of(context).size.height/4,
//           //     child: popUpChannels(provider)),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//
//               // Close button for Android
//
//               // remove this sizebox when build for android
//               SizedBox(),
//               // Focus(
//               //   onKey: (FocusNode node, RawKeyEvent event) {
//               //     // Handle key events
//               //     if (event is RawKeyDownEvent) {
//               //       if (event.logicalKey == LogicalKeyboardKey.select ||
//               //           event.logicalKey == LogicalKeyboardKey.enter){
//               //         provider.checkAndCloseDrawer(context);
//               //         SystemNavigator.pop();                    }
//               //     }
//               //     return KeyEventResult.ignored;
//               //   },
//               //   child: Builder(
//               //     builder: (context){
//               //       final focusNode = Focus.of(context);
//               //       return InkWell(
//               //         onTap: () async {
//               //           await provider.checkAndCloseDrawer(context);
//               //           SystemNavigator.pop();
//               //         },
//               //         child: Container(
//               //           alignment: Alignment.center,
//               //           height: 30,
//               //           width: 70,
//               //           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3),
//               //               border: Border.all(color: focusNode.hasFocus?Colors.red:Colors.transparent,width: 2)
//               //           ),
//               //           child: const Text(
//               //             'CLOSE',
//               //             style: TextStyle(
//               //               letterSpacing: 3,
//               //               fontWeight: FontWeight.bold,
//               //               fontFamily: 'condensedBold',
//               //               fontSize: 19,
//               //             ),
//               //           ),
//               //         ),
//               //       );
//               //     }
//               //   ),
//               // ),
//               // end
//
//               Row(
//                 children: [
//                   //
// // volume button for android start
//
// //                   Focus(
// //                     onKey: (FocusNode node, RawKeyEvent event) {
// //                       // Handle key events
// //                       if (event is RawKeyDownEvent) {
// //                         provider.toggleTv();
// //                         if (event.logicalKey == LogicalKeyboardKey.select ||
// //                             event.logicalKey == LogicalKeyboardKey.enter){
// //                           provider.isMuteCheck(context);
// //                         }
// //                       }
// //                       return KeyEventResult.ignored;
// //                     },
// //                     child: Builder(
// //
// //                       builder: (context)
// //     {
// //       final focusNode = Focus.of(context);
// //       return
// //       GestureDetector(
// //                         onTap: () async {
// //                           provider.isMuteCheck(context);
// //                         },
// //                         child: Image.asset(
// //                           provider.isMute ? 'assets/ic_exo_volume_mute.png' : 'assets/ic_exo_volume_on.png',
// //                           color:focusNode.hasFocus?Colors.red: Colors.white,
// //                           height: 30,
// //                           width: 30,
// //                         ),
// //                       );},
// //                     ),
// //                   ),
//
//                   // end
//                   const SizedBox(width: 25),
//                   // this is pip mode unhidden when you build for mobile
//
//                   // Focus(
//                   //   onKey: (FocusNode node, RawKeyEvent event) {
//                   //     // Handle key events
//                   //     if (event is RawKeyDownEvent) {
//                   //       provider.toggleTv();
//                   //       if (event.logicalKey == LogicalKeyboardKey.select ||
//                   //           event.logicalKey == LogicalKeyboardKey.enter){
//                   //         provider.checkAndCloseDrawer(context);
//                   //         provider.enterPiPMode();                        }
//                   //     }
//                   //     return KeyEventResult.ignored;
//                   //   },
//                   //   child: Builder(
//                   //     builder:(context){
//                   //       final focusNode = Focus.of(context);
//                   //       return
//                   //       GestureDetector(
//                   //       onTap: () async {
//                   //         await provider.checkAndCloseDrawer(context);
//                   //         provider.enterPiPMode();
//                   //       },
//                   //       child: Image.asset(
//                   //         'assets/ic_exo_popin.png',
//                   //         color:focusNode.hasFocus?Colors.red: Colors.white,
//                   //         height: 27,
//                   //         width: 27,
//                   //       ),
//                   //     );},
//                   //   ),
//                   // ),
//                   // const SizedBox(width: 25),
//
//
//                   //end
//
//
//                   // share for android start
//                   // Focus(
//                   //   onKey: (FocusNode node, RawKeyEvent event) {
//                   //     // Handle key events
//                   //     if (event is RawKeyDownEvent) {
//                   //       provider.toggleTv();
//                   //       if (event.logicalKey == LogicalKeyboardKey.select ||
//                   //           event.logicalKey == LogicalKeyboardKey.enter){
//                   //         shareImage();                       }
//                   //     }
//                   //     return KeyEventResult.ignored;
//                   //   },
//                   //   child: Builder(
//                   //
//                   //     builder:(context){
//                   //       final focusNode = Focus.of(context);
//                   //       return GestureDetector(
//                   //       onTap: () async {
//                   //         // await provider.checkAndCloseDrawer(context);
//                   //         // Share.share('https://www.hoichoi.tv/shows/watch-buker-moddhye-agun-bengali-web-series-online');
//                   //         //
//                   //         shareImage();
//                   //         },
//                   //       child: Row(
//                   //         children: [
//                   //           Image.asset(
//                   //             'assets/ic_exo_share.png',
//                   //             color:focusNode.hasFocus?Colors.red: Colors.white,
//                   //             height: 30,
//                   //             width: 30,
//                   //           ),
//                   //           const SizedBox(
//                   //             width: 1,
//                   //           ),
//                   //            Text(
//                   //             'S H A R E',
//                   //             style: TextStyle(
//                   //               letterSpacing: 1,
//                   //               color: focusNode.hasFocus?Colors.red: Colors.white,
//                   //               fontWeight: FontWeight.bold,
//                   //               fontSize: 15,
//                   //               fontFamily: 'condensedBold',
//                   //             ),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     );},
//                   //   ),
//                   // ),
//
//                   // end
//
//                   const SizedBox(width: 15),
//                   Focus(
//                     onKey: (FocusNode node, RawKeyEvent event) {
//                       // Handle key events
//                       if (event is RawKeyDownEvent) {
//                         provider.toggleTv();
//                         if (event.logicalKey == LogicalKeyboardKey.select ||
//                             event.logicalKey == LogicalKeyboardKey.enter){
//                           provider.checkAndCloseDrawer(context);
//                           provider.scaffoldKey.currentState?.openEndDrawer();                      }
//                       }
//                       return KeyEventResult.ignored;
//                     },
//                     child: Builder(
//                         builder:(context){
//                           final focusNode = Focus.of(context);
//                           return InkWell(
//                             onTap: () async {
//                               await provider.checkAndCloseDrawer(context);
//                               provider.scaffoldKey.currentState?.openEndDrawer();
//                             },
//                             child: Icon(Icons.more_vert, color:focusNode.hasFocus?Colors.red: Colors.white),
//                           );}
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }


// for android
    Widget iconControls(VideoProvider provider) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20,),
          const SizedBox(),
          const SizedBox(),
          // Container(
          //   alignment: Alignment.center,
          //     height: MediaQuery.of(context).size.height/4,
          //     child: popUpChannels(provider)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // Close button for Android

              // remove this sizebox when build for android
// SizedBox(),
              Focus(
                onKey: (FocusNode node, RawKeyEvent event) {
                  // Handle key events
                  if (event is RawKeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.select ||
                        event.logicalKey == LogicalKeyboardKey.enter){
                      provider.checkAndCloseDrawer(context);
                      if(Platform.isIOS){
                        // FlutterExitApp.exitApp();
                      }else{
                        SystemNavigator.pop();
                      }                   }
                  }
                  return KeyEventResult.ignored;
                },
                child: Builder(
                  builder: (context){
                    final focusNode = Focus.of(context);
                    return InkWell(
                      onTap: () async {
                        await provider.checkAndCloseDrawer(context);
                        if(Platform.isIOS){
                          // FlutterExitApp.exitApp();
                        }else{
                          SystemNavigator.pop();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: focusNode.hasFocus?Colors.red:Colors.transparent,width: 2)
                        ),
                        child: const Text(
                          'CLOSE',
                          style: TextStyle(
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'condensedBold',
                            fontSize: 19,
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
              // end

              Row(
                children: [
                  //
// volume button for android start

                  Focus(
                    onKey: (FocusNode node, RawKeyEvent event) {
                      // Handle key events
                      if (event is RawKeyDownEvent) {
                        provider.toggleTv();
                        if (event.logicalKey == LogicalKeyboardKey.select ||
                            event.logicalKey == LogicalKeyboardKey.enter){
                          provider.isMuteCheck(context);
                        }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Builder(

                      builder: (context)
    {
      final focusNode = Focus.of(context);
      return
      GestureDetector(
                        onTap: () async {
                          provider.isMuteCheck(context);
                        },
                        child: Image.asset(
                          provider.isMute ? 'assets/ic_exo_volume_mute.png' : 'assets/ic_exo_volume_on.png',
                          color:focusNode.hasFocus?Colors.red: Colors.white,
                          height: 30,
                          width: 30,
                        ),
                      );},
                    ),
                  ),

                  // end
                  const SizedBox(width: 25),
                  // this is pip mode unhidden when you build for mobile

                  Focus(
                    onKey: (FocusNode node, RawKeyEvent event) {
                      // Handle key events
                      if (event is RawKeyDownEvent) {
                        provider.toggleTv();
                        if (event.logicalKey == LogicalKeyboardKey.select ||
                            event.logicalKey == LogicalKeyboardKey.enter){
                          provider.checkAndCloseDrawer(context);
                          provider.enterPiPMode();                        }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Builder(
                      builder:(context){
                        final focusNode = Focus.of(context);
                        return
                        GestureDetector(
                        onTap: () async {
                          await provider.checkAndCloseDrawer(context);
                          provider.enterPiPMode();
                        },
                        child: Image.asset(
                          'assets/ic_exo_popin.png',
                          color:focusNode.hasFocus?Colors.red: Colors.white,
                          height: 27,
                          width: 27,
                        ),
                      );},
                    ),
                  ),
                  const SizedBox(width: 25),


                  //end


                  // share for android start
                  Focus(
                    onKey: (FocusNode node, RawKeyEvent event) {
                      // Handle key events
                      if (event is RawKeyDownEvent) {
                        provider.toggleTv();
                        if (event.logicalKey == LogicalKeyboardKey.select ||
                            event.logicalKey == LogicalKeyboardKey.enter){
                          shareImage();                       }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Builder(

                      builder:(context){
                        final focusNode = Focus.of(context);
                        return GestureDetector(
                        onTap: () async {
                          // await provider.checkAndCloseDrawer(context);
                          // Share.share('https://www.hoichoi.tv/shows/watch-buker-moddhye-agun-bengali-web-series-online');
                          //
                          shareImage();
                          },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/ic_exo_share.png',
                              color:focusNode.hasFocus?Colors.red: Colors.white,
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                             Text(
                              'S H A R E',
                              style: TextStyle(
                                letterSpacing: 1,
                                color: focusNode.hasFocus?Colors.red: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: 'condensedBold',
                              ),
                            ),
                          ],
                        ),
                      );},
                    ),
                  ),

                  // end

                  const SizedBox(width: 15),
                  Focus(
                    onKey: (FocusNode node, RawKeyEvent event) {
                      // Handle key events
                      if (event is RawKeyDownEvent) {
                        provider.toggleTv();
                        if (event.logicalKey == LogicalKeyboardKey.select ||
                            event.logicalKey == LogicalKeyboardKey.enter){
                           provider.checkAndCloseDrawer(context);
                          provider.scaffoldKey.currentState?.openEndDrawer();                      }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Builder(
                      builder:(context){
                        final focusNode = Focus.of(context);
                        return InkWell(
                        onTap: () async {
                          await provider.checkAndCloseDrawer(context);
                          provider.scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Icon(Icons.more_vert, color:focusNode.hasFocus?Colors.red: Colors.white),
                      );}
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<void> shareImage() async {
    const String imageUrl = 'assets/sharePage.jpg'; // Local asset image path
    const String shareText =
        'িয় সবকিছু বাংলায় দেখতে ডাউনলোড করুন SRK TV অ্যাপ.';
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

// class _PlayPauseOverlay extends StatelessWidget {
//   const _PlayPauseOverlay({required this.controller, required this.onTap});
//
//   final VideoPlayerController controller;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<VideoProvider>(context, listen: true);
//     return Center(
//       child: GestureDetector(
//         onTap: () {
//           if (provider.controller.value.isPlaying) {
//             provider.pauseVideo();
//           } else {
//             provider.playVideo();
//           }
//         },
//         child: Icon(
//           provider.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           color: Colors.white,
//           size: 50.0,
//         ),
//       ),
//     );
//   }
// }
