class User {
  final String id;
  final String email;
  final bool isEmailVerified;
  final String? name;
  final String? bio;
  final String? dateOfBirth;
  final String? gender;
  final String? profileImagePath;

  const User({
    required this.id,
    required this.email,
    this.isEmailVerified = false,
    this.name,
    this.bio,
    this.dateOfBirth,
    this.gender,
    this.profileImagePath,
  });


  bool get isProfileComplete => id.isNotEmpty && email.isNotEmpty && isEmailVerified && name != null && bio != null && dateOfBirth != null && gender != null && profileImagePath != null;
  
  User copyWith({
    String? id,
    String? email,
    bool? isEmailVerified,
    bool? isProfileComplete,
      String? name,
   String? bio,
   String? dateOfBirth,
   String? gender,
   String? profileImagePath,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }
}
