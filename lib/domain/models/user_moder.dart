class UserModel {
  String? userName;
  String? dateOfBirth;
  String? gender;
  String? phone;
  String? about;
  String? profileImage;
  String? uid;

  UserModel(
      {required this.userName,
      required this.dateOfBirth,
      required this.gender,
      required this.phone,
      required this.about,
      required this.profileImage,
      required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      about: json['about'] as String,
      profileImage: json['profileImage'] as String,
      uid: json['uid'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phone': phone,
      'about': about,
      'profileImage': profileImage,
      'uid': uid
    };
  }
}
