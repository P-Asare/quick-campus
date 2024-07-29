import 'package:flutter/material.dart';
import 'package:quickcampus/screens/otp_page.dart';
import 'package:quickcampus/widgets/filled_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  // Validators for each input field

  // Ensure entry of firstname
  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  // Ensure entry of lastname
  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  // Validate email format
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate password input and format
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

  // Validate password similarity
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Register user and route to homepage
  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with registration
      print('Registration successful');

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OtpPage(email: _emailController.text),
      ));
    } else {
      // Form is invalid, show errors
      print('Registration failed');
    }
  }

  void _signIn() {
    // Navigate to the sign-in page
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent, // Semi-transparent background
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign Up,",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Create an account and place a request",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 30),
                // First Name
                const Text(
                  "First Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: "Enter your first name",
                    filled: true,
                    fillColor: const Color(0x59D9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF307A59),
                        width: 2.0,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  validator: _validateFirstName,
                  cursorColor: Colors.black,
                ),
                const SizedBox(height: 20),
                // Last Name
                const Text(
                  "Last Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: "Enter your last name",
                    filled: true,
                    fillColor: const Color(0x59D9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF307A59),
                        width: 2.0,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  validator: _validateLastName,
                  cursorColor: Colors.black,
                ),
                const SizedBox(height: 20),
                // Email
                const Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
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
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF307A59),
                        width: 2.0,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  cursorColor: Colors.black,
                ),
                // Spacing
                const SizedBox(height: 20),
                // Password
                const Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
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
                        _hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: const Color.fromARGB(255, 105, 105, 105),
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0x59D9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF307A59),
                        width: 2.0,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  validator: _validatePassword,
                  cursorColor: Colors.black,
                ),
                const SizedBox(height: 20),
                // Confirm Password
                const Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _hideConfirmPassword,
                  decoration: InputDecoration(
                    hintText: "Confirm your password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hideConfirmPassword = !_hideConfirmPassword;
                        });
                      },
                      icon: Icon(
                        _hideConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color.fromARGB(255, 105, 105, 105),
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0x59D9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF307A59),
                        width: 2.0,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  validator: _validateConfirmPassword,
                  cursorColor: Colors.black,
                ),

                // spacing
                const SizedBox(height: 25),

                // Register button
                MyFilledButton(title: "Register", onPressed: () => _register()),

                // Spacing
                const SizedBox(height: 20),
                // Sign in link
                Center(
                  child: GestureDetector(
                    onTap: _signIn,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color(0xFF307A59),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
