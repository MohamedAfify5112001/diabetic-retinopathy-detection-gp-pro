class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? image;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      image: json['image']);

  Map<String, dynamic> get toMap => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'image': image,
      };
}
