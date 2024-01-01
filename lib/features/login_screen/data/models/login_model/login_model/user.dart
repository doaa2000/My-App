class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  bool? isActive;
  dynamic cityId;
  String? role;
  dynamic zoneId;
  String? nationalityId;
  String? gender;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.isActive,
    this.cityId,
    this.role,
    this.zoneId,
    this.nationalityId,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        email: json['email'] as String?,
        phoneNumber: json['phone_number'] as String?,
        isActive: json['is_active'] as bool?,
        cityId: json['city_id'] as dynamic,
        role: json['role'] as String?,
        zoneId: json['zone_id'] as dynamic,
        nationalityId: json['nationality_id'] as String?,
        gender: json['gender'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'is_active': isActive,
        'city_id': cityId,
        'role': role,
        'zone_id': zoneId,
        'nationality_id': nationalityId,
        'gender': gender,
      };
}
