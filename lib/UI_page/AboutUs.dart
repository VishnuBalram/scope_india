import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:scope_india/UI_page/ColorPage.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Text(
              "SCOPE INDIA, Your Career Partner!",
              style: TextStyle(
                color: Colors.yellow[700],
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 30),


            const Text(
              "One of India's best training destinations for software, networking, and cloud computing courses with 17 years of industrial experience.",
              style: TextStyle(
                color: txtColor,
                fontSize: 18,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),


            const Text(
              "Software, Networking, and Cloud Professional Education Centre in Kerala and Tamil Nadu from Suffix E Solutions with WORKING PROFESSIONALS oriented on-the-job TRAINING model. SCOPE INDIA provides courses for Software Programming in Python (Data Science | Artificial Intelligence | Machine Learning | Deep Learning, Data Analytics), Java, PHP, .Net, MERN, Software Testing Manual and Automation, Cloud Computing (AWS | Azure), Server Administration (MicroSoft MCSE | Linux RHCE), Networking (CCNA), DevOps, Mobile App Development in Flutter, and Digital Marketing. A Training with a 100% Trusted Job-Based Internship Model. SCOPE INDIA has a Strong Placement Cell that provides jobs to thousands of students annually. We assure you, you won't regret it after training from SCOPE INDIA!",
              style: TextStyle(
                color: txtColor,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),


            const Text(
              "This is how SCOPE INDIA can support both newbies and those experienced in the industry to upgrade their skills.",
              style: TextStyle(
                color: txtColor,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),


            SocialButton(
              imageUrl:
              'https://freelogopng.com/images/all_img/1658588965instagram-logo-png-transparent-background.png',
              label: 'Instagram',
              url: 'https://www.instagram.com/scopeindia?igsh=MWVucnF4ZXZobnlqeg==',
            ),
            const SizedBox(height: 30),


            SocialButton(
              imageUrl:
              'https://purepng.com/public/uploads/large/purepng.com-youtube-iconsymbolsiconsapple-iosiosios-8-iconsios-8-721522596145hip8d.png',
              label: 'Youtube',
              url: 'https://youtube.com/@scope_india?si=9CXszrZiaX97pMpL',
            ),
            const SizedBox(height: 30),


            Center(
              child: Column(
                children: [
                  const Image(
                    width: 200,
                    image: AssetImage('Images/5star.png'),
                  ),
                  const Text(
                    "Google 4.9 Rated Institute",
                    style: TextStyle(
                      color: txtColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}


class SocialButton extends StatelessWidget {
  final String imageUrl;
  final String label;
  final String url;

  const SocialButton({
    required this.imageUrl,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          await EasyLauncher.url(url: url, mode: Mode.platformDefault);
        },
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: bdrColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: txtColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
