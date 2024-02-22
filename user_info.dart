// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'address_info.dart';

class UserInfo {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final DateTime? birthDate;
  final AddressInfo? address;

  UserInfo({
    this.name,
    this.email,
    this.phoneNumber,
    this.birthDate,
    this.address,
  });

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] as String?,
      email: map['email'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      birthDate: map['birthDate'] != null ? DateTime.parse(map['birthDate']) : null,
      address: map['address'] != null ? AddressInfo.fromMap(map['address']) : null,
    );
  }
}