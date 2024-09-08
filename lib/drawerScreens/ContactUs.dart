import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  final String email = 'app@srk.tv';

  Future<void> _launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    final String url = params.toString();
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching email: $e');
      // Handle error gracefully, e.g., show a dialog or snackbar
    }
  }

  _sendMail() async {

      final mailtoLink = Mailto(
        to: [email],
        subject: 'SRKtv Plus',
        body: 'how can i help you?',
      );
      // Convert the Mailto instance into a string.
      // Use either Dart's string interpolation
      // or the toString() method.
      await launch('$mailtoLink');
  }

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
              'CONTACT US',
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
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        // const TextSpan(
                        //   text: 'SRKtv Plus\n\n',
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        const TextSpan(
                          text:
                          'Please contact us with Any Queries or Comments to the bellow:\n',
                        ),
                        TextSpan(
                          text: email,
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // _launchEmail(email);
                              _sendMail();
                            },
                        ),
                      ],
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
}
