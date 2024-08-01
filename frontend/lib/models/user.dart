// User model file

/// Class to model a user
class User {
  int userId;
  String firstName;
  String lastName;
  String email;
  String roleId;
  String phoneNumber;
  String? profileImage;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roleId,
    required this.phoneNumber,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
          userId: json['user_id'],
          firstName: json['firstname'],
          lastName: json['lastname'],
          email: json['email'],
          roleId: json['role_id'],
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
      'role_id': roleId,
      'phone_number': phoneNumber,
      'profile_image': profileImage
    };
  }
}
