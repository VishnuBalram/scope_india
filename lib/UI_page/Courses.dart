import 'package:flutter/material.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:scope_india/UI_page/ColorPage.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: backgdc,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            sectionTitle("Software Programming Courses"),
            courseButton(
                courseName: "Java Full Stack Internship",
                url: "https://scopeindia.org/java-spring-mysql-full-stack-advanced-internship-course"),
            courseButton(
                courseName: "Python Full Stack Internship",
                url: "https://scopeindia.org/python-django-sqlite-mysql-full-stack-advanced-internship-course"),
            courseButton(
                courseName: "PHP Full Stack Internship",
                url: "https://scopeindia.org/php-codeigniter-laravel-mysql-full-stack-advanced-internship-course"),
            courseButton(
                courseName: ".Net Core Full Stack Internship",
                url: "https://scopeindia.org/dot-net-core-mvc-mssql-full-stack-advanced-internship-course"),
            courseButton(
                courseName: "MERN Full Stack Internship",
                url: "https://scopeindia.org/mern-mongodb-expressjs-reactjs-nodejs-full-stack-advanced-internship-course"),
            courseButton(
                courseName: "MEAN Full Stack Internship",
                url: "https://scopeindia.org/mean-mongodb-expressjs-angularjs-nodejs-full-stack-advanced-internship-course"),
            courseButton(
                courseName: "Android/iOS Mobile App Course in Google Flutter",
                url: "https://scopeindia.org/android-ios-mobile-app-google-flutter-course"),
            courseButton(
                courseName: "Android/iOS Mobile App Course in IONIC",
                url: "https://scopeindia.org/android-ios-mobile-app-ionic-course"),
            courseButton(
                courseName: "Website Designing Course",
                url: "https://scopeindia.org/web-designing-course"),
            courseButton(
                courseName: "UI/UX Designing",
                url: "https://scopeindia.org/ui-ux-internship-course"),

            const SizedBox(height: 30),


            sectionTitle("Software Testing Courses"),
            courseButton(
                courseName: "Software Testing Advanced Course",
                url: "https://scopeindia.org/software-testing-manual-automation-advanced-internship-course"),

            const SizedBox(height: 30),


            sectionTitle("Networking, Server, & Cloud"),
            courseButton(
                courseName: "Networking, Server, & Cloud Administration",
                url: "https://scopeindia.org/networking-server-cloud-computing-internship-course"),
            courseButton(
                courseName: "AWS Architect Associate",
                url: "https://scopeindia.org/aws-certification-solutions-architect-associate-internship-course"),
            courseButton(
                courseName: "Ms Azure Cloud Administrator",
                url: "https://scopeindia.org/azure-certification-cloud-administrator-internship-course"),
            courseButton(
                courseName: "Red Hat Certified System Administrator (RHCSA)",
                url: "https://scopeindia.org/red-hat-certified-system-administrator-linux"),
            courseButton(
                courseName: "Red Hat Certified Engineer (RHCE)",
                url: "https://scopeindia.org/red-hat-certified-engineer-linux"),
            courseButton(
                courseName: "DevOps Engineer",
                url: "https://scopeindia.org/devops-certification-cloud-administrator-internship-course"),
            courseButton(
                courseName: "Cisco Certified Network Associate (CCNA)",
                url: "https://scopeindia.org/networking-ccna-internship-course"),

            const SizedBox(height: 30),


            sectionTitle("Other Courses"),
            courseButton(
                courseName: "Data Science & AI",
                url: "https://scopeindia.org/data-science-course"),
            courseButton(
                courseName: "Data Analytics",
                url: "https://scopeindia.org/data-analytics-course"),
            courseButton(
                courseName: "Digital Marketing Expert",
                url: "https://scopeindia.org/digital-marketing-course-internship"),
            courseButton(
                courseName: "Microsoft Power BI",
                url: "https://scopeindia.org/microsoft-powerbi-course"),
          ],
        ),
      ),
    );
  }


  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.yellow[700],
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }


  Widget courseButton({required String courseName, required String url}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ElevatedButton(
        onPressed: () async {
          await EasyLauncher.url(url: url, mode: Mode.platformDefault);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                courseName,
                style: TextStyle(
                  color: txtColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: txtColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
