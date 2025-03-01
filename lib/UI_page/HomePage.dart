import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scope_india/UI_page/ColorPage.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:scope_india/UI_page/ChangePassword.dart';
import 'package:scope_india/UI_page/studentProfile.dart';
import 'AboutUs.dart';
import 'ContactDetails.dart';
import 'Courses.dart';
import 'SignInPage.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
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
              image: AssetImage('Images/scope-india-logo-bird.png')),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: backgdc,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: backgdc),
              child: CircleAvatar(
                radius: 90,
                child: Image(image: AssetImage('Images/profile_pic.png')),
              ),
            ),
            _buildDrawerItem('Home', FontAwesomeIcons.house, () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomePageView()));
            }),
            _buildDrawerItem('Profile', FontAwesomeIcons.user, () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Student()));

            }),
            _buildDrawerItem('About Us', FontAwesomeIcons.earthAfrica, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const AboutUs()));
            }),
            _buildDrawerItem('Courses', FontAwesomeIcons.code, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CoursesPage()));
            }),
            _buildDrawerItem('Contact', Icons.contacts_outlined, () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ContactPage()));
            }),
            _buildDrawerItem('Change Password', FontAwesomeIcons.lockOpen, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Changepassword()));
            }),
            _buildDrawerItem('Logout', Icons.exit_to_app, ()
            async {
              try {
                await auth.FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignIn()));
              } catch (e) {
                print("Error signing out: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Error logging out. Please try again.'),backgroundColor: errorColor,elevation: 600,),
                );
              }
            }),

            Container(
              margin: const EdgeInsets.only(top: 200, left: 50),
              child: const Text(
                'Created by Vishnu Balram',
                style: TextStyle(color:txtColor),
              ),
            ),
          ],
        ),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(image: AssetImage('Images/scopePage.png')),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)
                ],
              ),
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              height: 250,
              width: 330,
              child: const Sliderimg(),
            ),
            _buildSectionCard(
              'Training',
              'You are trained under Suffix E Solutions working professionals, on-the-job training model.',
              'https://scopeindia.org/software-networking-cloud-courses-scope-india',
              'Images/traning.png',
            ),
            _buildSectionCard(
              'Internship',
              'After course completion, you will be proceeded to live projects with a 6 months experience certificate.',
              'https://scopeindia.org/software-networking-cloud-courses-scope-india',
              'Images/Internship.png',
            ),
            _buildSectionCard(
              'Grooming',
              'CV Preparation, interview Preparation, and Personality Development.',
              'https://scopeindia.org/software-networking-cloud-courses-scope-india',
              'Images/grooming.png',
            ),
            _buildSectionCard(
              'Placement',
              "Gives 100% Free Placement support to all our fellow techies through SCOPE INDIA's Placement Cell.",
              'https://scopeindia.org/scope-india-placement-cell',
              'Images/placement.png',
            ),
            const SizedBox(height: 30),
            const Column(
              children: [
                SizedBox(
                    width: 200,
                    child: Image(image: AssetImage('Images/5star.png'))),
                Text("Google 4.9 Rated Institute",
                    style: TextStyle(color: txtColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }


  ListTile _buildDrawerItem(String title, IconData icon, Function() onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: txtColor),
      ),
      trailing: Icon(icon, color: iconColor),
      onTap: onTap,
    );
  }


  Widget _buildSectionCard(String title, String description, String url, String image) {
    return GestureDetector(
      onTap: () async {
        await EasyLauncher.url(url: url);
      },
      child: Card(

        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              Image.asset(image, fit: BoxFit.cover, height: 100, width:100),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(title, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(description, style: const TextStyle(color: Colors.black87)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Sliderimg extends StatelessWidget {
  const Sliderimg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: Colors.blue,
      onPageChanged: (value) {
        debugPrint('Page changed: $value');
      },
      autoPlayInterval: 3000,
      isLoop: true,
      children: [
        Image.asset('Images/OIP1.jpg', fit: BoxFit.cover),
        Image.asset('Images/OIP2.jpg', fit: BoxFit.cover),
        Image.asset('Images/OIP3.jpg', fit: BoxFit.cover),
        Image.asset('Images/OIP4.jpg', fit: BoxFit.cover),
        Image.asset('Images/OIP5.jpg', fit: BoxFit.cover),
        Image.asset('Images/OIP6.jpg', fit: BoxFit.cover),
      ],
    );
  }
}
