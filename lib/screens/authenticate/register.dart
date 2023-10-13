import 'package:flutter/material.dart';
import 'package:todo/services/auth.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Text(
                  "Daily Todo",
                  style: TextStyle(fontSize: 80),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Address
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email address',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  String pattern = r"\w+@\w+\..";
                                  RegExp expression = RegExp(pattern);
                                  if (value == null || value.isEmpty) {
                                    return "This field cannot be empty";
                                  } else if (!expression.hasMatch(value)) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Email address",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // Password
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field cannot be empty";
                                  } else if (value.length < 8) {
                                    return "Password connot be less than 8 digits";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = _auth.registerWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text);
                            Navigator.pop(context);
                            if (result == null) {}
                          }
                        },
                        child: const Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
