import 'package:flutter/material.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/screens/authenticate/register.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Text(
                  "Daily Todo",
                  style: TextStyle(fontSize: 80),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 40),
                  ),
                  Form(
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
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 8),
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
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 8),
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

                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              dynamic result =
                                  await _auth.signInWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);
                              if (result == null) {
                                print("Error signing in");
                              } else {
                                print('Signed in');
                                print(result);
                                print(
                                    "email ${_emailController.text} password ${_passwordController.text}");
                              }
                            }
                          },
                          child: Text("Sign In"),
                          style: ElevatedButton.styleFrom(
                            // elevation: 0,
                            minimumSize: const Size.fromHeight(50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text('Register an account'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
