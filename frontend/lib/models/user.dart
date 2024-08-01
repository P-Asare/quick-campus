// User model file

/// Class to model a user
class User {
  int userId;
  String firstName;
  String lastName;
  String email;
  int role;
  String phoneNumber;
  String? profileImage;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
          userId: json['id'],
          firstName: json['firstname'],
          lastName: json['lastname'],
          email: json['email'],
          role: json['role'],
          phoneNumber: json['phone_number'],
          profileImage: json['profile_image']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'role': role,
      'phone_number': phoneNumber,
      'profile_image': profileImage
    };
  }
}
