import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player_overlay/drawerScreens/AboutPage.dart';
import 'package:video_player_overlay/drawerScreens/ContactUs.dart';
import 'package:video_player_overlay/drawerScreens/PrivacyScreen.dart';
import 'package:video_player_overlay/drawerScreens/TermsConditions.dart';
import 'package:video_player_overlay/drawerScreens/share.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black38,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            // GestureDetector(
            //   onTap: (){
            //
            //   },
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 10),
            //     child: Row(
            //       children: [
            //         SizedBox(width: 20,),
            //         const Icon(Icons.account_circle_outlined,
            //           color: Colors.white,
            //         ),
            //         SizedBox(width: 20,),
            //         Text('Account',
            //           style: TextStyle(
            //             color: Colors.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20,),
            // const Divider(),
            // Center(
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: 60,width: 60,decoration: const BoxDecoration(color: Colors.white,shape: BoxShape.circle,image: DecorationImage(image: AssetImage('assets/applogo.png'),fit: BoxFit.cover)),
            //   ),
            // ),
            const SizedBox(height: 10,),
            const SizedBox(height: 10,),
            Focus(
              onKey: (FocusNode node, RawKeyEvent event) {
                // Handle key events
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.select ||
                      event.logicalKey == LogicalKeyboardKey.enter){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ContactPage()));
                  }
                }
                return KeyEventResult.ignored;
              },
              child: Builder(
                  builder:(context){
                    final focusNode = Focus.of(context);
                    return
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: focusNode.hasFocus?Colors.red:Colors.transparent,width: 2)),
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: const Row(
                            children: [
                              SizedBox(width: 20,),
                              Icon(Icons.contact_support,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20,),
                              Text('Contact Us',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );}
              ),
            ),
            const SizedBox(height: 10,),
            Focus(
              onKey: (FocusNode node, RawKeyEvent event) {
                // Handle key events
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.select ||
                      event.logicalKey == LogicalKeyboardKey.enter){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const AboutPage()));
                  }
                }
                return KeyEventResult.ignored;
              },
              child: Builder(
                builder:(context){
                  final focusNode = Focus.of(context);
                  return
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: focusNode.hasFocus?Colors.red:Colors.transparent,width: 2)),
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: const Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.info_outline,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20,),
                            Text('About Us',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );},
              ),
            ),
            const SizedBox(height: 10,),

            Focus(
              onKey: (FocusNode node, RawKeyEvent event) {
                // Handle key events
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.select ||
                      event.logicalKey == LogicalKeyboardKey.enter){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const TermsConditions()));
                  }
                }
                return KeyEventResult.ignored;
              },
              child: Builder(
                  builder:(context){
                    final focusNode = Focus.of(context);
                    return
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const TermsConditions()));
                        },
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: focusNode.hasFocus?Colors.red:Colors.transparent,width: 2)),
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: const Row(
                            children: [
                              SizedBox(width: 20,),
                              Icon(Icons.description_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20,),
                              Text('Terms & Conditions',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );}
              ),
            ),
            const SizedBox(height: 10,),
            Focus(
              onKey: (FocusNode node, RawKeyEvent event) {
                // Handle key events
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.select ||
                      event.logicalKey == LogicalKeyboardKey.enter){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const PrivacyPolicy()));
                  }
                }
                return KeyEventResult.ignored;
              },
              child: Builder(
                builder:(context){
                  final focusNode = Focus.of(context);
                  return
                    InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const PrivacyPolicy()));
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: focusNode.hasFocus?Colors.red:Colors.transparent,width: 2)),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: const Row(
                      children: [
                        SizedBox(width: 20,),
                        Icon(Icons.verified_user_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20,),
                        Text('Privacy Policy',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );}
              ),
            ),

            const SizedBox(height: 10,),


            const SizedBox(height: 10,),
        //    share android start

            // const Divider(),
            // const SizedBox(height: 10,),
            // const Padding(
            //   padding:  EdgeInsets.symmetric(horizontal: 30),
            //   child: Text('Share App',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10,),
            // Focus(
            //   onKey: (FocusNode node, RawKeyEvent event) {
            //     // Handle key events
            //     if (event is RawKeyDownEvent) {
            //       if (event.logicalKey == LogicalKeyboardKey.select ||
            //           event.logicalKey == LogicalKeyboardKey.enter){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const ShareAppScreen()));
            //       }
            //     }
            //     return KeyEventResult.ignored;
            //   },
            //   child: Builder(
            //     builder:(context){
            //       final focusNode = Focus.of(context);
            //       return
            //       GestureDetector(
            //       onTap: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShareAppScreen()));
            //       },
            //       child: Container(
            //         decoration: BoxDecoration(border: Border.all(color: focusNode.hasFocus?Colors.red:Colors.transparent,width: 2)),
            //         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            //         child: const Row(
            //           children: [
            //             SizedBox(width: 20,),
            //             Image(image: AssetImage('assets/ic_exo_share.png'),height: 25,width: 25,),
            //             SizedBox(width: 20,),
            //             Text('Share App',
            //               style: TextStyle(
            //                 color: Colors.white,
            //               ),
            //             ),
            //
            //           ],
            //         ),
            //       ),
            //     );}
            //   ),
            // ),

            // end
const SizedBox(height: 20,)
            // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     GestureDetector(
        //       onTap: (){
        //         // _launchUrl(provider.privacyPolicyList.first.insta);
        //       },
        //       child: Container(
        //         height: 32,
        //         width: 32,
        //         decoration: const BoxDecoration(
        //           color: Colors.white,
        //           shape: BoxShape.circle,
        //         ),
        //         alignment: Alignment.center,
        //
        //         child: const Icon(SocialIconsFlutter.instagram,
        //           size: 18,
        //         ),
        //       ),
        //     ),
        //     GestureDetector(
        //       onTap: (){
        //         // _launchWhatsApp(context,provider.privacyPolicyList.first.whatsapp);
        //       },
        //       child: Container(
        //         height: 32,
        //         width: 32,
        //         decoration: const BoxDecoration(
        //           color: Colors.white,
        //           shape: BoxShape.circle,
        //         ),
        //         alignment: Alignment.center,
        //         child:  Image.asset('assets/whatsapp.png',height: 18,width: 18,),
        //       ),
        //     ),
        //     GestureDetector(
        //       onTap: (){
        //         // _launchUrl(provider.privacyPolicyList.first.facebookLink);
        //       },
        //       child: Container(
        //         height: 32,
        //         width: 32,
        //         decoration: const BoxDecoration(
        //           color: Colors.white,
        //           shape: BoxShape.circle,
        //         ),
        //         alignment: Alignment.center,
        //         child: const Icon(SocialIconsFlutter.facebook,size: 18,),
        //       ),
        //     ),
        //     GestureDetector(
        //       onTap: (){
        //         // _launchUrl(provider.privacyPolicyList.first.youtubeLink);
        //       },
        //       child: Container(
        //         height: 32,
        //         width: 32,
        //         decoration: const BoxDecoration(
        //           color: Colors.white,
        //           shape: BoxShape.circle,
        //         ),
        //         alignment: Alignment.center,
        //         child: const Icon(SocialIconsFlutter.youtube, size: 18,),
        //       ),
        //     ),
        //     GestureDetector(
        //       onTap: (){
        //         // _launchUrl(provider.privacyPolicyList.first.linkedin);
        //       },
        //       child: Container(
        //         height: 32,
        //         width: 32,
        //         decoration: const BoxDecoration(
        //           color: Colors.white,
        //           shape: BoxShape.circle,
        //         ),
        //         alignment: Alignment.center,
        //         child: const Icon(SocialIconsFlutter.linkedin_box,size: 18,),
        //       ),
        //     ),
        //   ],
        // )
          ],
        ),
      ),
    );
  }

  // Future<void> _launchUrl(String url) async {
  //  try{
  //    if (await canLaunch(url)) {
  //      await launch(url);
  //    } else {
  //      throw 'Could not launch $url';
  //    }
  //  }catch(e){
  //    print(e.toString());
  //  }
  // }

  // void _launchWhatsApp(BuildContext context,String phoneNumber) async {
  //   String url = "https://wa.me/$phoneNumber";
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Could not launch WhatsApp.'),
  //       ),
  //     );
  //   }
  // }
}
