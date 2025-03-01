import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkable/linkable.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';

import 'ColorPage.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgdc,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: backgdc,
        flexibleSpace: Container(
          height: 50,
          margin: const EdgeInsets.only(top: 25),
          child: const Image(
              image: AssetImage(
                  'Images/scope-india-logo-bird.png')),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Let's discuss your career",
                style: TextStyle(
                  color: txtColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              contactCard(
                location: 'Trivandram',
                address:
                'TC 25/1403/3, Athens Plaza SS Kovil Road, Thampanoor Trivandrum, Kerala 695001',
                phone: '9745936073',
                email: 'info@scopeindia.org',
                website: 'www.scopeindia.org',
                googleMapsUrl: "https://maps.app.goo.gl/rf2mzHUG1e2WyJt2A",
              ),
              const SizedBox(height: 30),
              contactCard(
                location: 'Kochi',
                address:
                'Vasant Nagar Rd, near JLN Metro Station, Kaloor Kochi, Kerala 682025',
                phone: '7592939481',
                email: 'kochi@scopeindia.org',
                website: 'www.scopeindia.org',
                googleMapsUrl: "https://maps.app.goo.gl/24w4deVCTVbGAF98A",
              ),
              const SizedBox(height: 30),
              contactCard(
                location: 'Nagercoil',
                address:
                'Near WCC College, Palace Rd Nagercoil, Tamil Nadu 629001',
                phone: '8075536185',
                email: 'ngl@scopeindia.org',
                website: 'www.scopeindia.org',
                googleMapsUrl: "https://maps.app.goo.gl/CVuESEwWY7KagbQL9",
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactCard({
    required String location,
    required String address,
    required String phone,
    required String email,
    required String website,
    required String googleMapsUrl,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      color: bdrColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: backgdc,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgdc,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Linkable(
              text: address,
              style: const TextStyle(color: backgdc, fontSize: 16),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(
                  Icons.call,
                  color: backgdc,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Linkable(
                  text: phone,
                  style: const TextStyle(color: backgdc, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(
                  Icons.mail_outline,
                  color: backgdc,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Linkable(
                  text: email,
                  style: const TextStyle(color: backgdc, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.earth,
                  color: backgdc,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Linkable(
                  text: website,
                  style: const TextStyle(color: backgdc, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: fillColor,
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                await EasyLauncher.url(url: googleMapsUrl);
              },
              child: const Text("Get Directions",style: TextStyle(color: txtColor),),
            ),
          ],
        ),
      ),
    );
  }
}
