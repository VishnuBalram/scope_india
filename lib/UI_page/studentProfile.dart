import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ColorPage.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  bool _isEditable = false;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController genderController;
  late TextEditingController dobController;
  late TextEditingController hobbiesController;
  late TextEditingController courseController;

  @override

  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    genderController = TextEditingController();
    dobController = TextEditingController();
    hobbiesController = TextEditingController();
    courseController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    if (currentUserEmail == null) {
      return const Scaffold(
        body: Center(child: Text("No user is logged in")),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: backgdc,
        flexibleSpace: Container(
          height: 50,
          margin: const EdgeInsets.only(top: 25),
          child: const Image(
            image: AssetImage('Images/scope-india-logo-bird.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditable ? Icons.save : Icons.edit, color: iconColor),
            onPressed: () async {
              if (_isEditable) {
                List<String> hobbiesList = hobbiesController.text.split(',');

                await FirebaseFirestore.instance
                    .collection('StudentDetails')
                    .doc(currentUserEmail)
                    .update({
                  'firstName': firstNameController.text,
                  'lastName': lastNameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  'Gender': genderController.text,
                  'DOB': dobController.text,
                  'Hobbies': hobbiesList,
                  'course': courseController.text, // Update the course field
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Student details updated!')),
                );

                setState(() {
                  _isEditable = false;
                });
              } else {
                setState(() {
                  _isEditable = !_isEditable;
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('StudentDetails')
              .where('email', isEqualTo: currentUserEmail)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No data available for the current user"));
            }

            final studentData = snapshot.data!.docs[0];

            // Initialize TextEditingController with the existing data from Firestore
            firstNameController.text = studentData['firstName'];
            lastNameController.text = studentData['lastName'];
            emailController.text = studentData['email'];
            phoneController.text = studentData['phone'];
            genderController.text = studentData['Gender'];
            dobController.text = studentData['DOB'];
            hobbiesController.text = studentData['Hobbies'].join(', ');
            courseController.text = studentData['course'];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.asset('Images/profile_pic.png', width: 100, height: 100),
                      const SizedBox(height: 10),
                      TextField(
                        controller: firstNameController,
                        decoration: const InputDecoration(labelText: 'First Name'),
                        enabled: _isEditable,
                      ),
                      TextField(
                        controller: lastNameController,
                        decoration: const InputDecoration(labelText: 'Last Name'),
                        enabled: _isEditable,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        enabled: _isEditable,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(labelText: 'Phone'),
                        enabled: _isEditable,
                        keyboardType: TextInputType.phone,
                      ),
                      TextField(
                        controller: genderController,
                        decoration: const InputDecoration(labelText: 'Gender'),
                        enabled: _isEditable,
                      ),
                      TextField(
                        controller: dobController,
                        decoration: const InputDecoration(labelText: 'Date of Birth'),
                        enabled: _isEditable,
                        keyboardType: TextInputType.datetime,
                      ),
                      TextField(
                        controller: hobbiesController,
                        decoration: const InputDecoration(labelText: 'Hobbies'),
                        enabled: _isEditable,
                      ),
                      const SizedBox(height: 10),

                      // Course Selection
                      TextField(
                        controller: courseController,
                        decoration: const InputDecoration(labelText: 'Course'),
                        enabled: _isEditable,
                      ),

                      const SizedBox(height: 10),
                      if (_isEditable)
                        ElevatedButton(
                          onPressed: () async {
                            List<String> hobbiesList = hobbiesController.text.split(',');

                            await FirebaseFirestore.instance
                                .collection('StudentDetails')
                                .doc(studentData.id)
                                .update({
                              'firstName': firstNameController.text,
                              'lastName': lastNameController.text,
                              'email': emailController.text,
                              'phone': phoneController.text,
                              'Gender': genderController.text,
                              'DOB': dobController.text,
                              'Hobbies': hobbiesList,
                              'course': courseController.text, // Update the course field
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Student details updated!')),
                            );

                            setState(() {
                              _isEditable = false;
                            });
                          },
                          child: const Text("Save Details"),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
