// Login page

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/screens/forget_password.dart';
import 'package:quickcampus/screens/sign_up_page.dart';
import 'package:quickcampus/widgets/filled_button.dart';
import 'package:quickcampus/widgets/nav_bar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      return 'Password must include a lowercase letter';
    }

    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must include an uppercase letter';
    }

    if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      return 'Password must include a number';
    }

    if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(value)) {
      return 'Password must include a special character';
    }

    return null; // Password is valid
  }

  // Log user in (route to home)
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.login(_emailController.text, _passwordController.text);

      if(authProvider.loginSuccess == false){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong email or password')),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MyNavigationBar()));
      }
      // Form is valid, proceed with login
      print('Login successful');

    } else {
      // Form is invalid, show errors
      print('Login failed');
    }
  }

  // Sign user up (route to sign up page)
  void _signUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPage()));
  }

  // Sign user up with google
  void _googleSignUp() {}

  // Forget password
  void _forgetPassword() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ForgetPassword()));
  }

  //Animated route
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // spacing
              const SizedBox(
                height: 40,
              ),

              const Text(
                "Welcome Back,",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),

              //spacing
              const SizedBox(
                height: 10,
              ),

              const Text(
                "Kindly sign into your account",
                style: TextStyle(
                  color: Color.fromARGB(178, 73, 73, 73),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),

              //spacing
              const SizedBox(
                height: 30,
              ),

              // Form for loginning
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        // Spacing
                        const SizedBox(
                          height: 10,
                        ),

                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            suffixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color.fromARGB(255, 105, 105, 105),
                            ),
                            filled: true,
                            fillColor: const Color(0x59D9D9D9),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), // Rounded corners
                              borderSide: BorderSide
                                  .none, // Removes the default border color
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 23, horizontal: 20.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(1.0), // Rounded corners
                              borderSide: const BorderSide(
                                  color: Color(0xFF307A59),
                                  width: 2.0), // Border color when focused
                            ),
                            errorStyle: const TextStyle(
                              color: Colors.red, // Custom color for error text
                              fontSize: 12, // Optional: Customize font size
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          validator: _validateEmail,
                        )
                      ],
                    ),

                    // Spacing
                    const SizedBox(
                      height: 20,
                    ),

                    // Password input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        // Spacing
                        const SizedBox(
                          height: 10,
                        ),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: _hidePassword,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              icon: Icon(
                                _hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color.fromARGB(255, 105, 105, 105),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0x59D9D9D9),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), // Rounded corners
                              borderSide: BorderSide
                                  .none, // Removes the default border color
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 23, horizontal: 20.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(1.0), // Rounded corners
                              borderSide: const BorderSide(
                                  color: Color(0xFF307A59),
                                  width: 2.0), // Border color when focused
                            ),
                            errorStyle: const TextStyle(
                              color: Colors.red, // Custom color for error text
                              fontSize: 12, // Optional: Customize font size
                            ),
                          ),
                          cursorColor: Colors.black,
                          validator: _validatePassword,
                        )
                      ],
                    ),

                    // spacing
                    const SizedBox(
                      height: 3,
                    ),

                    TextButton(
                      onPressed: () => _forgetPassword(),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF307A59),
                        ),
                      ),
                    ),

                    // spacing
                    const SizedBox(
                      height: 10,
                    ),

                    MyFilledButton(
                      title: "Login",
                      onPressed: () => _login(),
                    ), // Route to login page
                  ],
                ),
              ),

              // // Other forms of sign up
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => _signUp(), // Route to sign up page
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xFF307A59),
                          ),
                        )
                      ],
                    ),
                  )

              //     // spacing
              //     const SizedBox(
              //       height: 10,
              //     ),

              //     // or with design
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Container(
              //           height: 1,
              //           width: 100,
              //           decoration: const BoxDecoration(
              //             color: Color.fromARGB(255, 214, 214, 214),
              //           ),
              //         ),

              //         // spacing
              //         const SizedBox(
              //           width: 10,
              //         ),

              //         const Text(
              //           "Or with",
              //           style: TextStyle(
              //             color: Color.fromARGB(255, 160, 159, 159),
              //           ),
              //         ),

              //         // spacing
              //         const SizedBox(
              //           width: 10,
              //         ),

              //         // other line
              //         Container(
              //           height: 1,
              //           width: 100,
              //           decoration: const BoxDecoration(
              //             color: Color.fromARGB(255, 214, 214, 214),
              //           ),
              //         ),
              //       ],
              //     ),

              //     // spacing
              //     const SizedBox(
              //       height: 30,
              //     ),

              //     // Google login
              //     Container(
              //       height: 54,
              //       width: double.infinity,
              //       child: ElevatedButton(
              //           onPressed: () => _googleSignUp(),
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: Colors.transparent,
              //             elevation: 0,
              //             foregroundColor: Colors.black,
              //             shape: RoundedRectangleBorder(
              //               borderRadius:
              //                   BorderRadius.circular(7), // Rounded corners
              //               side: const BorderSide(
              //                 color: Colors.grey,
              //                 width: 1,
              //               ),
              //             ),
              //           ),
              //           child: const Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Image(
              //                 image: AssetImage(
              //                   'assets/images/google_logo.png',
              //                 ),
              //                 height: 24,
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 "Sign up with Google",
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                 ),
              //               ),
              //             ],
              //           )),
              //     )
                ],
              ),

              // Spacing
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
