import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/screens/role_pick_page.dart';
import 'package:quickcampus/screens/verified_page.dart';
import 'package:quickcampus/services/otp_service.dart';
import 'package:quickcampus/widgets/filled_button.dart';

class OtpPage extends StatefulWidget {
  final String email;

  const OtpPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  final _codeController1 = TextEditingController();
  final _codeController2 = TextEditingController();
  final _codeController3 = TextEditingController();
  final _codeController4 = TextEditingController();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();

  @override
  void dispose() {
    _codeController1.dispose();
    _codeController2.dispose();
    _codeController3.dispose();
    _codeController4.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }

  // Automatic move to next field
  void _onCodeChanged(String value, int index) {
    if (value.isNotEmpty) {
      switch (index) {
        case 1:
          FocusScope.of(context).requestFocus(_focusNode2);
          break;
        case 2:
          FocusScope.of(context).requestFocus(_focusNode3);
          break;
        case 3:
          FocusScope.of(context).requestFocus(_focusNode4);
          break;
        case 4:
          _focusNode4.unfocus();
          // Optionally, trigger the next step after the last digit is entered
          break;
      }
    }
  }

  void _goToRolePage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RolePickPage()));
  }

  // Verify otp and move to next field
  void _verifyOTP() {
    final otpCode = _codeController1.text +
        _codeController2.text +
        _codeController3.text +
        _codeController4.text;

    print(otpCode);
    bool isValid = OTPService.verifyOTP(otpCode);

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verified successfully!')),
      );

      _goToRolePage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP! Please try again.')),
      );
    }
  }

  // Resend otp to email
  void _resendOTP() {
    OTPService.sendOTP(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Verification Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter the code that was sent to your email',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.email,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCodeTextField(_codeController1, _focusNode1, 1),
                _buildCodeTextField(_codeController2, _focusNode2, 2),
                _buildCodeTextField(_codeController3, _focusNode3, 3),
                _buildCodeTextField(_codeController4, _focusNode4, 4),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "If you didn't receive a code, ",
                  style: TextStyle(fontSize: 14),
                ),
                TextButton(
                  onPressed: () => _resendOTP(),
                  child: const Text(
                    'Resend',
                    style: TextStyle(
                      color: Color(0xFF307A59),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            MyFilledButton(
              title: "Continue",
              onPressed: () => _verifyOTP(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget to build square input fields for codes
  Widget _buildCodeTextField(
      TextEditingController controller, FocusNode focusNode, int index) {
    return SizedBox(
      width: 70,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        onChanged: (value) => _onCodeChanged(value, index),
      ),
    );
  }
}
