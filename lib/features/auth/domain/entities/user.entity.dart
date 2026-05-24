class User {
  final String id;
  final String email;
  final bool isEmailVerified;
  final bool isProfileComplete;

  const User({
    required this.id,
    required this.email,
    this.isEmailVerified = false,
    this.isProfileComplete = false,
  });

  User copyWith({
    String? id,
    String? email,
    bool? isEmailVerified,
    bool? isProfileComplete,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }
}
