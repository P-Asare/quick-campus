import 'package:email_otp/email_otp.dart';

class OTPService {
  static void configure() {
    // Basic configuration
    EmailOTP.config(
      appName: 'QuickCampus',
      otpType: OTPType.numeric,
      expiry: 30000,
      emailTheme: EmailTheme.v1,
      appEmail: 'quickcampus.qc@gmail.com',
      otpLength: 4,
    );

    // Optional SMTP configuration if you have a custom SMTP server
    EmailOTP.setSMTP(
      host: 'smtp.gmail.com',
      emailPort: EmailPort.port587,
      secureType: SecureType.tls,
      username: 'quickcampus.qc@gmail.com',
      password: r"Q$7XvRG$R6yK8Q",
    );

    // Custom email template with your specified colors
    EmailOTP.setTemplate(
      template: '''
  <div style="background-color: #307A59; padding: 20px; font-family: Arial, sans-serif;">
    <div style="background-color: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
      <h1 style="color: #307A59;">{{appName}}</h1>
      <p style="color: #307A59;">Your OTP is <strong>{{otp}}</strong></p>
      <p style="color: #307A59;">This OTP is valid for 3 minutes.</p>
      <p style="color: #307A59;">Thank you for using our service.</p>
    </div>
  </div>
  ''',
    );
  }

  static void sendOTP(String email) {
    EmailOTP.sendOTP(email: email);
  }

  static bool verifyOTP(String otp) {
    return EmailOTP.verifyOTP(otp: otp);
  }
}
