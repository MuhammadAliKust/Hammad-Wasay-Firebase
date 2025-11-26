import 'package:flutter/material.dart';
import 'package:hammad_wasay_firebase/models/user.dart';
import 'package:hammad_wasay_firebase/services/auth.dart';
import 'package:hammad_wasay_firebase/services/user.dart';
import 'package:hammad_wasay_firebase/views/login.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUP")),
      body: Column(
        children: [
          TextField(controller: nameController),
          TextField(controller: phoneController),
          TextField(controller: addressController),
          TextField(controller: emailController),
          TextField(controller: pwdController),
          SizedBox(height: 20),

          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Name cannot be empty.")),
                      );
                      return;
                    }
                    if (phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Phone cannot be empty.")),
                      );
                      return;
                    }
                    if (addressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Address cannot be empty.")),
                      );
                      return;
                    }
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email cannot be empty.")),
                      );
                      return;
                    }
                    if (pwdController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password cannot be empty.")),
                      );
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await AuthServices()
                          .registerUser(
                            email: emailController.text,
                            password: pwdController.text,
                          )
                          .then((val) async {
                            await UserServices().createUser(
                              UserModel(
                                docId: val.uid,
                                name: nameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                email: emailController.text,
                                createdAt:
                                    DateTime.now().millisecondsSinceEpoch,
                              ),
                            );
                            isLoading = false;
                            setState(() {});
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                    "User has been registered successfully",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginView(),
                                          ),
                                        );
                                      },
                                      child: Text("Okay"),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("SignUp"),
                ),
        ],
      ),
    );
  }
}
