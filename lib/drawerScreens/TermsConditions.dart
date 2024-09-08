import 'package:flutter/material.dart';


class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

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
              'Terms and Conditions',
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
              child: const Column(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Terms of Use: ',
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'SRKtv Plus\n\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'Welcome to the Network of SRK Digital Services and/or its direct and indirect subsidiaries (collectively “us,” “we,” “our”). By accessing or using our service, you agree to be bound by these Terms of Use; please read them carefully.\n\n',
                        ),
                        TextSpan(
                          text: '1. Acceptance of Terms\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'By using our service, you agree to comply with these Terms of Use and all applicable laws and regulations in Bangladesh. If you do not agree with these terms, please do not use the service.\n\n',
                        ),
                        TextSpan(
                          text: '2. Service Description\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'Our service provides live streaming of television channels and other content. Content availability may vary and change without notice.\n\n',
                        ),
                        TextSpan(
                          text: '3. User Accounts\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'You must create an account to use Premium Services. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.\n\n',
                        ),
                        TextSpan(
                          text: '4. Subscription and Fees\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'Access to certain content may require a subscription. Subscription fees are subject to change, and we will provide notice of any fee changes. You agree to pay all fees and charges associated with your account in a timely manner.\n\n',
                        ),
                        TextSpan(
                          text: '5. Content Use\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'The contents provided through our service are for personal and non-commercial use only. You may not reproduce, distribute, modify, display, perform, or otherwise use the content except as permitted under these Terms of Use.\n\n',
                        ),
                        TextSpan(
                          text: '6. Prohibited Activities\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          '     •  Unauthorized access or use of the service.\n     •  Copying, distributing, or disclosing any part of the service in any medium.\n     •  Using the service for any illegal or unauthorized purpose.\n     •  Interfering with or disrupting the integrity or performance of the service.\n\n',
                        ),
                        TextSpan(
                          text: '7. Intellectual Property\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'All content, trademarks, logos, and service marks displayed on the service are the property of their respective owners. You must not use any of these without our prior written permission.\n\n',
                        ),
                        TextSpan(
                          text: '8. Termination\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'We reserve the right to terminate or suspend your account and access to the service at our sole discretion, without notice, for conduct that we believe violates these Terms of Use or is harmful to other users of the service, us, or third parties, or for any other reason.\n\n',
                        ),
                        TextSpan(
                          text: '9. Disclaimer of Warranties\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'The service is provided on an "as is" and "as available" basis. We do not warrant that the service will be uninterrupted, error-free, or free of viruses or other harmful components.\n\n',
                        ),
                        TextSpan(
                          text: '10. Limitation of Liability\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'In no event shall we be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of the service.\n\n',
                        ),
                        TextSpan(
                          text: '11. Governing Law\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'These Terms of Use are governed by the laws of Bangladesh. Any disputes arising from or relating to these terms or the service will be subject to the exclusive jurisdiction of the courts of Bangladesh.\n\n',
                        ),
                        TextSpan(
                          text: "12. Changes to Terms\n",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'We reserve the right to modify these Terms of Use at any time. Your continued use of the service after any such changes constitutes your acceptance of the new Terms of Use.',
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