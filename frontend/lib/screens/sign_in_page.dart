// Login page

import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
    final passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Text("Welcome Back,"),
          const Text("Kindly sign into your account"),

          // Form for loginning
          Form(
            child: Column(
              children: [
                // Email input
                Column(
                  children: [
                    const Text("Email"),

                    // Spacing
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
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
                            vertical: 23, horizontal: 16.0),
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
                  children: [
                    const Text("Password"),

                    // Spacing
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your password",
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
                            vertical: 23, horizontal: 16.0),
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
                      validator: _validatePassword,
                    )
                  ],
                ),

                // spacing
                const SizedBox(
                  height: 10,
                ),

                TextButton(onPressed: () {}, child: const Text("Forgot Password?"),),

                // spacing
                const SizedBox(
                  height: 30,
                ),

                
              ],
            ),
          )
        ],
      ),
    );
  }
}
