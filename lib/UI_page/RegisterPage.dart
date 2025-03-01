import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scope_india/UI_page/wrapper.dart';

import 'ColorPage.dart';

FirebaseAuth auth = FirebaseAuth.instance;

List<String> itemsL = ['  Male', '  Female', '  Other'];
String dropDownValue = '  Male';
String firstName = '';
String lastName = '';
String email = '';
String phone = '';
String password = '';

List<String> courses = [
  "Select course",
  "Java Full Stack Internship",
  "Python Full Stack Internship",
  "PHP Full Stack Internship",
  ".Net Core Full Stack Internship",
  "MERN Full Stack Internship",
  "MEAN Full Stack Internship",
  "Android/iOS Mobile App Course in Google Flutter",
  "Android/iOS Mobile App Course in IONIC",
  "Website Designing Course",
  "UI/UX Designing",
  "Software Testing Advanced Course",
  "Networking, Server, & Cloud Administration",
  "AWS Architect Associate",
  "Ms Azure Cloud Administrator",
  "Red Hat Certified System Administrator (RHCSA)",
  "DevOps Engineer",
  "Cisco Certified Network Associate (CCNA)",
  "Data Science & AI",
  "Data Analytics",
  "Digital Marketing Expert",
  "Microsoft Power BI",
];
String dropDownValue1 = "Select course";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff111D47),
        title: const Text(
          "Registration",
          style: TextStyle(
              color: txtColor, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _dateTimeController = TextEditingController();

  int? myVar = 1;
  String? countryValue;
  String? stateValue;
  String? cityValue;

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Enter Password';
    } else if (value.length < 5) {
      return 'Characters should not be less than 5';
    } else if (value.length > 20) {
      return 'Characters should not be greater than 20';
    }
    return null;
  }

  List<String> selectedItems = [];
  Future<void> SendVerificationLink() async {
    try {
      await auth.currentUser?.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> SendPasswordResetLink(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate = DateTime.now();
    late DateTime? pickedDate;

    Future<void> showDateTime() async {
      pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1970),
        lastDate: DateTime(2030),
        initialDate: selectedDate,
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          var formattedDate = DateFormat('dd-MM-yyy').format(pickedDate!);
          _dateTimeController.text = formattedDate;
          print('date  ${_dateTimeController.text}');
        });
      } else {
        print('Date not found');
      }
    }

    return Scaffold(
      backgroundColor: backgdc,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                // Existing code for First Name, Last Name, Gender, etc.

                // Course Dropdown
                // Course Selection

                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(color: txtColor),
                  controller: _firstnameController,
                  keyboardType: TextInputType.name,
                  autofocus: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your first name";
                    } else if (value.length < 1) {
                      return "Please check the spelling";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your first name',
                    hintStyle: const TextStyle(color: txtColor),
                    labelText: 'First Name',
                    labelStyle: const TextStyle(color: txtColor),
                    errorStyle: TextStyle(color: errorColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: errorColor),
                    ),
                  ),
                ), // First Name

                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(color: txtColor),
                  controller: _lastnameController,
                  keyboardType: TextInputType.name,
                  autofocus: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your last name";
                    } else if (value.length < 1) {
                      return "Please check the spelling";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your last name',
                    hintStyle: const TextStyle(color: txtColor),
                    labelText: 'Last Name',
                    labelStyle: const TextStyle(color: txtColor),
                    errorStyle: TextStyle(color: errorColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: errorColor),
                    ),
                  ),
                ), // Last Name
// Add Course Dropdown
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: bdrColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    dropdownColor: backgdc,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 18, color: txtColor),
                    value: dropDownValue1,
                    icon: Icon(Icons.keyboard_arrow_down,
                        size: 30, color: iconColor),
                    items: courses.map((String course) {
                      return DropdownMenuItem(
                          value: course, child: Text(course));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropDownValue1 = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),

                // Gender Dropdown
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: bdrColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    dropdownColor: backgdc,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 18, color: txtColor),
                    value: dropDownValue,
                    icon: Icon(Icons.keyboard_arrow_down,
                        size: 30, color: iconColor),
                    items: itemsL.map((String items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropDownValue = value!;
                      });
                    },
                  ),
                ), // Gender Selection

                const SizedBox(height: 15),

                // Date of Birth
                SizedBox(
                  height: 60,
                  width: 370,
                  child: TextFormField(
                    style: const TextStyle(color: txtColor),
                    controller: _dateTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgdc,
                      suffixIcon: IconButton(
                          onPressed: showDateTime,
                          icon: Icon(Icons.calendar_month_outlined,
                              color: iconColor)),
                      hintText: 'Select your date of birth',
                      hintStyle: const TextStyle(color: txtColor),
                      labelText: 'Date of Birth',
                      labelStyle: const TextStyle(color: txtColor),
                      errorStyle: TextStyle(color: errorColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: bdrColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: bdrColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: errorColor),
                      ),
                    ),
                  ),
                ), // Date of Birth

                const SizedBox(height: 15),

                // Email
                TextFormField(
                  style: const TextStyle(color: txtColor),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter email address',
                    hintStyle: const TextStyle(color: txtColor),
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: txtColor),
                    errorStyle: TextStyle(color: errorColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: errorColor),
                    ),
                  ),
                ), // Email

                const SizedBox(height: 15),

                // Phone Number
                TextFormField(
                  style: const TextStyle(color: txtColor),
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^(?:\+?\d{1,3}[-]?)?\d{10}$')
                            .hasMatch(value)) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    hintStyle: TextStyle(color: txtColor),
                    labelText: 'Mobile No',
                    labelStyle: TextStyle(color: txtColor),
                    errorStyle: TextStyle(color: errorColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: errorColor),
                    ),
                  ),
                ), // Phone Number

                const SizedBox(height: 15),

                // Country, State, City Selector
                Center(
                  child: Container(
                    height: 160,
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: bdrColor, width: 1),
                    ),
                    child: Column(
                      children: [
                        SelectState(
                          dropdownColor: backgdc,
                          style: const TextStyle(color: txtColor),
                          onCountryChanged: (value) {
                            setState(() {
                              countryValue = value;
                            });
                          },
                          onStateChanged: (value) {
                            setState(() {
                              stateValue = value;
                            });
                          },
                          onCityChanged: (value) {
                            setState(() {
                              cityValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ), // Country State City Selector

                const SizedBox(height: 15),

                // Password
                TextFormField(
                  style: const TextStyle(color: txtColor),
                  controller: _passwordController,
                  keyboardType: TextInputType.name,
                  autofocus: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Create new password";
                    } else if (value.length < 3) {
                      return "Please check the spelling";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'abc123@#*',
                    hintStyle: TextStyle(color: txtColor),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: txtColor),
                    errorStyle: TextStyle(color: errorColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bdrColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: errorColor),
                    ),
                  ),
                ), // Password

                const SizedBox(height: 15),

                // Hobbies Selection
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: bdrColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: backgdc,
                        child: MultiSelectDropdown.simpleList(
                          list: const [
                            "Fishing",
                            "Reading",
                            "Gardening",
                            "Sports",
                            "Cooking",
                            "Dancing",
                            "Hiking",
                            "Riding",
                            "Singing",
                          ],
                          textStyle: const TextStyle(color: txtColor),
                          splashColor: sltColor,
                          checkboxFillColor: fillColor,
                          whenEmpty: 'Hobbies',
                          initiallySelected: const [],
                          onChange: (selected) {
                            setState(() {
                              selectedItems = List<String>.from(selected);
                            });
                            print('Selected items: $selectedItems');
                          },
                          includeSearch: true,
                          includeSelectAll: true,
                          isLarge: true,
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${selectedItems.join(', ')}',
                        style: const TextStyle(fontSize: 16, color: txtColor),
                      ),
                    ],
                  ),
                ), // Hobbies

                const SizedBox(height: 15),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          // Create a new user
                          UserCredential newUser = await auth.createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);

                          // Add student details to Firestore
                          await _firestore.collection('StudentDetails').doc().set({
                            'firstName': _firstnameController.text,
                            'lastName': _lastnameController.text,
                            'Gender': dropDownValue,
                            'DOB': _dateTimeController.text,
                            'Hobbies': selectedItems,
                            'email': _emailController.text,
                            'phone': _phoneController.text,
                            'password': _passwordController.text, // Store the default password
                            'Country': countryValue,
                            'State': stateValue,
                            'City': cityValue,
                            'course': dropDownValue1, // Add selected course here
                          });

                          // Show the success dialog
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Registration Successful"),
                                content: const Text("You have successfully registered."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => Wrapper())); // Navigate to the next page
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        } catch (e) {
                          print("Error: $e");
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(sltColor),
                      fixedSize: MaterialStateProperty.all(const Size(200, 50)),
                      shape: MaterialStateProperty.all(StadiumBorder(
                        side: BorderSide(color: bdrColor),
                      )),
                    ),
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: txtColor),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
