import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
              'Privacy Policy',
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
                      text: 'SRK TV: ',
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Privacy Policy\n\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                            "We value your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, disclose, and safeguard your information when you use our Video On Demand service."
                        ),
                        TextSpan(
                          text: '1. Information We Collect\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'We may collect the following types of information:\n\n',
                        ),
                        TextSpan(
                          text: 'a. Personal Information\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          '      •  Account Information: Name, email address, phone number, and payment information.\n      •  Profile Information: Preferences, viewing history, and saved settings.\n\n',
                        ),
                        TextSpan(
                          text: 'b. Non-Personal Information\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          '      •  Usage Data: IP address, browser type, operating system, and device information.\n      •  Cookies and Tracking Technologies: Information collected through cookies, web beacons, and other tracking technologies.\n\n',
                        ),
                        TextSpan(
                          text: '2. How We Use Your Information\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'We use the information we collect for the following purposes:\n\n',
                        ),
                        TextSpan(
                          text:
                          '     •  To Provide and Manage the Service: Create and manage your account, process payments, and provide customer support.\n     •  To Personalize Your Experience: Recommend content based on your preferences and viewing history.\n     •  To Improve Our Service: Analyze usage data to understand how our service is used and make improvements.\n     •  To Communicate with You: Send you updates, promotional offers, and other information related to the service.\n     • To Comply with Legal Obligations: Fulfill any legal obligations and respond to lawful requests.\n\n',
                        ),
                        TextSpan(
                          text: '3. How We Share Your Information\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'We may share your information with:\n\n     •  Service Providers: Third-party vendors who perform services on our behalf, such as payment processing and data analysis.\n     •  Business Partners: Partners with whom we collaborate to offer you content and services.\n     •  Legal Authorities: When required by law or in response to valid legal requests.\n\n',
                        ),
                        TextSpan(
                          text: '4. Data Security\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'We implement appropriate security measures to protect your information from unauthorized access, disclosure, alteration, and destruction. However, no method of transmission over the internet or electronic storage is 100% secure.\n\n',
                        ),
                        TextSpan(
                          text: '5. Your Choices\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'You have the following choices regarding your information:\n\n     •  Access and Update: You can access and update your account information through your account settings.\n     •  Opt-Out: You can opt-out of receiving promotional communications from us by following the unsubscribe instructions in those communications.\n     •  Cookies: You can set your browser to refuse cookies or to alert you when cookies are being sent. However, some parts of the service may not function properly without cookies.\n\n',
                        ),
                        TextSpan(
                          text: '6. Children\'s Privacy\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'Our service is not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete such information.\n\n',
                        ),
                        TextSpan(
                          text: '7. International Data Transfers\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'Your information may be transferred to and processed in countries other than your own. We take appropriate measures to ensure that your information is treated securely and in accordance with this Privacy Policy.\n\n',
                        ),
                        TextSpan(
                          text: '8. Changes to This Privacy Policy\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on our website or through the service. Your continued use of the service after any such changes constitutes your acceptance of the new Privacy Policy.\n\n',
                        ),
                        TextSpan(
                          text: '9. Contact Us\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                          'If you have any questions or concerns about this Privacy Policy, please contact us at:',
                        ),
                        TextSpan(
                          text: " app@srk.tv\n\n",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        TextSpan(
                          text: "Thank you for using our Video On Demand service!",
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