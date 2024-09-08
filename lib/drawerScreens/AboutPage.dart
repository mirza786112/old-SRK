import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
              'About Us',
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
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'SRK TV\n\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:"SRK TV is the OTT/Video-on-Demand Streaming Service Application from SRK TV, a Bangladesh Govt. Approved IPTelevision Channel; managed by ‘AliBaBa Door and Home Solution’, the Reputed Business Conglomerate that Manufactures and Sells Ready-to-Assemble Furniture, Kitchen Appliances, Decorations, Interior Designs, Home Accessories and other Home Appliances). SRK TV cares to Entertain the Entire Family with Friendly Contents those are suitable for ‘Absolutely Everybody’ and ‘Anybody’"
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
