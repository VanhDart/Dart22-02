

import 'district_view.dart';
import 'province_view.dart';
import 'ward_view.dart';


class AddressInfo {
  final Province? province;
  final District? district;
  final Ward? ward;
  final String? street;

  AddressInfo({
    this.province,
    this.district,
    this.ward,
    this.street,
  });

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      province: map['province'] != null ? Province.fromMap(map['province']) : null,
      district: map['district'] != null ? District.fromMap(map['district']) : null,
      ward: map['ward'] != null ? Ward.fromMap(map['ward']) : null,
      street: map['street'] as String?,
    );
  }
}
